import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recook/models/recipe.dart';
import 'package:recook/services/refresh_provider.dart';
import 'package:recook/theme.dart';
import 'package:provider/provider.dart';
import 'package:recook/viewmodels/recipe_viewmodel.dart';

class RoundedCardWithRecipe extends StatelessWidget {
  final Recipe savedRecipe;
  final Function()? onTap;

  RoundedCardWithRecipe({
    required this.savedRecipe,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Dismissible(
        key: Key(savedRecipe.id.toString()), // Gunakan id sebagai key
        background: Container(
          color: accentColor,
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
              final recipeDetailViewModel =
                  Provider.of<RecipeDetailViewModel>(context, listen: false);
              recipeDetailViewModel.removeSavedRecipe(recipeId);
              // Dapatkan provider untuk mengakses RefreshProvider
              final refreshProvider =
                  Provider.of<RefreshProvider>(context, listen: false);
              // Mulai refreshing
              refreshProvider.startRefreshing();
            }
          }
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: savedRecipe.imageUrl,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Center(
                  child: Icon(
                    Icons.error,
                    color: primaryColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultTextStyle(
                  style: TextStyle(color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        savedRecipe.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.black,
                              offset: Offset(2, 2),
                              blurRadius: 3,
                            ),
                          ],
                        ),
                      ),
                      // Tambahkan info tambahan lain di sini jika diperlukan
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class RoundedCardAi extends StatelessWidget {
  final Widget child;
  final Function()? onTap;
  final Function()? onDismissed; // Fungsi yang akan dipanggil saat di-dismiss

  RoundedCardAi({required this.child, this.onTap, this.onDismissed});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(UniqueKey().toString()), // Key unik untuk setiap item
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          // Panggil fungsi onDismissed jika ada
          onDismissed?.call();
        }
      },
      background: Container(
        color: accentColor, // Warna latar belakang saat di-swipe
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 16),
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      direction: DismissDirection
          .endToStart, // Swipe dari kiri ke kanan untuk menghapus
      child: InkWell(
        onTap: onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          color: accentColor, // Ganti warna sesuai dengan tema Anda accentColor
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: child,
          ),
        ),
      ),
    );
  }
}
