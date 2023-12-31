import 'package:flutter/material.dart';
import 'package:recook/services/ai_service.dart';
import 'package:provider/provider.dart';
import 'package:recook/viewmodels/ai_request_provider.dart';
import 'package:recook/viewmodels/chat_controller_provider.dart';
import 'package:recook/viewmodels/textfield_validator_provider.dart';
import 'package:recook/widgets/navbar.dart';
import 'package:recook/widgets/message_tile.dart';

class AiPage extends StatelessWidget {
  final TextEditingController _chatController = TextEditingController();
  final RecipeRecommendationService _aiService = RecipeRecommendationService();

  @override
  Widget build(BuildContext context) {
    final aiRequestProvider = Provider.of<AiRequestProvider>(context);
    final chatMessages = Provider.of<List<String>>(context);
    final chatMessageProvider = Provider.of<ChatMessageProvider>(context);
    final textFieldValidationProvider = Provider.of<TextFieldValidationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Recook! AI'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: chatMessages.length,
                    itemBuilder: (context, index) {
                      final message = chatMessages[index];

                      if (message.isNotEmpty) {
                        return MessageTile(
                          message: chatMessages[index],
                          index: index,
                          onDelete: (int index) {
                            chatMessages.removeAt(index);
                          },
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                  if (aiRequestProvider.isLoading)
                    Center(child: CircularProgressIndicator(),)
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _chatController,
                    decoration: InputDecoration(labelText: 'Chat dengan AI', errorText: textFieldValidationProvider.errorMessage),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () async {
                    String message = _chatController.text;

                    if (textFieldValidationProvider.validateTextField(message)) {
                      _chatController.clear();

                      aiRequestProvider.startLoading();

                      Map<String, dynamic>? response =
                          await _aiService.getRecommendations(prompt: message);

                      if (response != null) {
                        String aiResponse = response['choices'][0]['text'];
                        if (aiResponse.trim().isNotEmpty) {
                          chatMessages.add('$aiResponse');
                          chatMessageProvider.updateChatMessage(message);
                        }
                      }

                      aiRequestProvider.stopLoading();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: 2,
        onItemTapped: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/search');
          }
        },
      ),
    );
  }
}
