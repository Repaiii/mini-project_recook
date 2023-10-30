import 'package:flutter/material.dart';
import 'package:recook/models/recipe.dart';
import 'package:recook/services/refresh_provider.dart';
import 'package:recook/theme.dart';
import 'package:provider/provider.dart';
import 'package:recook/viewmodels/recipe_viewmodel.dart';

class RoundedCardWithRecipe extends StatelessWidget {
  final Widget child;
  final Function()? onTap;
  final Recipe savedRecipe; // Tambahkan savedRecipe untuk mengakses data resep

  RoundedCardWithRecipe({required this.child, this.onTap, required this.savedRecipe});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        color: primaryColor, // Ganti warna sesuai dengan tema Anda
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DefaultTextStyle(
            style: TextStyle(color: Colors.white), // Mengatur warna teks menjadi putih
            child: Dismissible(
              key: Key(savedRecipe.id.toString()), // Gunakan id sebagai key
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 16),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                if (direction == DismissDirection.endToStart) {
                  final recipeId = savedRecipe.id;
                  if (recipeId != null) {
                    final recipeDetailViewModel = Provider.of<RecipeDetailViewModel>(context, listen: false);
                    recipeDetailViewModel.removeSavedRecipe(recipeId);

                    // Dapatkan provider untuk mengakses RefreshProvider
                    final refreshProvider = Provider.of<RefreshProvider>(context, listen: false);

                    // Mulai refreshing
                    refreshProvider.startRefreshing();
                  }
                }
              },
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

class RoundedCardWithoutRecipe extends StatelessWidget {
  final Widget child;
  final Function()? onTap;

  RoundedCardWithoutRecipe({required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        color: primaryColor, // Ganti warna sesuai dengan tema Anda
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: child,
        ),
      ),
    );
  }
}