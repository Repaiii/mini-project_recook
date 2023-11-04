import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recook/services/textfield_validator_provider.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;

  CustomSearchBar({
    required this.controller,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Consumer<TextFieldValidationProvider>(
                builder: (context, textFieldValidationProvider, child) {
                  return TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Hari ini masak apa ya...',
                      errorText: textFieldValidationProvider.errorMessage,
                    ),
                  );
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                final textFieldValidationProvider = Provider.of<TextFieldValidationProvider>(context, listen: false);
                if (textFieldValidationProvider.validateTextField(controller.text)) {
                  onSearch(controller.text);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
