import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:recook/models/recipe.dart';
import 'package:recook/models/recipe_db.dart';

class RecipeDetailViewModel with ChangeNotifier {
  final Dio _dio = Dio();
  final RecipeRepository _repository = RecipeRepository();

  bool _isLoading = false;
  Map<String, dynamic>? _recipeDetail;
  List<Recipe> _savedRecipes = [];

  bool get isLoading => _isLoading;
  Map<String, dynamic>? get recipeDetail => _recipeDetail;

  Future<void> fetchRecipeDetail(String recipeKey) async {
    _isLoading = true;

    try {
      final response = await _dio.get('https://resepin-api.vercel.app/api/recipe/$recipeKey');

      if (response.statusCode == 200) {
        _recipeDetail = response.data as Map<String, dynamic>;
      } else {
        throw Exception('Gagal mengambil detail resep');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleSaveRecipe(String recipeDetailKey) async {
  if (_recipeDetail != null) {
    final recipeKey = _recipeDetail!['key'] ?? recipeDetailKey;
    final recipeTitle = _recipeDetail!['results']['title'] ?? '';
    final recipeImageUrl = _recipeDetail!['results']['image'] ?? '';

    final recipe = Recipe(
      key: recipeKey,
      title: recipeTitle,
      imageUrl: recipeImageUrl,
    );

    final existingRecipe = _savedRecipes.firstWhere(
      (r) => r.key == recipe.key,
      orElse: () => Recipe(id: null, key: '', title: '', imageUrl: ''),
    );

    if (isRecipeSaved(recipe)) {
      if (existingRecipe.id != null) {
        await _repository.removeSavedRecipe(existingRecipe.id!);
        _savedRecipes.removeWhere((r) => r.id == existingRecipe.id);
      }
    } else {
      if (existingRecipe.id == null) {
        final savedRecipe = await _repository.addSavedRecipe(recipe);
        _savedRecipes.add(savedRecipe);
      }
    }

    print('Data yang disimpan:');
    for (var savedRecipe in _savedRecipes) {
      print('Key: ${savedRecipe.key}, Title: ${savedRecipe.title}, Image: ${savedRecipe.imageUrl}');
    }
  } else {
    print('_recipeDetail is null');
  }

  notifyListeners();
}

  Future<List<Recipe>> getSavedRecipes() async {
    final savedRecipes = await _repository.getSavedRecipes();
    return savedRecipes;
  }

  Future<void> removeSavedRecipe(int id) async {
    await _repository.removeSavedRecipe(id);
    _savedRecipes.removeWhere((recipe) => recipe.id == id);
    notifyListeners();
  }

  bool isRecipeSaved(Recipe recipe) {
    return _savedRecipes.any((savedRecipe) => savedRecipe.key == recipe.key);
  }

  Future<void> loadSavedRecipes() async {
    final savedRecipes = await _repository.getSavedRecipes();
    _savedRecipes.clear();
    _savedRecipes.addAll(savedRecipes);
    notifyListeners();
  }
}
