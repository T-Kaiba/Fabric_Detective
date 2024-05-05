import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Import for json decoding
import 'package:Fabric_Detective/ui/views/display_image_screen/display_image_screen_view.dart';

enum UploadState { uploaded, notUploaded }

class UploadScreenView extends StatefulWidget {
  const UploadScreenView({Key? key}) : super(key: key);

  @override
  State<UploadScreenView> createState() => _UploadScreenViewState();
}

class _UploadScreenViewState extends State<UploadScreenView> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  UploadState _uploadState = UploadState.notUploaded;
  UploadState get uploadState => _uploadState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: const Color.fromARGB(255, 64, 24, 131),
        title: const Text(
          'Upload Sample Image',
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _image == null
                  ? const Text('No image selected.')
                  : Image.file(File(_image!.path)),
              // Conditional visibility for Upload Sample button
              Visibility(
                visible: _uploadState == UploadState.uploaded,
                child: ElevatedButton(
                  onPressed: () async => _runDetection(context),
                  child: const Text('Upload Sample'),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImageFromGallery,
        tooltip: 'Pick Image',
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }

  Future _pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      _uploadState = UploadState.uploaded;
    });
  }

  Future<void> _runDetection(BuildContext context) async {
    final Uri url = Uri.parse('http://192.168.26.41:5000/detect');
    final int imageSize = await _image!.length();
    final bytes = await _image!.readAsBytes();
    final imageProvider = MemoryImage(bytes);
    final image = await decodeImageFromList(bytes);
    final thisWidth = image.width;
    final thisHeight = image.height;
    print('running...');

    // Prepare the request body with image data
    var request = http.MultipartRequest('POST', url);
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    request.files.add(http.MultipartFile(
      'image_file',
      _image!.readAsBytes().asStream(),
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
      print(streamedResponse.statusCode);
      print("data received!");
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
              imagePath: _image!.path,
              boxes: bBoxes,
              apiHeight: imageHeight,
              apiWidth: imageWidth,
              newHeight: thisHeight,
              newWidth: thisWidth,
            ),
          ),
        );
        print(_image!.path);
      } else {
        print('Error: ${streamedResponse.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }
    // } else {
    //   // Handle case where user cancels image selection (optional)
    //   print('Image selection cancelled');
    // }
  }
}
