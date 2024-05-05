import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Fabric_Detective/ui/common/chi_router.dart';
import 'package:Fabric_Detective/ui/views/camera_screen/camera_screen_view.dart';
import 'package:stacked/stacked.dart';
import 'package:Fabric_Detective/ui/views/upload_screen/upload_screen_view.dart';
import 'mainscreen_viewmodel.dart';

class MainScreenView extends StatelessWidget {
  const MainScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainScreenViewModel>.reactive(
      viewModelBuilder: () => MainScreenViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/homepage-white-bg-logo.png',
                        height: 150,
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                      Text(
                        'Welcome to Fabric Detective',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 64, 24, 131),
                          // Add more properties as needed
                        ),
                      )
                    ],
                  ),
                  Container(
                    child: Column(
                      children: [
                        pagesCard(
                            viewModel,
                            "assets/images/phone-camera-svgrepo-com.svg",
                            "Camera Mode",
                            context),
                        pagesCard(
                            viewModel,
                            "assets/images/upload-photo-svgrepo-com.svg",
                            "Upload",
                            context),
                        pagesCard(
                            viewModel,
                            "assets/images/test-data-svgrepo-com.svg",
                            "Results",
                            context)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget pagesCard(MainScreenViewModel viewModel, String path, String title,
    BuildContext context) {
  if (title == "Upload") {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          CHIRouter.push(context, const UploadScreenView());
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color.fromARGB(255, 64, 24, 131)),
          height: 120,
          width: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(path, height: 70),
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 210, 48),
                    fontSize: 18),
              )
            ],
          ),
        ),
      ),
    );
  } else if (title == "Camera Mode") {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          CHIRouter.push(context, const CameraScreenView());
        },
        child: Container(
          height: 120,
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color.fromARGB(255, 64, 24, 131)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(path, height: 70),
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 210, 48),
                    fontSize: 18),
              )
            ],
          ),
        ),
      ),
    );
  } else {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: Container(
          height: 120,
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color.fromARGB(255, 64, 24, 131)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(path, height: 70),
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 210, 48),
                    fontSize: 18),
              )
            ],
          ),
        ),
      ),
    );
  }
}
