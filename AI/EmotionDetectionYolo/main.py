import cv2
from ultralytics import YOLO

model = YOLO("model/best-and-last.pt")

face_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + 'haarcascade_frontalface_default.xml')

cap = cv2.VideoCapture(0)

while True:
    ret, frame = cap.read()
    if not ret: break

    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    
    faces = face_cascade.detectMultiScale(gray, scaleFactor=1.1, minNeighbors=6, minSize=(30, 30))

    for (x, y, w, h) in faces:
        face_img = frame[y:y+h, x:x+w]
        
        results = model.predict(source=face_img, conf=0.2, imgsz=224, verbose=False)

        label = "Not Detected"
        conf_text = ""
        color = (0, 0, 255) 

        for r in results:
            if len(r.boxes) > 0:
                label = r.names[int(r.boxes[0].cls)]
                conf = r.boxes[0].conf[0]
                conf_text = f" {conf:.2f}"
                color = (0, 255, 0) 
                break 

        cv2.rectangle(frame, (x, y), (x+w, y+h), color, 2)
        cv2.putText(frame, f"{label}{conf_text}", (x, y-10), 
                    cv2.FONT_HERSHEY_SIMPLEX, 0.8, color, 2)

    cv2.imshow("Smart Emotion Detection", frame)
    if cv2.waitKey(1) & 0xFF == ord("q"): break

cap.release()
cv2.destroyAllWindows()