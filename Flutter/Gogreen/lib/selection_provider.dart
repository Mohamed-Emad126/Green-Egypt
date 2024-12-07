import 'package:flutter/material.dart';

class SelectionProvider with ChangeNotifier {
  bool isTreePlantingSelected = false;
  bool isCareSelected = true;
  bool isCharitySelected = false;
  bool isEventsSelected = false;

  void selectCategory(String category) {
    isTreePlantingSelected = category == 'Tree Planting Guide';
    isCareSelected = category == 'Care';
    isCharitySelected = category == 'Charity';
    isEventsSelected = category == 'Events';

    notifyListeners();
  }
}
