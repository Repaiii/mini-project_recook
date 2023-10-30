import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class SearchViewModel extends ChangeNotifier {
  final Dio _dio = Dio();
  List<dynamic> _searchResults = [];

  bool _isLoading = false;

  List get searchResults => _searchResults;
  bool get isLoading => _isLoading;

  Future<void> searchRecipes(String keyword) async {
  try {
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
  }
}

}
