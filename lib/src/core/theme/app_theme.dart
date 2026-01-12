import 'package:flutter/material.dart';

// --- Colors ---
Color? backgroundColor = Colors.white;
Color? textColor = Colors.grey[800];
Color? secondaryTextColor = Colors.grey[600];
Color? primaryColor = Colors.amber[800];

// --- Theme ---
class AppTheme {
  static ThemeData get themeData {
    return ThemeData(
      fontFamily: 'Nunito',
      scaffoldBackgroundColor: Colors.white,
      textTheme: TextTheme(
        //================================================
        // Display Styles - For very large headlines
        //================================================
        displayLarge: TextStyle(fontSize: 96, fontVariations: <FontVariation>[FontVariation('wght', 500)], color: textColor),
        displayMedium: TextStyle(fontSize: 60, fontVariations: <FontVariation>[FontVariation('wght', 400)], color: textColor),
        displaySmall: TextStyle(fontSize: 48, fontVariations: <FontVariation>[FontVariation('wght', 300)], color: textColor),

        //================================================
        // Headline Styles - For main headlines
        //================================================
        headlineLarge: TextStyle(fontSize: 40, fontVariations: <FontVariation>[FontVariation('wght', 600)], color: textColor),
        headlineMedium: TextStyle(fontSize: 34, fontVariations: <FontVariation>[FontVariation('wght', 400)], color: textColor),
        headlineSmall: TextStyle(fontSize: 24, fontVariations: <FontVariation>[FontVariation('wght', 300)], color: textColor),

        //================================================
        // Title Styles - For card titles and app bars
        //================================================
        titleLarge: TextStyle(fontSize: 20, fontVariations: <FontVariation>[FontVariation('wght', 600)], color: textColor),
        titleMedium: TextStyle(fontSize: 16, fontVariations: <FontVariation>[FontVariation('wght', 400)], color: textColor),
        titleSmall: TextStyle(fontSize: 14, fontVariations: <FontVariation>[FontVariation('wght', 300)], color: textColor),

        //================================================
        // Body Styles - For primary text and paragraphs
        //================================================
        bodyLarge: TextStyle(fontSize: 16, fontVariations: <FontVariation>[FontVariation('wght', 700)], color: textColor),
        bodyMedium: TextStyle(fontSize: 14, fontVariations: <FontVariation>[FontVariation('wght', 500)], color: textColor),
        bodySmall: TextStyle(fontSize: 12, fontVariations: <FontVariation>[FontVariation('wght', 400)], color: textColor),

        //================================================
        // Label Styles - For button text and captions
        //================================================
        labelLarge: TextStyle(fontSize: 14, fontVariations: <FontVariation>[FontVariation('wght', 600)], color: textColor),
        labelMedium: TextStyle(fontSize: 12, fontVariations: <FontVariation>[FontVariation('wght', 400)], color: textColor),
        labelSmall: TextStyle(fontSize: 10, fontVariations: <FontVariation>[FontVariation('wght', 300)], color: textColor),
      ),
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      useMaterial3: true,
    );
  }
}
