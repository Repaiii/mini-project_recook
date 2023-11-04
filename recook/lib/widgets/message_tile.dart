import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recook/theme.dart';
import 'package:recook/viewmodels/chat_controller_provider.dart';
import 'package:recook/viewmodels/saved_message_provider.dart';

class MessageTile extends StatelessWidget {
  final String message;
  final int index;
  final Function(int) onDelete;

  MessageTile({
    required this.message,
    required this.index,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    bool isSaved = Provider.of<SavedMessagesProvider>(context)
        .savedMessages
        .contains(message);

    return Dismissible(
      key: Key('$index'),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          onDelete(index);
        }
      },
      background: Container(
        alignment: Alignment.centerRight,
        color: accentColor,
        child: Icon(Icons.delete, color: Colors.white),
      ),
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: accentColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableText(
                message,
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 8.0),
              // Tombol Save
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        isSaved ? Icons.favorite : Icons.favorite_border,
                        color: isSaved ? accentColor : accentColor,
                      ),
                      onPressed: () {
                        final savedMessagesProvider =
                            Provider.of<SavedMessagesProvider>(context, listen: false);
                        final chatMessageProvider =
                            Provider.of<ChatMessageProvider>(context, listen: false);

                        if (isSaved) {
                          final index = savedMessagesProvider.savedMessages
                              .indexOf(message);
                          if (index != -1) {
                            savedMessagesProvider.removeMessage(index);
                            showSnackbar(context,
                                "Pesan dihapus: ${chatMessageProvider.chatMessage}");
                          }
                        } else {
                          savedMessagesProvider.addMessage(message);
                          showSnackbar(context,
                              "Pesan disimpan: ${chatMessageProvider.chatMessage}");
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: accentColor,
      ),
    );
  }
}