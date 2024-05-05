from ultralytics import YOLO
from flask import Flask, Response, request, jsonify
from waitress import serve
from PIL import Image
from ultralytics.utils.checks import cv2, print_args
import numpy as np
import io
import json
from flask_sse import sse

app = Flask(__name__)
app.config["DEBUG"] = True
#app.config["REDIS_URL"] = "redis://localhost:6379"  # Adjust Redis URL if needed

# @app.route("/")
# def root():
#     """
#     Site main page handler function. (Optional)
#     :return: Content of index.html file (Optional)
#     """
#     # Serve your Flutter app UI here if needed
#     return " Flask API is Running..."


@app.route("/detect", methods=["POST"])
def detect():
    """
    Handler for real-time detection endpoint.
    :return: Stream of JSON objects with bounding boxes.
    """
    # if "image_file" not in request.files:
    #     return jsonify({"error": "Missing image file"}), 400

    image_file = request.files["image_file"]
    if image_file.filename == "":
        return jsonify({"error": "Empty image file"}), 400

    try:
        # Open image stream directly
        #image = Image.open(image_file.stream)
        # image.show()
        #image = image.resize((544, 800))
        #image.show()
        #image = image.rotate(angle=270)
        img = cv2.imread(image_file.stream)


        #cv2.imshow('Transposed Image', transposed_image)
        #cv2.waitKey(0)
        #cv2.destroyAllWindows()

        # You may need to convert the color.
        img = rotate_image(img, 360)
        img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
        image = Image.fromarray(img)

        # For reversing the operation:
        #image = np.asarray(im_pil)

        #image.show()
        print(image.height)
        print(image.width)
        boxes = detect_objects_on_image(image)
        print("Image Processed")
        return jsonify({"boxes": boxes, "image_dimensions": {"height": image.height, "width": image.width}})

    except Exception as e:
        print(f"Error processing image: {e}")
        return jsonify({"error": "Error processing image"}), 500

def detect_objects_on_image(image):
    """
    Processes a single frame from the camera stream
    and returns an array of detected objects and their bounding boxes.
    :param frame: Input image frame
    :param model: YOLO model object
    :return: Array of bounding boxes in format
        [[x1,y1,x2,y2,object_type,probability],..]
    """
    model = YOLO("best.pt")
    results = model.predict(image)
    result = results[0]
    output = []
    for box in result.boxes:
        x1, y1, x2, y2 = [
            round(x) for x in box.xyxy[0].tolist()
        ]
        class_id = box.cls[0].item()
        prob = round(box.conf[0].item(), 2)
        output.append([
            x1, y1, x2, y2, result.names[class_id], prob
        ])
    return output

def rotate_image(mat, angle):
    """
    Rotates an image (angle in degrees) and expands image to avoid cropping
    """

    height, width = mat.shape[:2]  # image shape has 3 dimensions
    image_center = (
    width / 2, height / 2)  # getRotationMatrix2D needs coordinates in reverse order (width, height) compared to shape

    rotation_mat = cv2.getRotationMatrix2D(image_center, angle, 1.)

    # rotation calculates the cos and sin, taking absolutes of those.
    abs_cos = abs(rotation_mat[0, 0])
    abs_sin = abs(rotation_mat[0, 1])

    # find the new width and height bounds
    bound_w = int(height * abs_sin + width * abs_cos)
    bound_h = int(height * abs_cos + width * abs_sin)

    # subtract old image center (bringing image back to origo) and adding the new image center coordinates
    rotation_mat[0, 2] += bound_w / 2 - image_center[0]
    rotation_mat[1, 2] += bound_h / 2 - image_center[1]

    # rotate image with the new bounds and translated rotation matrix
    rotated_mat = cv2.warpAffine(mat, rotation_mat, (bound_w, bound_h))
    return rotated_mat

# @app.route("/stream")
# def stream():
#     """
#     Event source endpoint for real-time updates.
#     :return: Server-Sent Events stream with bounding box data.
#     """
#     return sse.stream(app.asgi_app)  # Leverage flask-sse for event streaming


if __name__ == '__main__':
    app.run(host='0.0.0.0')
