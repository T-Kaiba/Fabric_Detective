import 'package:Fabric_Detective/ui/views/main_screen/mainscreen_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'display_image_screen_viewmodel.dart';
import 'package:Fabric_Detective/ui/common/chi_router.dart';
import 'package:Fabric_Detective/ui/views/camera_screen/camera_screen_view.dart';
import 'dart:io' as io;

class DisplayImageView extends StackedView<DisplayImageViewModel> {
  final String imagePath;
  final List<dynamic> boxes;
  final int apiHeight;
  final int apiWidth;
  final int newHeight;
  final int newWidth;
  const DisplayImageView(
      {Key? key,
      required this.imagePath,
      required this.boxes,
      required this.apiHeight,
      required this.apiWidth,
      required this.newHeight,
      required this.newWidth})
      : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    DisplayImageViewModel viewModel,
    Widget? child,
  ) {
    //final imageFile = File(imagePath); // Create a File
    //final imageFile = io.File(imagePath);

    return Scaffold(
      appBar: AppBar(
        //backgroundColor: const Color.fromARGB(255, 64, 24, 131),
        title: Text(
          'View Results',
          style: TextStyle(color: Color.fromARGB(255, 64, 24, 131)),
        ),
      ),
      //backgroundColor: const Color.fromARGB(255, 64, 24, 131),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg-homepage-fd.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            FutureBuilder<void>(
              future: Future.delayed(const Duration(
                  milliseconds: 500)), // Simulate image loading delay
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    height: 540,
                    width: 360,
                    child: Stack(
                      children: [
                        Center(
                          child: Image.file(
                            io.File(imagePath),
                            errorBuilder: (context, error, stackTrace) =>
                                Text('Error: $error'),
                          ),
                        ),
                        Positioned.fill(
                          child: Stack(
                            children: drawBoundingBoxes(boxes),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            // Draw bounding boxes on top of the image (implement drawBoundingBoxes function)
            // Positioned.fill(
            //   child: Stack(
            //     children: drawBoundingBoxes(boxes),
            //   ),
            // ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate back to Camera Screen (replace with your navigation logic)
                CHIRouter.push(context, const CameraScreenView());
              },
              child: Text('Camera Mode'),
            ),
            ElevatedButton(
              onPressed: () {
                CHIRouter.push(context, const MainScreenView());
              },
              child: Text('Home Page'),
            ),
          ],
        ),
      ),
    );
  }

  // Function to draw bounding boxes on the camera preview (implementation example)
  List<Widget> drawBoundingBoxes(List<dynamic> boxes) {
    List<Widget> boundingBoxes = [];
    int oldWidth = apiWidth;
    int oldHeight = apiHeight;
    // const double oldWidth = 360;
    // const double oldHeight = 540;
    int imageWidth = newWidth; // Replace with actual image width if available
    int imageHeight =
        newHeight; // Replace with actual image height if available

    for (var box in boxes) {
      // Extract coordinates and class ID
      final double x1 = box[0].toDouble() / oldWidth;
      final double y1 = box[1].toDouble() / oldHeight;
      final double x2 = box[2].toDouble() / oldWidth;
      final double y2 = box[3].toDouble() / oldHeight;
      // final double x1 = box[0].toDouble();
      // final double y1 = box[1].toDouble();
      // final double x2 = box[2].toDouble();
      // final double y2 = box[3].toDouble();
      final String classId = box[4];

      // Calculate box dimensions based on screen size
      final double boxWidth = (x2 - x1) * imageWidth;
      final double boxHeight = (y2 - y1) * imageHeight;
      // final double boxWidth = (x2 - x1);
      // final double boxHeight = (y2 - y1);
      // Define different colors for different class IDs (optional)
      final Color boxColor =
          getColorForClass(classId); // Implement getColorForClass function

      // Create a Container widget for the bounding box
      boundingBoxes.add(
        Positioned(
          // top: y1,
          // left: x1,
          top: (y1 * imageHeight),
          left: (x1 * imageWidth),
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
      case "hole":
        return Colors.red;
      case "stain":
        return Colors.green;
      case "thread-error":
        return Colors.blue;
      case "seam-error":
        return Colors.purple;
      default:
        return Colors.yellow; // Default color for unknown class IDs
    }
  }

  @override
  DisplayImageViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      DisplayImageViewModel();
}
