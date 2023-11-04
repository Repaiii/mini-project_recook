import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recook/theme.dart';
import 'package:recook/view/ai_page.dart';
import 'package:recook/view/home_page.dart';
import 'package:recook/view/search_page.dart';
import 'package:recook/view/splash_screen.dart';
import 'package:recook/viewmodels/ai_request_provider.dart';
import 'package:recook/viewmodels/chat_controller_provider.dart';
import 'package:recook/viewmodels/recipe_viewmodel.dart';
import 'package:recook/viewmodels/refresh_provider.dart';
import 'package:recook/viewmodels/saved_message_provider.dart';
import 'package:recook/viewmodels/search_viewmodel.dart';
import 'package:recook/viewmodels/textfield_validator_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<List<String>>(create: (context) => []),
        ChangeNotifierProvider<RecipeDetailViewModel>(create: (_) => RecipeDetailViewModel()),
        ChangeNotifierProvider<SearchViewModel>(create: (_) => SearchViewModel()),
        ChangeNotifierProvider<SavedMessagesProvider>(create: (_) => SavedMessagesProvider()),
        ChangeNotifierProvider<AiRequestProvider>(create: (_) => AiRequestProvider()),
        ChangeNotifierProvider<ChatMessageProvider>(create: (_) => ChatMessageProvider()),
        ChangeNotifierProvider<TextFieldValidationProvider>(create: (_) => TextFieldValidationProvider()),
        ChangeNotifierProvider<RefreshProvider>(create: (_) => RefreshProvider()),
      ],
      child: RecookApp(),
    ),
  );
}

class RecookApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme,
      home: SplashScreenDelay(), // Gunakan SplashScreenDelay sebagai home
      routes: {
        '/ai': (context) => AiPage(),
        '/home': (context) => HomePage(),
        '/search': (context) => SearchPage(),
      },
    );
  }
}
