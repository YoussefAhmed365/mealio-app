import 'package:flutter/material.dart';
import 'package:mealio/src/core/theme/app_theme.dart';
import 'package:mealio/src/core/router/app_router.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Nunito',
        textTheme: TextTheme(
          //================================================
          // Display Styles - للعناوين الضخمة جدًا
          //================================================
          displayLarge: TextStyle(
            fontSize: 96,
            fontVariations: <FontVariation>[FontVariation('wght', 500.0)],
            color: textColor,
          ),
          displayMedium: TextStyle(
            fontSize: 60,
            fontVariations: <FontVariation>[FontVariation('wght', 400.0)],
            color: textColor,
          ),
          displaySmall: TextStyle(
            fontSize: 48,
            fontVariations: <FontVariation>[FontVariation('wght', 300.0)],
            color: textColor,
          ),

          //================================================
          // Headline Styles - للعناوين الرئيسية
          //================================================
          headlineLarge: TextStyle(
            fontSize: 40,
            fontVariations: <FontVariation>[FontVariation('wght', 600.0)],
            color: textColor,
          ),
          headlineMedium: TextStyle(
            fontSize: 34,
            fontVariations: <FontVariation>[FontVariation('wght', 400.0)],
            color: textColor,
          ),
          headlineSmall: TextStyle(
            fontSize: 24,
            fontVariations: <FontVariation>[FontVariation('wght', 300.0)],
            color: textColor,
          ),

          //================================================
          // Title Styles - لعناوين البطاقات وشريط التطبيق
          //================================================
          titleLarge: TextStyle(
            fontSize: 20,
            fontVariations: <FontVariation>[FontVariation('wght', 600.0)],
            color: textColor,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            fontVariations: <FontVariation>[FontVariation('wght', 400.0)],
            color: textColor,
          ),
          titleSmall: TextStyle(
            fontSize: 14,
            fontVariations: <FontVariation>[FontVariation('wght', 300.0)],
            color: textColor,
          ),

          //================================================
          // Body Styles - للنصوص الأساسية والفقرات
          //================================================
          bodyLarge: TextStyle(
            fontSize: 16,
            fontVariations: <FontVariation>[FontVariation('wght', 700.0)],
            color: textColor,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontVariations: <FontVariation>[FontVariation('wght', 500.0)],
            color: textColor,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            fontVariations: <FontVariation>[FontVariation('wght', 400.0)],
            color: textColor,
          ),

          //================================================
          // Label Styles - لنصوص الأزرار والتعليقات
          //================================================
          labelLarge: TextStyle(
            fontSize: 14,
            fontVariations: <FontVariation>[FontVariation('wght', 600.0)],
            color: textColor,
          ),
          labelMedium: TextStyle(
            fontSize: 12,
            fontVariations: <FontVariation>[FontVariation('wght', 400.0)],
            color: textColor,
          ),
          labelSmall: TextStyle(
            fontSize: 10,
            fontVariations: <FontVariation>[FontVariation('wght', 300.0)],
            color: textColor,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
