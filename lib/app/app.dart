import 'package:Fabric_Detective/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:Fabric_Detective/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:Fabric_Detective/ui/views/display_image_screen/display_image_screen_view.dart';
import 'package:Fabric_Detective/ui/views/home/home_view.dart';
import 'package:Fabric_Detective/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:Fabric_Detective/ui/views/camera_screen/camera_screen_view.dart';
import 'package:Fabric_Detective/ui/views/signup_screen/signup_screen_view.dart';
import 'package:Fabric_Detective/ui/views/upload_screen/upload_screen_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: CameraScreenView),
    MaterialRoute(page: SignupScreenView),
    MaterialRoute(page: DisplayImageView),
    MaterialRoute(page: UploadScreenView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
