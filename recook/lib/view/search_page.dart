import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recook/view/recipe_page.dart';
import 'package:recook/viewmodels/recipe_viewmodel.dart';
import 'package:recook/viewmodels/search_viewmodel.dart';
import 'package:recook/widgets/navbar.dart';
import 'package:recook/widgets/search_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchViewModel>(
      create: (context) => SearchViewModel(),
      child: SearchPageContent(),
    );
  }
}

class SearchPageContent extends StatefulWidget {
  @override
  _SearchPageContentState createState() => _SearchPageContentState();
}

class _SearchPageContentState extends State<SearchPageContent> {
  final TextEditingController _searchController = TextEditingController();

  void _performSearch(String keyword, SearchViewModel searchViewModel) {
    if (keyword.isNotEmpty) {
      searchViewModel.searchRecipes(keyword);
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchViewModel = Provider.of<SearchViewModel>(context);
    final recipeDetailViewModel = Provider.of<RecipeDetailViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Cari Resep'),
      ),
      body: Column(
        children: <Widget>[
          CustomSearchBar(
            controller: _searchController,
            onSearch: (keyword) => _performSearch(keyword, searchViewModel),
          ),
          searchViewModel.isLoading
              ? CircularProgressIndicator()
              : Expanded(
                  child: ListView.builder(
                  itemCount: searchViewModel.searchResults.length,
                  itemBuilder: (context, index) {
                    final item = searchViewModel.searchResults[index];
                    final recipeKey = item['key'];
                    return ListTile(
                      title: Text(item['title']),
                      subtitle: Text(
                          'Waktu: ${item['times']} - Kesulitan: ${item['difficulty']}'),
                      leading: CachedNetworkImage(
                        imageUrl: item['img'],
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) {
                          // Tampilkan gambar profil sebagai gantinya
                          return Icon(
                            Icons
                                .account_circle, // Anda dapat mengganti ikon ini dengan ikon profil yang sesuai
                            size:
                                48,
                          );
                        },
                      ),

                      // Ketika item di klik, navigasi ke halaman detail resep
                      onTap: () {
                        // Ambil kunci resep dari item yang diklik
                        recipeDetailViewModel.fetchRecipeDetail(recipeKey);
                        // Navigasi ke halaman detail resep dengan menyertakan recipeKey
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
                )),
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
