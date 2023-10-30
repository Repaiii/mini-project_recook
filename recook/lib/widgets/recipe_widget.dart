import 'package:flutter/material.dart';
import 'package:recook/viewmodels/recipe_viewmodel.dart';

class RecipeDetailWidget extends StatelessWidget {
  final RecipeDetailViewModel recipeDetailViewModel;

  RecipeDetailWidget({required this.recipeDetailViewModel});

  @override
  Widget build(BuildContext context) {
    final recipeDetail = recipeDetailViewModel.recipeDetail;

    if (recipeDetail == null) {
      return Center(child: Text('Gagal memuat detail resep.'));
    }

    return ListView(
      children: [
        Image.network(
          recipeDetail['results']['image'] ??
              'https://hewanesia.com/wp-content/uploads/2020/03/kucing-persia-medium.jpeg',
          fit: BoxFit.cover, // Sesuaikan dengan kebutuhan Anda
          height: 200, // Tinggi gambar
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            recipeDetail['results']['title'] ?? '',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Waktu: ${recipeDetail['results']['times']} - Kesulitan: ${recipeDetail['results']['difficulty']}',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Deskripsi: ${recipeDetail['results']['description']}',
            style: TextStyle(fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Bahan-Bahan:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Buat bahan-bahan menjadi rata kiri
            children: (recipeDetail['results']['ingredient'] as List<dynamic>? ?? []).map<Widget>((ingredient) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text('- $ingredient', style: TextStyle(fontSize: 16)),
              );
            }).toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Langkah-Langkah:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Buat langkah-langkah menjadi rata kiri
            children: (recipeDetail['results']['step'] as List<dynamic>? ?? []).map<Widget>((step) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text('$step', style: TextStyle(fontSize: 16)),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
