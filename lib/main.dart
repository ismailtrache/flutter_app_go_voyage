import 'package:flutter/material.dart';
import 'theme_controller.dart';
import 'pages/lib/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.instance.themeMode,
      builder: (context, mode, _) {
        final seed = const Color(0xFF265F6A);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: mode,
          theme: ThemeData(
            brightness: Brightness.light,
            colorScheme: ColorScheme.fromSeed(seedColor: seed),
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black87,
              elevation: 0,
            ),
            cardColor: Colors.white,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Colors.white,
              selectedItemColor: seed,
              unselectedItemColor: Colors.grey,
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            colorScheme:
                ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.dark),
            scaffoldBackgroundColor: const Color(0xFF0F1115),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF161A1F),
              foregroundColor: Colors.white,
              elevation: 0,
            ),
            cardColor: const Color(0xFF161A1F),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: const Color(0xFF161A1F),
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey[500],
            ),
          ),
          home: const HomePage(),
        );
      },
    );
  }
}
