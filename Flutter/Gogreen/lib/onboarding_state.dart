import 'package:flutter/material.dart';

class Onboarding_State with ChangeNotifier {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  PageController get pageController => _pageController;
  int get currentIndex => _currentIndex;

  void updateCurrentPage(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void goToPage(int page) {
    _pageController.jumpToPage(page);
    updateCurrentPage(page);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
