import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recook/viewmodels/recipe_viewmodel.dart';
import 'package:recook/widgets/recipe_widget.dart';
import 'package:recook/widgets/save_recipe_button.dart';

class RecipePage extends StatelessWidget {
  final String recipeKey;

  RecipePage({required this.recipeKey});

  @override
  Widget build(BuildContext context) {
    return RecipePageContent(recipeKey: recipeKey);
  }
}

class RecipePageContent extends StatefulWidget {
  final String recipeKey;

  RecipePageContent({required this.recipeKey});

  @override
  _RecipePageContentState createState() => _RecipePageContentState();
}

class _RecipePageContentState extends State<RecipePageContent> {
  late RecipeDetailViewModel recipeDetailViewModel;

  @override
  void initState() {
    super.initState();
    recipeDetailViewModel = Provider.of<RecipeDetailViewModel>(context, listen: false);
    recipeDetailViewModel.fetchRecipeDetail(widget.recipeKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Resep'),
        actions: [
          Consumer<RecipeDetailViewModel>(
            builder: (context, model, child) {
              return SaveRecipeButton(recipeDetailViewModel: model);
            },
          )
        ],
      ),
      body: Consumer<RecipeDetailViewModel>(
        builder: (context, model, child) {
          if (model.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (model.recipeDetail != null) {
            return RecipeDetailWidget(
                recipeDetailViewModel: model);
          } else {
            return Text('Gagal mengambil detail resep');
          }
        },
      ),
    );
  }
}
