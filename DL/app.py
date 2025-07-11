import os
from flask import Flask, request, jsonify
from ultralytics import YOLO
from werkzeug.utils import secure_filename

app = Flask(__name__)

MODEL_PATH = "my_model.pt"
model = YOLO(MODEL_PATH)

CLASSES = model.names
TREE_CLASS_NAME = 'Tree'

@app.route("/", methods=["GET"])
def home():
    return jsonify({"message": "YOLO Object Detection API is running!"})

@app.route("/predict", methods=["POST"])
def predict():
    if "file" not in request.files:
        return jsonify({"error": "No file uploaded"}), 400

    file = request.files["file"]
    if file.filename == "":
        return jsonify({"error": "No selected file"}), 400

    filename = secure_filename(file.filename)
    filepath = os.path.join("temp", filename)
    os.makedirs("temp", exist_ok=True)
    file.save(filepath)

    results = model(filepath)

    detected_classes = set()

    for box in results[0].boxes:
        class_id = int(box.cls[0])
        class_name = CLASSES[class_id]
        detected_classes.add(class_name)

    if len(detected_classes) == 1 and TREE_CLASS_NAME in detected_classes:
        result = {"label": "Tree"}
    else:
        result = {"label": "No tree"}

    os.remove(filepath)

    return jsonify(result)


if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=4001)
