import 'package:flutter/material.dart';
import 'package:recook/models/recipe.dart';
import 'package:recook/theme.dart';
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

      final recipe = Recipe(
        key: recipeKey,
        title: recipeTitle,
        imageUrl: recipeImageUrl,
      );

      isRecipeSaved = recipeDetailViewModel.isRecipeSaved(recipe);
    }

    return Container(
      height: kToolbarHeight,
      child: IconButton(
        icon: Icon(
          isRecipeSaved ? Icons.favorite : Icons.favorite_border,
          color: isRecipeSaved ? Colors.white : null,
        ),
        onPressed: () {
          recipeDetailViewModel.toggleSaveRecipe(recipeDetailKey);

          String snackBarMessage = isRecipeSaved ? '$recipeDetailKey dihapus!' : '$recipeDetailKey disimpan!';

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(snackBarMessage),
              backgroundColor: accentColor,
            ),
          );
        },
      ),
    );
  }
}