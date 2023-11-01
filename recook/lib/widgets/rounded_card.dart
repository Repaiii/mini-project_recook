import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recook/models/recipe.dart';
import 'package:recook/services/refresh_provider.dart';
import 'package:recook/theme.dart';
import 'package:provider/provider.dart';
import 'package:recook/viewmodels/recipe_viewmodel.dart';

class RoundedCardWithRecipe extends StatelessWidget {
  final Widget child;
  final Function()? onTap;
  final Recipe savedRecipe;

  RoundedCardWithRecipe(
      {required this.child, this.onTap, required this.savedRecipe});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        color: primaryColor, // Ganti warna sesuai dengan tema Anda
        child: Stack(
          children: [
            // Menampilkan gambar latar belakang dari data resep yang sudah disimpan
            CachedNetworkImage(
              imageUrl: savedRecipe.imageUrl,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) {
                return Center(
                  child: Icon(
                    Icons.error,
                    color: Colors.white,
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DefaultTextStyle(
                style: TextStyle(
                    color: Colors.white), // Mengatur warna teks menjadi putih
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
                        final recipeDetailViewModel =
                            Provider.of<RecipeDetailViewModel>(context,
                                listen: false);
                        recipeDetailViewModel.removeSavedRecipe(recipeId);
                        // Dapatkan provider untuk mengakses RefreshProvider
                        final refreshProvider = Provider.of<RefreshProvider>(
                            context,
                            listen: false);

                        // Mulai refreshing
                        refreshProvider.startRefreshing();
                      }
                    }
                  },
                  child: child,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoundedCardWithoutRecipe extends StatelessWidget {
  final Widget child;
  final Function()? onTap;
  final Function()? onDismissed; // Fungsi yang akan dipanggil saat di-dismiss

  RoundedCardWithoutRecipe({required this.child, this.onTap, this.onDismissed});

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
        color: Colors.red, // Warna latar belakang saat di-swipe
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 16),
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      direction: DismissDirection.endToStart, // Swipe dari kiri ke kanan untuk menghapus
      child: InkWell(
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
      ),
    );
  }
}
