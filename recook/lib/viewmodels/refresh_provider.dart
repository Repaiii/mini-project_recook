import 'package:flutter/material.dart';

class RefreshProvider with ChangeNotifier {
  bool _isRefreshing = false;

  bool get isRefreshing => _isRefreshing;

  void startRefreshing() {
    _isRefreshing = true;
    notifyListeners();
  }

  void stopRefreshing() {
    _isRefreshing = false;
    notifyListeners();
  }
}
