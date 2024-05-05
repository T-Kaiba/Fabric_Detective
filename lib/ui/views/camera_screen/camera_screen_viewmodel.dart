import 'package:stacked/stacked.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http; // Import for http communication
import 'dart:convert'; // Import for json decoding
import 'package:flutter/material.dart'; // Import for drawing widgets
import 'package:Fabric_Detective/ui/views/display_image_screen/display_image_screen_view.dart';

enum DetectionState { stopped, started, taken, notTaken }

enum InitializedState { yes, no }

class CameraScreenViewModel extends BaseViewModel {
  List<CameraDescription> cameras = [];
  CameraController? cameraController;
  DetectionState _detectionState = DetectionState.stopped;
  DetectionState get detectionState => _detectionState;
  InitializedState _initializedState = InitializedState.yes;
  InitializedState get initializedState => _initializedState;

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    // _detectionState = DetectionState.stopped;
    cameraController = CameraController(cameras[0], ResolutionPreset.medium);

    await cameraController!.initialize();
    notifyListeners();
  }

  Future<void> startDetection() async {
    _detectionState = DetectionState.started;
    notifyListeners();
    // Replace 'http://your_backend_ip:8080/detect' with your actual URL
    // final Uri url = Uri.parse('http://your_backend_ip:5000/detect');

    // try {
    //   while (true) {
    //     // Capture a frame from the camera
    //     final XFile image = await cameraController!.takePicture();

    //     // Read the captured image data
    //     final List<int> imageBytes = await image.readAsBytes();

    //     // Prepare the request body with image data
    //     final request = http.MultipartRequest(
    //       'POST',
    //       url,
    //     );
    //     request.fields['image_file'] =
    //         imageBytes.toString(); // Avoid potential toString() issues

    //     // Send the request to the backend
    //     final response = await request.send();
    //     print(response.statusCode);

    //     // Check for successful response
    //     if (response.statusCode == 200) {
    //       // Parse the JSON response with bounding boxes
    //       final String data = await response.stream.bytesToString();
    //       final List<dynamic> boxes = jsonDecode(data);

    //       drawBoundingBoxes(boxes);
    //     } else {
    //       print('Error: ${response.reasonPhrase}');
    //     }
    //   }
    // } on PlatformException catch (error) {
    //   print('Error capturing image: $error');
    // }
  }

  Future<void> stopDetection() async {
    _initializedState = InitializedState.yes;
    _detectionState = DetectionState.stopped;
    //await cameraController?.stopImageStream(); // Stop camera stream
    notifyListeners();
  }

  Future<void> takePictureWithDetection(BuildContext context) async {
    final Uri url = Uri.parse('http://192.168.26.41:5000/detect');
    _detectionState = DetectionState.notTaken;
    _initializedState = InitializedState.no;
    notifyListeners();
    // final Uri url = Uri.parse('http:192.168.56.1:5000');
    // Capture a frame from the camera
    //final ImagePicker _picker = ImagePicker();
    final XFile image = await cameraController!.takePicture();
    final int imageSize = await image.length();

    // Prepare the request body with image data
    var request = http.MultipartRequest('POST', url);
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    request.files.add(http.MultipartFile(
      'image_file',
      image.readAsBytes().asStream(),
      imageSize,
      filename: 'image.jpg',
      //contentType: MediaType('image', 'jpeg'),
    ));
    // Send the request to the backend
    try {
      // Send the request to the backend
      print("sending request...");
      request.headers.addAll(headers);
      print("request: " + request.toString());
      final streamedResponse = await request.send();
      _detectionState = DetectionState.taken;
      notifyListeners();
      //final streamedResponse = await request.send().then((value) => print(value.statusCode));
      print(streamedResponse.statusCode);
      print("data received!!!");
      // Check for successful response
      if (streamedResponse.statusCode == 200) {
        // Parse the JSON response with bounding boxes
        final String data = await streamedResponse.stream.bytesToString();
        final Map<String, dynamic> responseMap = jsonDecode(data);
        final List<dynamic> bBoxes =
            responseMap['boxes'] as List<dynamic>; // Cast to List<dynamic>
        final Map<String, dynamic> imageDimensions =
            responseMap['image_dimensions'] as Map<String, dynamic>;
        final int imageHeight = imageDimensions['height'];
        final int imageWidth = imageDimensions['width'];

        //bBoxes = jsonDecode(data);
        print(bBoxes);
        print(imageWidth);
        print(imageHeight);
        // Navigate to DisplayImageView with arguments
        Navigator.push(
          context, // Use the provided context from the widget build method
          MaterialPageRoute(
            builder: (context) => DisplayImageView(
              imagePath: image.path,
              boxes: bBoxes,
              apiHeight: imageHeight,
              apiWidth: imageWidth,
              newHeight: 540,
              newWidth: 360,
            ),
          ),
        );
        print(image.path);
      } else {
        print('Error: ${streamedResponse.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }

    await stopDetection(); // Stop real-time detection
  }

  // Function to draw bounding boxes on the camera preview (implementation example)
  List<Widget> drawBoundingBoxes(List<dynamic> boxes) {
    List<Widget> boundingBoxes = [];
    for (var box in boxes) {
      // Extract coordinates and class ID
      final double x1 = box[0].toDouble();
      final double y1 = box[1].toDouble();
      final double x2 = box[2].toDouble();
      final double y2 = box[3].toDouble();
      final String classId = box[4];

      // Calculate box dimensions based on screen size
      final double boxWidth = x2 - x1;
      final double boxHeight = y2 - y1;

      // Define different colors for different class IDs (optional)
      final Color boxColor =
          getColorForClass(classId); // Implement getColorForClass function

      // Create a Container widget for the bounding box
      boundingBoxes.add(
        Positioned(
          top: y1,
          left: x1,
          width: boxWidth,
          height: boxHeight,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: boxColor,
                width: 2.0, // Adjust border width as needed
              ),
            ),
            child: Stack(
              // Stack for positioning the class ID label
              children: [
                // Optional: Add transparency to the box (adjust opacity as needed)
                // Container(color: boxColor.withOpacity(0.2)),

                // Text widget for class ID on top-left corner
                Positioned(
                  top: 5.0, // Adjust top padding as needed
                  left: 5.0, // Adjust left padding as needed
                  child: Text(
                    classId,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0, // Adjust font size as needed
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return boundingBoxes;
  }

// Function to define different colors based on class ID (optional)
  Color getColorForClass(String classId) {
    switch (classId) {
      case "Class1":
        return Colors.red;
      case "Class2":
        return Colors.green;
      case "Class3":
        return Colors.blue;
      default:
        return Colors.yellow; // Default color for unknown class IDs
    }
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }
}
