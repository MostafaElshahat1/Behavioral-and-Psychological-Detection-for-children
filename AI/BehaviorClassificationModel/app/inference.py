import torch
import numpy as np
from app.model import BehaviorClassifier
import os
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
model = None

def load_model():
    model_path = os.path.join("models", "behavior_classifier.pth")
    checkpoint = torch.load(model_path, map_location=device)
    global model
    checkpoint = torch.load("models/behavior_classifier.pth", map_location=device)

    model = BehaviorClassifier(
        input_dim=checkpoint["input_dim"],
        num_classes=checkpoint["num_classes"]
    )

    model.load_state_dict(checkpoint["model_state_dict"])
    model.to(device)
    model.eval()

def predict_embedding(embedding: np.ndarray):
    with torch.no_grad():
        x = torch.tensor(embedding, dtype=torch.float32).to(device)
        logits = model(x)
        probs = torch.softmax(logits, dim=1)
        conf, pred = torch.max(probs, dim=1)

    return pred.item(), conf.item()
