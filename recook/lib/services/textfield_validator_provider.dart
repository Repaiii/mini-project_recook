import 'package:flutter/foundation.dart';

class TextFieldValidationProvider extends ChangeNotifier {
  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  bool validateTextField(String text) {
    if (text.isEmpty) {
      _errorMessage = 'Harap isi pesan sebelum mengirim.';
      notifyListeners();
      return false;
    }
    _errorMessage = null;
    notifyListeners();
    return true;
  }
}
