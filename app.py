import os

from flask import Flask, request
from machine import get_image_with_landmarks

app = Flask(__name__)


# if __name__ == '__main__':
#     app.run(host='110.138.82.245', port=5000, debug=True, threaded=False)


@app.route("/")
def hello_world():
    return "<p>Welcome to Flask, Ardith!</p>"


stores = [{"name": "My Store", "items": [{"name": "my item", "price": 15.99}]}]


@app.get("/store")
def get_stores():
    return {"stores": stores}


@app.post("/face_recog")
def face_recog():
    image = request.json["image"]
    result_from_landmarks = get_image_with_landmarks(image, [])
    return result_from_landmarks
    # os.remove(path)


if __name__ == "__main__":
    # from waitress import serve
    # serve(app, host="0.0.0.0", port=8080)

    port = int(os.environ.get('PORT', 8080))
    app.run(debug=True, host='0.0.0.0', port=port)
