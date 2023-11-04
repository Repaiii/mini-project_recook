import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:recook/services/chat_controller_provider.dart';
import 'package:recook/services/saved_message_provider.dart';
import 'package:recook/view/home_page.dart';
import 'package:recook/widgets/navbar.dart';
import 'package:recook/viewmodels/recipe_viewmodel.dart';
import 'package:recook/viewmodels/search_viewmodel.dart';


void main() {
  testWidgets('Test HomePage widgets', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider<RecipeDetailViewModel>(create: (_) => RecipeDetailViewModel()),
            ChangeNotifierProvider<SearchViewModel>(create: (_) => SearchViewModel()),
            ChangeNotifierProvider<SavedMessagesProvider>(create: (_) => SavedMessagesProvider()),
          ],
          child: HomePage(),
        ),
      ),
    );

    // Verify that the AppBar title is displayed.
    expect(find.text('Recook!'), findsOneWidget);

    // Verify that the TabBar with 'Resep' and 'AI' is displayed.
    expect(find.text('Resep'), findsOneWidget);
    expect(find.text('AI'), findsOneWidget);

    // Verify that the CustomBottomNavigationBar is displayed.
    expect(find.byType(CustomBottomNavigationBar), findsOneWidget);
  });

  testWidgets('Test SavedRecipesWidget', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider<RecipeDetailViewModel>(create: (_) => RecipeDetailViewModel()),
          ],
          child: SavedRecipesWidget(),
        ),
      ),
    );

    // Verify that CircularProgressIndicator is displayed when waiting for data.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Simulate data loading.
    await tester.pump(Duration(seconds: 1));

    // Verify that 'Tidak ada resep yang disimpan.' is displayed.
    expect(find.text('Tidak ada resep yang disimpan.'), findsOneWidget);
  });

  testWidgets('Test SavedMessagesWidget', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider<SavedMessagesProvider>(create: (_) => SavedMessagesProvider()),
            ChangeNotifierProvider<ChatMessageProvider>(create: (_) => ChatMessageProvider()),
          ],
          child: SavedMessagesWidget(),
        ),
      ),
    );

    // Verify that 'Tidak ada pesan AI yang disimpan' is displayed when no messages are saved.
    expect(find.text('Tidak ada pesan AI yang disimpan'), findsOneWidget);
  });
}
