// saved_messages_provider.dart
import 'package:flutter/foundation.dart';

class SavedMessagesProvider with ChangeNotifier {
  List<String> savedMessages = [];

  void addMessage(String message) {
    savedMessages.add(message);
    notifyListeners();
  }

  void removeMessage(int index) {
    savedMessages.removeAt(index);
    notifyListeners();
  }
}
