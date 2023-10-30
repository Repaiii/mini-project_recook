import 'package:flutter/material.dart';

// Warna-warna yang digunakan dalam tema
final Color primaryColor = Color(0xFFB30000); // Contoh warna merah yang lebih gelap
final Color secondaryColor = Colors.white; // Warna putih sebagai sekunder
final Color accentColor = Colors.black; // Warna hitam sebagai aksen tambahan

// Font yang digunakan dalam tema
final String appFontFamily = 'Montserrat'; // Font Montserrat sebagai font utama

// Tema aplikasi
final ThemeData appTheme = ThemeData(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: secondaryColor, // Latar belakang aplikasi
  appBarTheme: AppBarTheme(
    backgroundColor: primaryColor, // Warna latar belakang AppBar
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      fontFamily: appFontFamily,
      fontSize: 16.0,
      color: Colors.black, // Warna teks utama dalam aplikasi
    ),
    bodyMedium: TextStyle(
      fontFamily: appFontFamily,
      fontSize: 14.0,
      color: Colors.grey, // Warna teks sekunder dalam aplikasi
    ),
    labelLarge: TextStyle(
      fontFamily: appFontFamily,
      fontSize: 16.0,
      color: secondaryColor, // Warna teks tombol
    ),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: primaryColor, // Warna tombol
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
  ),
);
