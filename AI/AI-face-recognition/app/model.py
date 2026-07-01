import pickle
import numpy as np
import cv2
from insightface.app import FaceAnalysis
from pathlib import Path

THRESHOLD = 0.5

EMBEDDINGS_PATH = Path("known_faces/embeddings.pkl")

CROPS_DIR = Path("crops")
CROPS_DIR.mkdir(exist_ok=True)

# Your live Hugging Face Space URL
BASE_URL = "https://ahmed-nn-face-recognition-api.hf.space"

# Load once at startup
face_app = FaceAnalysis(providers=['CPUExecutionProvider'])
face_app.prepare(ctx_id=0, det_size=(640, 640))

with open(EMBEDDINGS_PATH, "rb") as f:
    embeddings_db: dict = pickle.load(f)

db_ids = list(embeddings_db.keys())
db_matrix = np.stack(list(embeddings_db.values()))


def identify_faces(img: np.ndarray) -> dict:
    faces = face_app.get(img)

    students = []
    unknown_count = 0
    img_h, img_w = img.shape[:2]

    for face in faces:
        query_emb = face.normed_embedding

        similarities = db_matrix @ query_emb
        best_idx = int(np.argmax(similarities))
        best_score = float(similarities[best_idx])

        if best_score >= THRESHOLD:
            student_id = int(db_ids[best_idx])
            x1, y1, x2, y2 = map(int, face.bbox)

            # Expand face bbox into upper-body crop
            crop_x1 = max(0, x1 - 80)
            crop_y1 = max(0, y1 - 50)
            crop_x2 = min(img_w, x2 + 80)
            crop_y2 = min(img_h, y2 + 250)

            crop = img[crop_y1:crop_y2, crop_x1:crop_x2]
            crop_path = CROPS_DIR / f"{student_id}.jpg"
            cv2.imwrite(str(crop_path), crop)

            # 1. Print this to the Hugging Face Terminal Logs
            print(f"Saved crops/{student_id}.jpg")

            # 2. Build the full URL for the JSON response
            full_image_url = f"{BASE_URL}/crops/{student_id}.jpg"

            students.append({
                "id": student_id,
                "crop_path": full_image_url,
                "bbox": [crop_x1, crop_y1, crop_x2, crop_y2]
            })

        else:
            unknown_count += 1

    return {
        "total_people": len(faces),
        "known_count": len(students),
        "unknown_count": unknown_count,
        "students": students,
    }