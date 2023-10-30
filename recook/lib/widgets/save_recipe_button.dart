import 'package:flutter/material.dart';
import 'package:recook/models/recipe.dart';
import 'package:recook/viewmodels/recipe_viewmodel.dart';

class SaveRecipeButton extends StatelessWidget {
  final RecipeDetailViewModel recipeDetailViewModel;

  SaveRecipeButton({required this.recipeDetailViewModel});

  @override
  Widget build(BuildContext context) {
    bool isRecipeSaved = false;

    if (recipeDetailViewModel.recipeDetail != null) {
      final recipe = Recipe(
        key: recipeDetailViewModel.recipeDetail!['key'] ?? '',
        title: recipeDetailViewModel.recipeDetail!['title'] ?? '',
        imageUrl: recipeDetailViewModel.recipeDetail!['image'] ?? '',
      );
      isRecipeSaved = recipeDetailViewModel.isRecipeSaved(recipe);
    }

    return Container(
      height: kToolbarHeight,
      child: IconButton(
        icon: Icon(
          isRecipeSaved ? Icons.favorite : Icons.favorite_border,
          color: isRecipeSaved ? Colors.red : null,
        ),
        onPressed: () {
          // Menggunakan RecipeDetailViewModel yang sedang dilihat
          recipeDetailViewModel.toggleSaveRecipe();
        },
      ),
    );
  }
}
