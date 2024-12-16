import 'package:flutter/material.dart';

class HomepageProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  bool _isNotificationPressed = false;
  int _points = 25;

  bool _isTreePlantingSelected = true;
  bool _isCharitySelected = false;
  bool _isEventsSelected = false;
  bool _isCareSelected = false;

  final List<Map<String, String>> _items = [
    {
      'imagePath': 'images/img_2.png',
      'title': 'How to Choose a Tree?',
      'description': 'Details on selecting the right tree for your region.',
    },
    {
      'imagePath': 'images/img_4.png',
      'title': 'Tree Benefits',
      'description': 'Learn about the benefits of planting trees.',
    },
    {
      'imagePath': 'images/img_6.png',
      'title': 'Tree Care Essentials',
      'description': 'Tips for healthy tree growth and care.',
    },
    {
      'imagePath': 'images/img_8.png',
      'title': 'Environmental Impact',
      'description': 'How trees help the planet.',
    },
  ];

  int get selectedIndex => _selectedIndex;
  bool get isNotificationPressed => _isNotificationPressed;
  int get points => _points;
  List<Map<String, String>> get items => _items;

  bool get isTreePlantingSelected => _isTreePlantingSelected;
  bool get isCharitySelected => _isCharitySelected;
  bool get isEventsSelected => _isEventsSelected;
  bool get isCareSelected => _isCareSelected;

  void updateSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void toggleNotification() {
    _isNotificationPressed = !_isNotificationPressed;
    notifyListeners();
  }

  void selectCategory(String category) {
    _isTreePlantingSelected = category == 'TreePlanting';
    _isCharitySelected = category == 'Charity';
    _isEventsSelected = category == 'Events';
    _isCareSelected = category == 'Care';
    notifyListeners();
  }
}
