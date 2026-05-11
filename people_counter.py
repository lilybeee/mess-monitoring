import cv2
import threading
import requests
import time
import argparse
import datetime
from ultralytics import YOLO
from picamera2 import Picamera2

# --- CONFIGURATION ---
RAILWAY_URL = "https://web-production-6bab62.up.railway.app"

def get_current_context():
    """
    Maps current time/day to your Neon database IDs.
    """
    now = datetime.datetime.now(datetime.timezone.utc)
    day_of_week = now.isoweekday() # Monday=1, Sunday=7
    hour = now.hour
    minute = now.minute

    # Calculate time as float for 30-minute precision (7:30 = 7.5)
    current_time = hour + (minute / 60)

    # 1. Determine Meal ID (Breakfast=1, Lunch=2, Snacks=3, Dinner=4)
    # Breakfast now starts at 7:30 AM
    if 7.5 <= current_time < 10.0:
        meal_id = 1
    elif 12.0 <= current_time < 14.5:
        meal_id = 2
    elif 16.0 <= current_time < 18.0:
        meal_id = 3
    elif 19.0 <= current_time < 21.0:
        meal_id = 4
    else:
        meal_id = 2 # Default to Lunch if outside hours

    # 2. Determine Menu ID (Logic based on your database schema)
    menu_id = ((day_of_week - 1) * 4) + meal_id

    # 3. Determine Day Type ID
    day_type_id = 4 if day_of_week > 5 else 1 # 4=Holiday for Sat/Sun, else 1=Normal

    return menu_id, day_type_id

def send_data_to_server(count, day_id):
    """Background function to POST data to Railway."""
    try:
        params = {
            "count": count,
            "day_type_id": day_id
        }
        response = requests.post(f"{RAILWAY_URL}/ingest", params=params, timeout=10)

        if response.status_code == 200:
            ts = datetime.datetime.now().strftime('%H:%M:%S')
            print(f"[{ts}] Sync Success: {count} people")
        else:
            print(f"Server Error: {response.status_code}")
    except Exception as e:
        print(f"Network Error: {e}")

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--line-offset", type=int, default=0)
    parser.add_argument("--confidence", type=float, default=0.5)
    args = parser.parse_args()

    print("Initializing Camera and YOLO (Headless Mode)...")
    model = YOLO("yolov8n.pt")

    picam2 = Picamera2()
    config = picam2.create_video_configuration(main={"size": (640, 480)})
    picam2.configure(config)
    picam2.start()

    track_history = {}
    count_in = 0
    count_out = 0
    last_sync_time = time.time()

    print("System Live. Press Ctrl+C to stop.")

    try:
        slope = -3
        intercept_offset = args.line_offset
        base_c = 1100
        
        while True:
            # 1. Capture Frame
            frame_rgb = picam2.capture_array()
            
            if frame_rgb is None:
                continue
            
            frame = cv2.cvtColor(frame_rgb, cv2.COLOR_RGB2BGR)

            h, w = frame.shape[:2]
            line_x = (w // 2) + args.line_offset
            #slope = 0.15
            #intercept_offset = args.line_offset

            #base_c = (w // 2) + intercept_offset

            # 2. YOLO Tracking
            results = model.track(
                frame,
                persist=True,
                classes=0,
                conf=args.confidence,
                imgsz=320,
                tracker="bytetrack.yaml",
                verbose=False
            )

            # 3. Process Detections
            if results and results[0].boxes.id is not None:
                boxes = results[0].boxes.xyxy.cpu()
                track_ids = results[0].boxes.id.int().cpu().tolist()

                for box, track_id in zip(boxes, track_ids):
                    x1, y1, x2, y2 = box
                    cx = int((x1 + x2) / 2)
                    cy = int(y2)

                    current_line_x = int((slope * cy) + base_c)

                    # Crossing Logic
                    if track_id in track_history:
                        prev_x, prev_line_x = track_history[track_id]
                        if prev_x < prev_line_x and cx >= current_line_x:
                            count_in += 1
                        elif prev_x > prev_line_x and cx <= current_line_x:
                            count_out += 1
                    
                    track_history[track_id] = (cx, current_line_x)

            current_occupancy = max(0, count_in - count_out)

            # 4. Periodic Data Sync (Every 120 seconds)
            if time.time() - last_sync_time > 120:
                m_id, d_id = get_current_context()

                # Run sync in background thread
                sync_thread = threading.Thread(
                    target=send_data_to_server,
                    args=(current_occupancy, d_id),
                    daemon=True
                )
                sync_thread.start()
                last_sync_time = time.time()

            # 5. Headless Cleanup & Terminal Status
            # (cv2.imshow removed to prevent X11 errors)
            if len(track_history) > 50:
                recent_ids = list(track_history.keys())[-50:]
                track_history = {k: track_history[k] for k in recent_ids}

            # Optional: Print live occupancy to terminal every 10 seconds
            if int(time.time()) % 10 == 0:
                print(f"Live Occupancy: {current_occupancy} (In: {count_in}, Out: {count_out})", end='\r')

            time.sleep(0.01) # Small delay to save CPU power

    except KeyboardInterrupt:
        print("\nStopping script...")
    finally:
        print("Closing System...")
        picam2.stop()

if __name__ == "__main__":
    main()
