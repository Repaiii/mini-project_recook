import 'package:flutter/material.dart';
import 'package:recook/models/recipe.dart';
import 'package:recook/viewmodels/recipe_viewmodel.dart';

class SaveRecipeButton extends StatelessWidget {
  final RecipeDetailViewModel recipeDetailViewModel;
  final recipeDetailKey;

  SaveRecipeButton({required this.recipeDetailViewModel, required this.recipeDetailKey});

  @override
  Widget build(BuildContext context) {
    print(recipeDetailKey);
    bool isRecipeSaved = false;

    if (recipeDetailViewModel.recipeDetail != null) {
      final recipeKey = recipeDetailViewModel.recipeDetail!['key'] ?? recipeDetailKey;
      final recipeTitle = recipeDetailViewModel.recipeDetail!['results']['title'] ?? '';
      final recipeImageUrl = recipeDetailViewModel.recipeDetail!['results']['image'] ?? '';
      final recipeCookingTime = recipeDetailViewModel.recipeDetail!['results']['cookingTime'] ?? '';
      final recipeDifficulty = recipeDetailViewModel.recipeDetail!['results']['difficulty'] ?? '';
      final recipeDescription = recipeDetailViewModel.recipeDetail!['results']['description'] ?? '';
      final recipeIngredientsDynamic = recipeDetailViewModel.recipeDetail!['results']['ingredients'];
      final recipeStepsDynamic = recipeDetailViewModel.recipeDetail!['results']['steps'];
      
      List<String> recipeIngredients = [];
      List<String> recipeSteps = [];

      if (recipeIngredientsDynamic is List) {
        recipeIngredients = recipeIngredientsDynamic.map<String>((ingredient) => ingredient.toString()).toList();
      } else if (recipeIngredientsDynamic is String) {
        recipeIngredients.add(recipeIngredientsDynamic);
      } else if (recipeIngredientsDynamic != null) {
        recipeIngredients.add(recipeIngredientsDynamic.toString());
      }

      if (recipeStepsDynamic is List) {
        recipeSteps = recipeStepsDynamic.map<String>((step) => step.toString()).toList();
      } else if (recipeStepsDynamic is String) {
        recipeSteps.add(recipeStepsDynamic);
      } else if (recipeStepsDynamic != null) {
        recipeSteps.add(recipeStepsDynamic.toString());
      }

      final recipe = Recipe(
        key: recipeKey,
        title: recipeTitle,
        imageUrl: recipeImageUrl,
        cookingTime: recipeCookingTime,
        difficulty: recipeDifficulty,
        description: recipeDescription,
        ingredients: recipeIngredients,
        steps: recipeSteps,
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
          recipeDetailViewModel.toggleSaveRecipe(recipeDetailKey);
        },
      ),
    );
  }
}
