from fastapi import FastAPI, File, UploadFile, Form, HTTPException
from typing import Optional
import shutil
import os
import requests
import cv2
import numpy as np
from tensorflow.keras.models import load_model

import os

# 1. Force Python to search the entire Hugging Face server for the file
MODEL_PATH = None
for root, dirs, files in os.walk('/code'):
    if 'model.h5' in files:
        MODEL_PATH = os.path.join(root, 'model.h5')
        break

# 2. If it literally cannot find it anywhere, scream loudly in the logs
if not MODEL_PATH:
    raise FileNotFoundError("CRITICAL ERROR: I searched the whole server, and model.h5 is missing!")

# 3. Load the model using the exact path it just found
model = load_model(MODEL_PATH)

app = FastAPI()

# 2. Helper function to extract and format exactly 15 frames
# 2. Helper function to extract and format exactly 15 frames
def get_15_frames(video_path):
    cap = cv2.VideoCapture(video_path)
    total_frames = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))
    step = max(1, total_frames // 15)
    frames = []
    
    for i in range(15):
        cap.set(cv2.CAP_PROP_POS_FRAMES, min(i * step, total_frames - 1))
        success, frame = cap.read()
        if success:
            # ---> NEW FIX 1: Swap colors from OpenCV BGR to AI RGB <---
            frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
            
            # Resize to match what your model expects
            frame = cv2.resize(frame, (224, 224)) 
            frames.append(frame)
        else:
            # Fallback if video is too short
            frames.append(np.zeros((224, 224, 3), dtype=np.uint8))
            
    cap.release()
    
    # ---> NEW FIX 2: Convert to numpy array and scale to [-1, 1] for MobileNetV2 <---
    frames_array = (np.array(frames) / 127.5) - 1.0 
    return frames_array

# 3. The main POST route that handles the logic
@app.post("/predict")
async def predict_violence(
    file: Optional[UploadFile] = File(None), 
    url: Optional[str] = Form(None)
):
    temp_file_path = "temp_video_input.mp4"
    
    try:
        # A. Handle File Upload
        if file:
            with open(temp_file_path, "wb") as buffer:
                shutil.copyfileobj(file.file, buffer)
            filename = file.filename
            
        # B. Handle URL
        elif url:
            response = requests.get(url, stream=True)
            if response.status_code != 200:
                raise HTTPException(status_code=400, detail="Could not download video from URL")
            
            with open(temp_file_path, "wb") as buffer:
                for chunk in response.iter_content(chunk_size=8192):
                    buffer.write(chunk)
            filename = url.split("/")[-1]
            
        else:
            raise HTTPException(status_code=400, detail="You must provide either a file or a URL")

        # C. Run the Actual AI Inference
        video_frames = get_15_frames(temp_file_path)
        
        # Add batch dimension: turns (15, 224, 224, 3) into (1, 15, 224, 224, 3)
        input_data = np.expand_dims(video_frames, axis=0)
        
        # Get predictions
        real_prediction = model.predict(input_data)
        final_result = real_prediction.tolist()

        # D. Cleanup
        if os.path.exists(temp_file_path):
            os.remove(temp_file_path)

        # E. Return Real Results
        return {
            "status": "Success",
            "source": "URL" if url else "Upload",
            "filename": filename,
            "prediction": final_result
        }

    except Exception as e:
        if os.path.exists(temp_file_path):
            os.remove(temp_file_path)
        return {"error": str(e)}