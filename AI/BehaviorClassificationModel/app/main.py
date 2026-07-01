# from fastapi import FastAPI, HTTPException
# from pydantic import BaseModel
# import numpy as np
# import requests
# import cv2
# from app.inference import load_model, predict_embedding
# import os
# from deepface import DeepFace 

# app = FastAPI()

# @app.on_event("startup")
# def startup_event():
#     load_model()

# class URLRequest(BaseModel):
#     url: str

# @app.post("/predict-universal")
# async def predict_universal(request: URLRequest):
#     try:
#         if request.url.startswith("http"):
#             final_url = request.url
#             if "drive.google.com" in request.url:
#                 file_id = request.url.split('/')[-2] if '/file/d/' in request.url else ""
#                 if file_id:
#                     final_url = f"https://drive.google.com/uc?export=download&id={file_id}"
            
#             response = requests.get(final_url, timeout=10)
#             if response.status_code != 200:
#                 return {"status": "error", "message": "Link not accessible"}
#             image_bytes = response.content
#         else:
#             if os.path.exists(request.url):
#                 with open(request.url, "rb") as f:
#                     image_bytes = f.read()
#             else:
#                 return {"status": "error", "message": "Local file not found"}

#         arr = np.asarray(bytearray(image_bytes), dtype=np.uint8)
#         img = cv2.imdecode(arr, cv2.IMREAD_COLOR)

#         objs = DeepFace.represent(img, model_name="Facenet", enforce_detection=False)
#         if not objs:
#             return {"status": "error", "message": "No face found"}

#         embedding = np.array(objs[0]["embedding"]).astype('float32').reshape(1, -1)

#         label_index, confidence = predict_embedding(embedding)
#         classes = ['Turning_Around','Looking_Forward','Standing','Reading','Raising_Hand','Writting','Sleeping']
#         return {
#             "behavior": classes[label_index],
#             "confidence": round(float(confidence), 4),
#             "source": "URL" if request.url.startswith("http") else "Local File"
#         }

#     except Exception as e:
#         raise HTTPException(status_code=500, detail=str(e))

from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import numpy as np
import requests
import cv2
import os
import torch
import torch.nn as nn
import joblib
from deepface import DeepFace

app = FastAPI()

class BehaviorClassifier(nn.Module):
    def __init__(self, input_size, num_classes):
        super(BehaviorClassifier, self).__init__()
        self.fc1 = nn.Linear(input_size, 128)
        self.relu = nn.ReLU()
        self.dropout = nn.Dropout(0.3)
        self.fc2 = nn.Linear(128, num_classes)
    
    def forward(self, x):
        x = self.fc1(x)
        x = self.relu(x)
        x = self.dropout(x)
        x = self.fc2(x)
        return x

model = None
scaler = None
classes = ['Turning_Around', 'Looking_Forward', 'Standing', 'Reading', 'Raising_Hand', 'Writting', 'Sleeping']

@app.on_event("startup")
def load_assets():
    global model, scaler
    # Load the Model
    input_size = 128  # Facenet output size
    model = BehaviorClassifier(input_size, len(classes))
    
    # Path to your .pth file - adjust if your folder is different
    model_path = "models/behavior_classifier.pth" 
    if os.path.exists(model_path):
        model.load_state_dict(torch.load(model_path, map_location=torch.device('cpu')))
        model.eval()
    else:
        print(f"ERROR: Model file not found at {model_path}")

    # Load the Scaler (The "Analysis" part your mentor wanted)
    scaler_path = "models/scaler.pkl"
    if os.path.exists(scaler_path):
        scaler = joblib.load(scaler_path)
    else:
        print("WARNING: scaler.pkl not found. Analysis might be inaccurate.")

class URLRequest(BaseModel):
    url: str

@app.get("/")
def read_root():
    return {"status": "Online", "message": "Behavior Analysis API is running. Go to /docs for testing."}

@app.post("/predict-universal")
async def predict_universal(request: URLRequest):
    try:
        if request.url.startswith("http"):
            final_url = request.url
            if "drive.google.com" in request.url:
                file_id = request.url.split('/')[-2] if '/file/d/' in request.url else ""
                if file_id:
                    final_url = f"https://drive.google.com/uc?export=download&id={file_id}"
            
            response = requests.get(final_url, timeout=10)
            if response.status_code != 200:
                return {"status": "error", "message": "Link not accessible"}
            image_bytes = response.content
        else:
            if os.path.exists(request.url):
                with open(request.url, "rb") as f:
                    image_bytes = f.read()
            else:
                return {"status": "error", "message": "Local file not found"}

        arr = np.asarray(bytearray(image_bytes), dtype=np.uint8)
        img = cv2.imdecode(arr, cv2.IMREAD_COLOR)
        
        objs = DeepFace.represent(img, model_name="Facenet", enforce_detection=False)
        if not objs:
            return {"status": "error", "message": "No face detected in image"}
        
        embedding = np.array(objs[0]["embedding"]).reshape(1, -1)

        if scaler:
            embedding = scaler.transform(embedding)
        
        embedding_tensor = torch.tensor(embedding, dtype=torch.float32)
        
        with torch.no_grad():
            outputs = model(embedding_tensor)
            probabilities = torch.nn.functional.softmax(outputs, dim=1)
            confidence, predicted = torch.max(probabilities, 1)

        return {
            "behavior": classes[predicted.item()],
            "confidence": round(float(confidence.item()), 4),
            "analysis_status": "Complete with Scaling" if scaler else "Partial (Missing Scaler)",
            "source": "URL" if request.url.startswith("http") else "Local File"
        }

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Analysis Error: {str(e)}")