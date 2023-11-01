import 'package:flutter/material.dart';

class ChatMessageProvider extends ChangeNotifier {
  String _chatMessage = '';

  String get chatMessage => _chatMessage;

  void updateChatMessage(String message) {
    _chatMessage = message;
    notifyListeners();
  }
}
