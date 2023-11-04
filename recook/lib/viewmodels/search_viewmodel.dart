import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class SearchViewModel extends ChangeNotifier {
  final Dio _dio = Dio();
  List<dynamic> _searchResults = [];
  bool _isLoading = false;

  // Metode untuk memulai loading
  void startLoading() {
    _isLoading = true;
    notifyListeners();
  }

  // Metode untuk menghentikan loading
  void stopLoading() {
    _isLoading = false;
    notifyListeners();
  }

  List get searchResults => _searchResults;
  bool get isLoading => _isLoading;

  Future<void> searchRecipes(String keyword) async {
    try {
      // Set isLoading ke true saat pencarian dimulai
      startLoading();

      final response = await _dio.get(
        'https://resepin-api.vercel.app/api/search/?q=$keyword',
      );

      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic>) {
          _searchResults = response.data['results'] as List<dynamic>;
          notifyListeners();
        } else {
          throw Exception('Format respons tidak valid');
        }
      } else {
        throw Exception('Gagal melakukan pencarian resep');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    } finally {
      // Set isLoading kembali ke false saat pencarian selesai
      stopLoading();
    }
  }
}
