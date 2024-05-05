import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'camera_screen_viewmodel.dart';
import 'package:camera/camera.dart';

class CameraScreenView extends StatelessWidget {
  const CameraScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CameraScreenViewModel>.reactive(
      viewModelBuilder: () => CameraScreenViewModel(),
      onModelReady: (model) async => await model.initializeCamera(),
      builder: (context, viewModel, child) => Scaffold(
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
              // Use Stack to position elements on top of each other
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Align content to bottom center
              children: [
                if (viewModel.initializedState == InitializedState.yes)
                  Center(
                    child: viewModel.cameraController != null &&
                            viewModel.cameraController!.value.isInitialized
                        ? Padding(
                            padding: const EdgeInsets.only(top: 60),
                            child: CameraPreview(viewModel.cameraController!),
                          )
                        : CircularProgressIndicator(),
                  ),
                if (viewModel.detectionState == DetectionState.stopped)
                  Padding(
                    padding: const EdgeInsets.all(16.0), // Add some padding
                    child: ElevatedButton(
                      onPressed: () => viewModel
                          .startDetection(), // Call startDetection on tap
                      child: Text('Start Detecting'),
                    ),
                  )
                else if (viewModel.detectionState == DetectionState.started)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 30, 16, 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () => viewModel.stopDetection(),
                          child: Text('Stop Detecting'),
                        ),
                        ElevatedButton(
                          onPressed: () =>
                              viewModel.takePictureWithDetection(context),
                          child: Text('Take Picture'),
                        ),
                      ],
                    ),
                  )
                else
                  Column(
                    children: [
                      CircularProgressIndicator(),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text("Processing...."),
                      )
                    ],
                  )
                //
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:stacked/stacked.dart';
// import 'camera_screen_viewmodel.dart';
// import 'package:camera/camera.dart';
// import 'package:provider/provider.dart'; // Use provider for state management
// import 'package:Fabric_Detective/ui/common/chi_router.dart';
// import 'package:Fabric_Detective/ui/views/display_image_screen/display_image_screen_view.dart';

// class CameraScreenView extends StackedView<CameraScreenViewModel> {
//   const CameraScreenView({Key? key}) : super(key: key);

//   @override
//   Widget builder(
//       BuildContext context, CameraScreenViewModel viewModel, Widget? child) {
//     return Scaffold(
//       body: Stack(
//         // Use Stack to position elements
//         children: [
//           if (viewModel.cameraController?.value.isInitialized ?? false)
//             CameraPreview(viewModel.cameraController!)
//           else
//             Center(child: CircularProgressIndicator()),
//           if (viewModel.detectionState == DetectionState.stopped)
//             Center(
//               child: ElevatedButton(
//                 onPressed: () => viewModel.startDetection(),
//                 child: Text('Start Detecting'),
//               ),
//             )
//           else
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: () => viewModel.stopDetection(),
//                   child: Text('Stop Detecting'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () => viewModel.takePictureWithDetection(context),
//                   child: Text('Take Picture'),
//                 ),
//               ],
//             ),
//         ],
//       ),
//     );
//   }

//   @override
//   CameraScreenViewModel viewModelBuilder(
//     BuildContext context,
//   ) =>
//       CameraScreenViewModel();
// }
