import 'package:flutter/material.dart';
import 'package:recook/view/recipe_page.dart';
import 'package:recook/viewmodels/recipe_viewmodel.dart';
import 'package:recook/viewmodels/search_viewmodel.dart';
import 'package:recook/widgets/navbar.dart';
import 'package:recook/widgets/search_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchViewModel>(
      create: (context) => SearchViewModel(),
      child: SearchPageContent(),
    );
  }
}

class SearchPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Cari Resep'),
      ),
      body: Column(
        children: <Widget>[
          CustomSearchBar(
  controller: _searchController,
  onSearch: (keyword) {
    final searchViewModel =
        Provider.of<SearchViewModel>(context, listen: false);

    // Set isLoading menjadi true saat pencarian dimulai
    searchViewModel.startLoading();

    searchViewModel.searchRecipes(keyword).then((_) {
      // Set isLoading menjadi false saat pencarian selesai
      searchViewModel.stopLoading();
    });
  },
),

          Consumer<SearchViewModel>(
            builder: (context, searchViewModel, child) {
              if (searchViewModel.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return SizedBox();
              }
            },
          ),
          Consumer<SearchViewModel>(
            builder: (context, searchViewModel, child) {
              return Expanded(
                child: ListView.builder(
                  itemCount: searchViewModel.searchResults.length,
                  itemBuilder: (context, index) {
                    final item = searchViewModel.searchResults[index];
                    final recipeKey = item['key'];
                    return ListTile(
                      title: Text(item['title']),
                      subtitle: Text(
                        'Waktu: ${item['times']} - Kesulitan: ${item['difficulty']}',
                      ),
                      leading: CachedNetworkImage(
                        imageUrl: item['img'],
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) {
                          return Icon(
                            Icons.account_circle,
                            size: 48,
                          );
                        },
                      ),
                      onTap: () {
                        final recipeDetailViewModel =
                            Provider.of<RecipeDetailViewModel>(context,
                                listen: false);
                        recipeDetailViewModel.fetchRecipeDetail(recipeKey);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                              create: (context) => RecipeDetailViewModel(),
                              child: RecipePage(recipeKey: recipeKey),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: 1,
        onItemTapped: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/home');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/ai');
          }
        },
      ),
    );
  }
}
