# Mess Crowd Monitoring & Forecasting System

## Overview

This project focuses on building a real-time system to estimate and predict crowd levels inside a mess using **computer vision and machine learning**.

The system detects people entering and exiting, maintains a live count, and uses historical data to forecast peak crowd timings. It is designed to run efficiently on edge devices, reducing dependency on cloud infrastructure.

---

## Key Features

- Real-time people counting using **YOLO + OpenCV**
- Entry/exit detection using **centroid tracking and virtual line crossing**
- Edge deployment on **Raspberry Pi**
- Crowd forecasting using **machine learning models**
- Privacy-aware system (no storage of raw video frames)

---

## System Architecture

The system works in two main stages:

### 1. Real-Time Crowd Detection

- Video input is processed frame-by-frame
- YOLO is used to detect people in each frame
- A centroid tracking algorithm assigns IDs to detected individuals
- A virtual line is used to count entries and exits
- Live crowd count is updated continuously

---

### 2. Crowd Forecasting

- Time-series data is collected from the counting system
- Features include:
  - Time of day  
  - Day of week  
  - Special events (if any)
- A **Random Forest model** is trained to predict crowd levels
- Used to estimate peak hours and assist in planning

---

## Tech Stack

- Python  
- OpenCV  
- YOLO (Object Detection)  
- scikit-learn (Random Forest)  
- Raspberry Pi (Edge Deployment)  

---

## How It Works

1. Capture video stream (camera input)
2. Detect people using YOLO
3. Track movement using centroid tracking
4. Count entries/exits using a virtual line
5. Store timestamped data
6. Train model for forecasting
7. Predict future crowd patterns

---

## Challenges Faced

- Maintaining accurate tracking in crowded scenes
- Handling occlusions and missed detections
- Optimizing performance for **Raspberry Pi**
- Balancing accuracy vs speed for real-time inference

---

## Key Learnings

- Learned how to build an **end-to-end computer vision pipeline**
- Understood challenges of **real-time systems on edge devices**
- Gained experience with **feature engineering and forecasting**
- Explored trade-offs between **model accuracy and system performance**

---

## Future Improvements

- Use more advanced tracking methods (e.g., DeepSORT)
- Improve forecasting using time-series models (LSTM, ARIMA)
- Add dashboard for live visualization
- Optimize model further for edge deployment

---

## Notes

- Designed with practical deployment in mind
- Can be extended to other use-cases like footfall analytics, queue management, etc.
