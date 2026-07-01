import os
import cv2
import numpy as np
import requests
import mimetypes
from typing import Dict, Any
from fastapi import FastAPI, HTTPException, BackgroundTasks
from pydantic import BaseModel, HttpUrl
from ultralytics import YOLO

app = FastAPI(
    title="Emotion Detection YOLO API",
    description="Analyze emotions from an image or video URL on Hugging Face Spaces"
)

try:
    model = YOLO("best-and-last.pt")
    face_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + 'haarcascade_frontalface_default.xml')
except Exception as e:
    print(f"Error loading models: {e}")

class AnalyzeRequest(BaseModel):
    url: HttpUrl

def cleanup_file(filepath: str):
    """Background task to remove the downloaded media asset after inference."""
    if os.path.exists(filepath):
        try:
            os.remove(filepath)
        except Exception as e:
            print(f"Error deleting temporary file {filepath}: {e}")

def download_file(url: str) -> str:
    """Downloads an internet file securely and returns its local path."""
    local_filename = os.path.basename(url).split("?")[0]
    if not local_filename or "." not in local_filename:
        local_filename = "downloaded_media"

    try:
        with requests.get(url, stream=True, timeout=30) as r:
            r.raise_for_status()
            
            content_type = r.headers.get('content-type', '')
            if '.' not in local_filename:
                ext = mimetypes.guess_extension(content_type) or ''
                local_filename += ext
                
            with open(local_filename, 'wb') as f:
                for chunk in r.iter_content(chunk_size=8192):
                    f.write(chunk)
        return local_filename
    except Exception as e:
        raise HTTPException(status_code=400, detail=f"Failed to fetch file from URL: {str(e)}")

@app.get("/")
async def root():
    return {"status": "running", "message": "Emotion Detection API is Live"}

@app.post("/analyze")
async def analyze_url(payload: AnalyzeRequest, background_tasks: BackgroundTasks) -> Dict[str, Any]:
    url_str = str(payload.url)
    
    local_path = download_file(url_str)
    
    background_tasks.add_task(cleanup_file, local_path)
    
    mime_type, _ = mimetypes.guess_type(local_path)
    is_video = mime_type and mime_type.startswith('video')
    
    try:
        if is_video:
            results = model.predict(source=local_path, conf=0.25, stream=True, verbose=False)
            
            video_summary = []
            for frame_idx, r in enumerate(results):
                if len(r.boxes) > 0:
                    frame_detections = []
                    for box in r.boxes:
                        x1, y1, x2, y2 = box.xyxy[0].tolist()
                        label = r.names[int(box.cls)]
                        conf = float(box.conf[0])
                        
                        frame_detections.append({
                            "emotion": label,
                            "confidence": round(conf, 2),
                            "bbox": {"x": int(x1), "y": int(y1), "w": int(x2-x1), "h": int(y2-y1)}
                        })
                    
                    video_summary.append({
                        "frame_index": frame_idx,
                        "detections": frame_detections
                    })
                    
            return {
                "media_type": "video",
                "total_frames_with_detections": len(video_summary),
                "results": video_summary
            }
            
        else:
            frame = cv2.imread(local_path)
            if frame is None:
                raise HTTPException(status_code=400, detail="Downloaded asset could not be decoded as an image.")
            
            gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
            
            faces = face_cascade.detectMultiScale(gray, scaleFactor=1.1, minNeighbors=5, minSize=(30, 30))
            
            detections = []
            
            for (x, y, w, h) in faces:
                face_img = frame[y:y+h, x:x+w]
                
                results = model.predict(source=face_img, conf=0.20, imgsz=224, verbose=False)
                
                detected_emotion = "Not Detected"
                detected_conf = 0.0
                
                for r in results:
                    if len(r.boxes) > 0:
                        detected_emotion = r.names[int(r.boxes[0].cls)]
                        detected_conf = float(r.boxes[0].conf[0])
                        break
                
                detections.append({
                    "emotion": detected_emotion,
                    "confidence": round(detected_conf, 2),
                    "bbox": {
                        "x": int(x), 
                        "y": int(y), 
                        "w": int(w), 
                        "h": int(h)
                    }
                })
                    
            return {
                "media_type": "image",
                "student_count": len(detections),
                "results": detections
            }
            
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Inference error encounter: {str(e)}")

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=7860)