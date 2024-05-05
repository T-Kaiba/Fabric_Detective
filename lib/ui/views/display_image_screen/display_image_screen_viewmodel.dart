import 'package:stacked/stacked.dart';

class DisplayImageViewModel extends BaseViewModel {
  String _imagePath = "";
  List<dynamic> _boxes = [];
  // int _apiHeight = 0;
  // int _apiWidth = 0;

  String get imagePath => _imagePath;
  List<dynamic> get boxes => _boxes;
  // int get apiHeight => _apiHeight;
  // int get apiWidth => _apiWidth;

  void setImagePath(String path) {
    _imagePath = path;
    notifyListeners();
  }

  void setBoundingBoxes(List<dynamic> boxes) {
    _boxes = boxes;
    notifyListeners();
  }
}
