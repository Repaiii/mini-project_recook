import 'package:flutter/material.dart';
import 'package:recook/models/recipe.dart';

class RecipeDetailPage extends StatelessWidget {
  final Recipe recipe;

  RecipeDetailPage({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Tampilkan detail resep secara lengkap di sini
            Text('Judul: ${recipe.title}'),
            // Tambahkan info lainnya sesuai kebutuhan
          ],
        ),
      ),
    );
  }
}
