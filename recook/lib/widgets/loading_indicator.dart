import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recook/services/ai_request_provider.dart'; // Sesuaikan dengan path provider yang sesuai

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final aiRequestProvider = Provider.of<AiRequestProvider>(context);
    final isLoading = aiRequestProvider.isLoading;

    return isLoading
        ? Center(
            child: CircularProgressIndicator(), // Tampilkan indikator loading jika isLoading == true
          )
        : Container(); // Tampilkan Container kosong jika isLoading == false
  }
}
