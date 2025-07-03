from flask import Flask, request, jsonify
from tensorflow.keras.models import load_model
import numpy as np
import cv2
import os

app = Flask(__name__)

MODEL_PATH = os.path.join(os.path.dirname(__file__), "Disease_Detection.keras")
model = load_model(MODEL_PATH)

class_names = [
    'Apple_scab',
 'Black_rot',
 'Cedar_apple_rust',
 'healthy',
 'healthy',
 'Powdery_mildew',
 'healthy',
 'Cercospora_leaf_spot Gray_leaf_spot',
 'Common_rust_',
 'Northern_Leaf_Blight',
 'healthy',
 'Black_rot',
 'Esca_(Black_Measles)',
 'Leaf_blight_(Isariopsis_Leaf_Spot)',
 'healthy',
 'Haunglongbing_(Citrus_greening)',
 'Bacterial_spot',
 'healthy',
 'Bacterial_spot',
 'healthy',
 'Early_blight',
 'Late_blight',
 'healthy',
 'healthy',
 'healthy',
 'Powdery_mildew',
 'Leaf_scorch',
 'healthy',
 'Bacterial_spot',
 'Early_blight',
 'Late_blight',
 'Leaf_Mold',
 'Septoria_leaf_spot',
 'Spider_mites Two-spotted_spider_mite',
 'Target_Spot',
 'Tomato_Yellow_Leaf_Curl_Virus',
 'Tomato_mosaic_virus',
 'healthy'
]

def preprocess_image(image):
    image = cv2.imdecode(np.frombuffer(image.read(), np.uint8), cv2.IMREAD_COLOR)
    image = cv2.resize(image, (224, 224))
    image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
    image = image.astype("float32") / 255.0
    image = np.expand_dims(image, axis=0)
    return image

@app.route('/predict', methods=['POST'])
def predict():
    if 'file' not in request.files:
        return jsonify({'error': 'No file'}), 400
    file = request.files['file']
    image = preprocess_image(file)
    prediction = model.predict(image)
    class_index = int(np.argmax(prediction))
    confidence = float(np.max(prediction))
    return jsonify({
        'class': class_names[class_index],
        'confidence': confidence
    })

if __name__ == '__main__':
    app.run(debug=True, port=4000)
