import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:recook/models/recipe.dart';
import 'package:recook/viewmodels/recipe_db.dart';

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
    final recipeCookingTime = _recipeDetail!['results']['times'] ?? '';
    final recipeDifficulty = _recipeDetail!['results']['difficulty'] ?? '';
    final recipeDescription = _recipeDetail!['results']['description'] ?? '';
    final recipeIngredients = _recipeDetail!['results']['ingredient'] as List<dynamic>? ?? [];
    final recipeSteps = _recipeDetail!['results']['step'] as List<dynamic>? ?? [];

    final recipe = Recipe(
      id: 0, 
      key: recipeKey,
      title: recipeTitle,
      imageUrl: recipeImageUrl,
      cookingTime: recipeCookingTime,
      difficulty: recipeDifficulty,
      description: recipeDescription,
      ingredients: List<String>.from(recipeIngredients) ,
      steps: List<String>.from(recipeSteps) ,
    );

  if (isRecipeSaved(recipe)) {
  final removedId = (recipe.id); // Menggunakan ID untuk menghapus resep
  await _repository.removeSavedRecipe(removedId!);
  _savedRecipes.removeWhere((recipe) => recipe.id == removedId);
} else {
  final savedRecipe = await _repository.addSavedRecipe(recipe);
  _savedRecipes.add(savedRecipe);
}

    // Print data yang disimpan ke dalam console
    print('Data yang disimpan:');
    for (var savedRecipe in _savedRecipes) {
      print('Key: ${savedRecipe.key}, Title: ${savedRecipe.title}, Image: ${savedRecipe.imageUrl}, Cooking Time: ${savedRecipe.cookingTime}, Difficulty: ${savedRecipe.difficulty}, Description: ${savedRecipe.description}, Ingredients: ${savedRecipe.ingredients}, Steps: ${savedRecipe.steps}');
    }
  } else {
    print('_recipeDetail is null');
  }

  await Future.microtask(() {
    notifyListeners();
  });
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