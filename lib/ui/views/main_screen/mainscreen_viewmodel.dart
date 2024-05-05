import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class MainScreenViewModel extends BaseViewModel {
  int currentIndex = 0;
  final List<String> labels = ['Home', 'Returns', 'Ninja Bag', 'Profile'];
  final List<Widget> screens = [
    // const HomeView(),
    // const ReturnsView(),
    // const NinjaBagView(),
    // const ProfileView(),
  ];
  final List<String> icons = const [
    'assets/bottom/home.svg',
    'assets/bottom/bag.svg',
    'assets/bottom/profile.svg',
  ];
  final List<String> activeIcons = const [
    'assets/bottom/home_fill.png',
    'assets/bottom/return_fill.png',
    'assets/bottom/bag_fill.png',
  ];

  void onItemChanged(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
