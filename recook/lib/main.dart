import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recook/services/ai_request_provider.dart';
import 'package:recook/services/chat_controller_provider.dart';
import 'package:recook/services/refresh_provider.dart';
import 'package:recook/services/saved_message_provider.dart';
import 'package:recook/theme.dart';
import 'package:recook/view/ai_page.dart';
import 'package:recook/view/home_page.dart';
import 'package:recook/view/search_page.dart';
import 'package:recook/view/splash_screen.dart';
import 'package:recook/viewmodels/recipe_viewmodel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<List<String>>(create: (context) => []),
        ChangeNotifierProvider<RecipeDetailViewModel>(create: (_) => RecipeDetailViewModel()),
        ChangeNotifierProvider<SavedMessagesProvider>(create: (_) => SavedMessagesProvider()),
        ChangeNotifierProvider<AiRequestProvider>(create: (_) => AiRequestProvider()),
        ChangeNotifierProvider<ChatMessageProvider>(create: (_) => ChatMessageProvider()),
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
      theme: appTheme, // Gunakan tema yang telah Anda buat
      home: SplashScreenDelay(), // Gunakan SplashScreenDelay sebagai home
      routes: {
        '/ai': (context) => AiPage(),
        '/home': (context) => HomePage(), // Tambahkan rute lain yang diperlukan
        '/search': (context) => SearchPage(),
      },
    );
  }
}
