import 'package:app_store/src/modules/applications/categories/new_view.dart';
import 'package:flutter/material.dart';

class Navigation extends ChangeNotifier {
  Widget currentView = const CategoriesNewView();
  void pageView(Widget view, BuildContext context) {
    try {
      currentView = view;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
