import cv2
from ultralytics import YOLO
import argparse
from collections import defaultdict

def main():
    parser = argparse.ArgumentParser(description="People Counter using YOLOv8 and OpenCV")
    parser.add_argument("--source", type=str, default="0")
    parser.add_argument("--line-offset", type=int, default=0)
    parser.add_argument("--confidence", type=float, default=0.5)
    args = parser.parse_args()

    print("Loading YOLO model...")
    model = YOLO("yolov8n.pt")
    print("Model loaded successfully.")

    try:
        source = int(args.source)
    except ValueError:
        source = args.source

    cap = cv2.VideoCapture(source)

    if not cap.isOpened():
        print("Error: Could not open video source")
        return

    track_history = {}
    track_state = {}

    count_in = 0
    count_out = 0

    print("Starting tracking. Press 'q' to quit.")

    while cap.isOpened():
        success, frame = cap.read()
        if not success:
            break

        frame = cv2.resize(frame, (640, 480))
        h, w = frame.shape[:2]

        # Vertical line
        line_x = (w // 2) + args.line_offset

        # Run tracking with ByteTrack
        results = model.track(
            frame,
            persist=True,
            classes=0,
            conf=args.confidence,
            iou=0.5,
            tracker="bytetrack.yaml",
            verbose=False
        )

        # Draw default line
        cv2.line(frame, (line_x, 0), (line_x, h), (0, 0, 255), 2)

        if results[0].boxes.id is not None:
            boxes = results[0].boxes.xyxy.cpu()
            track_ids = results[0].boxes.id.int().cpu().tolist()

            for box, track_id in zip(boxes, track_ids):
                x1, y1, x2, y2 = box
                cx = int((x1 + x2) / 2)
                cy = int((y1 + y2) / 2)

                # Draw bounding box
                cv2.rectangle(frame, (int(x1), int(y1)),
                              (int(x2), int(y2)), (0, 255, 0), 2)
                cv2.circle(frame, (cx, cy), 5, (255, 0, 255), -1)

                cv2.putText(frame, f"ID: {track_id}",
                            (int(x1), int(y1) - 10),
                            cv2.FONT_HERSHEY_SIMPLEX,
                            0.5, (0, 255, 0), 2)

                if track_id not in track_state:
                    track_state[track_id] = None

                if track_id in track_history:
                    prev_x = track_history[track_id]

                    # Robust crossing check (handles fast jumps)
                    crossed = (prev_x - line_x) * (cx - line_x) < 0

                    if crossed:
                        # LEFT → RIGHT
                        if cx > prev_x and track_state[track_id] != "in":
                            count_in += 1
                            track_state[track_id] = "in"
                            print(f"Person {track_id} IN | Total: {count_in}")
                            cv2.line(frame, (line_x, 0), (line_x, h), (0, 255, 0), 4)

                        # RIGHT → LEFT
                        elif cx < prev_x and track_state[track_id] != "out":
                            count_out += 1
                            track_state[track_id] = "out"
                            print(f"Person {track_id} OUT | Total: {count_out}")
                            cv2.line(frame, (line_x, 0), (line_x, h), (255, 0, 0), 4)

                track_history[track_id] = cx

        cv2.putText(frame, f"IN: {count_in}", (20, 40),
                    cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 3)
        cv2.putText(frame, f"OUT: {count_out}", (20, 80),
                    cv2.FONT_HERSHEY_SIMPLEX, 1, (255, 0, 0), 3)

        cv2.imshow("People Counter", frame)

        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

    cap.release()
    cv2.destroyAllWindows()

if __name__ == "__main__":
    main()
