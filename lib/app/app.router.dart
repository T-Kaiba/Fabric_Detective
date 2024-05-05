// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i6;
import 'package:flutter/material.dart';
import 'package:Fabric_Detective/ui/views/home/home_view.dart' as _i2;
import 'package:Fabric_Detective/ui/views/camera_screen/camera_screen_view.dart'
    as _i4;
import 'package:Fabric_Detective/ui/views/signup_screen/signup_screen_view.dart'
    as _i5;
import 'package:Fabric_Detective/ui/views/main_screen/mainscreen_view.dart'
    as _i8;
import 'package:Fabric_Detective/ui/views/startup/startup_view.dart' as _i3;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i7;
import 'package:Fabric_Detective/ui/views/display_image_screen/display_image_screen_view.dart'
    as _i9;
import 'package:Fabric_Detective/ui/views/upload_screen/upload_screen_view.dart'
    as _i10;

class Routes {
  static const homeView = '/home-view';

  static const startupView = '/startup-view';

  static const cameraScreenView = '/camera-screen-view';

  static const signupScreenView = '/signup-screen-view';

  static const mainScreenView = '/mainscreen-view';

  static const displayImageView = '/display-image-view';

  static const uploadScreenView = '/upload-screen-view';

  static const all = <String>{
    homeView,
    startupView,
    cameraScreenView,
    signupScreenView,
    mainScreenView,
    displayImageView,
    uploadScreenView
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.homeView,
      page: _i2.HomeView,
    ),
    _i1.RouteDef(
      Routes.startupView,
      page: _i3.StartupView,
    ),
    _i1.RouteDef(
      Routes.cameraScreenView,
      page: _i4.CameraScreenView,
    ),
    _i1.RouteDef(
      Routes.signupScreenView,
      page: _i5.SignupScreenView,
    ),
    _i1.RouteDef(
      Routes.mainScreenView,
      page: _i8.MainScreenView,
    ),
    _i1.RouteDef(
      Routes.displayImageView,
      page: _i9.DisplayImageView,
    ),
    _i1.RouteDef(
      Routes.uploadScreenView,
      page: _i10.UploadScreenView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeView: (data) {
      return _i6.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.HomeView(),
        settings: data,
      );
    },
    _i3.StartupView: (data) {
      return _i6.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.StartupView(),
        settings: data,
      );
    },
    _i4.CameraScreenView: (data) {
      return _i6.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.CameraScreenView(),
        settings: data,
      );
    },
    _i5.SignupScreenView: (data) {
      return _i6.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.SignupScreenView(),
        settings: data,
      );
    },
    _i8.MainScreenView: (data) {
      return _i6.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.MainScreenView(),
        settings: data,
      );
    },
    _i9.DisplayImageView: (data) {
      final arguments = data as _i9.DisplayImageView;
      return _i6.MaterialPageRoute<dynamic>(
        builder: (context) => _i9.DisplayImageView(
            imagePath: arguments.imagePath,
            boxes: arguments.boxes,
            apiHeight: arguments.apiHeight,
            apiWidth: arguments.apiWidth,
            newHeight: arguments.newHeight,
            newWidth: arguments.newWidth),
        settings: data,
      );
    },
    _i10.UploadScreenView: (data) {
      return _i6.MaterialPageRoute<dynamic>(
        builder: (context) => const _i10.UploadScreenView(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

extension NavigatorStateExtension on _i7.NavigationService {
  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCameraScreenView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.cameraScreenView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToMainScreenView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.mainScreenView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSignupScreenView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.signupScreenView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCameraScreenView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.cameraScreenView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithMainScreenView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.mainScreenView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSignupScreenView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.signupScreenView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
