import os
# This forces TensorFlow to use the older Keras 2 backend to match Kaggle
os.environ["TF_USE_LEGACY_KERAS"] = "1"

import tensorflow as tf
from pathlib import Path

# Find the path to the model file
BASE_DIR = Path(__file__).resolve().parent.parent
MODEL_PATH = BASE_DIR / "mdl" / "model.h5"

# Load the model using Keras
model = tf.keras.models.load_model(MODEL_PATH)

def predict_data(data):
    # This uses the loaded Keras model to make a prediction
    return model.predict(data)