import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recook/models/recipe.dart';
import 'package:recook/services/chat_controller_provider.dart';
import 'package:recook/services/saved_message_provider.dart';
import 'package:recook/viewmodels/recipe_viewmodel.dart';
import 'package:recook/widgets/navbar.dart';
import 'package:recook/widgets/rounded_card.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Recook!'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Pencarian'),
              Tab(text: 'AI'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Tampilan untuk tab Pencarian
            SavedRecipesWidget(),
            // Tampilan untuk tab AI
            SavedMessagesWidget(),
          ],
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: 0,
          onItemTapped: (index) {
            if (index == 1) {
              Navigator.pushNamed(context, '/search');
            } else if (index == 2) {
              Navigator.pushNamed(context, '/ai');
            }
          },
        ),
      ),
    );
  }
}

class SavedRecipesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final recipeDetailViewModel = Provider.of<RecipeDetailViewModel>(context);

    return FutureBuilder<List<Recipe>>(
      future: recipeDetailViewModel.getSavedRecipes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final savedRecipes = snapshot.data!;
          return ListView.builder(
            itemCount: savedRecipes.length,
            itemBuilder: (context, index) {
              final savedRecipe = savedRecipes[index];
              return RoundedCardWithRecipe(
                savedRecipe: savedRecipe,
                child: ExpansionTile(
                  title: Text(savedRecipe.title),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Cooking Time: ${savedRecipe.cookingTime}'),
                          Text('Difficulty: ${savedRecipe.difficulty}'),
                          Text('Description: ${savedRecipe.description}'),
                          Text('Ingredients:'),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: savedRecipe.ingredients.map((ingredient) {
                              return Text('- $ingredient');
                            }).toList(),
                          ),
                          Text('Steps:'),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: savedRecipe.steps.map((step) {
                              return Text('- $step');
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return Center(child: Text('Tidak ada resep yang disimpan.'));
        }
      },
    );
  }
}

class SavedMessagesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<SavedMessagesProvider, ChatMessageProvider>(
      builder: (context, savedMessagesProvider, chatMessageProvider, child) {
        return ListView.builder(
          itemCount: savedMessagesProvider.savedMessages.length,
          itemBuilder: (context, index) {
            final savedMessage = savedMessagesProvider.savedMessages[index];
            return RoundedCardWithoutRecipe(
              child: ExpansionTile(
                title: DefaultTextStyle(
                  style: TextStyle(color: Colors.white),
                  child: Text('Pesan AI yang disimpan: ${chatMessageProvider.chatMessage}'),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(savedMessage),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
