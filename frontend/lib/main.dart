import 'package:flutter/material.dart';
import 'package:frontend/routes.dart';
import 'package:frontend/screens/auth/forgot_password_enter_code_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce App',
      theme: ThemeData(
        colorScheme: _colorScheme(),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.background,
          titleTextStyle: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.all(20),
          border: InputBorder.none,
          labelStyle: TextStyle(
            color: Colors.black54,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                const Color(0xFFDB3022), // set the background color
            foregroundColor: Colors.white,
            elevation: 2,
          ),
        ),
      ),
      routes: Routes.getRoutes(),
      home: const ForgotPasswordEnterCodeScreen(),
    );
  }

  ColorScheme _colorScheme() => const ColorScheme(
        brightness: Brightness.dark,
        primary: Color.fromARGB(255, 83, 83, 83),
        onPrimary: Color.fromARGB(255, 255, 255, 255),
        onSecondary: Color.fromARGB(255, 147, 149, 211),
        secondary: Color.fromARGB(120, 147, 149, 211),
        error: Colors.redAccent,
        onError: Color.fromARGB(170, 255, 82, 82),
        background: Color(0xFFF9F9F9),
        onBackground: Color.fromARGB(120, 147, 149, 211),
        surface: Color(0xff9395D3),
        onSurface: Color.fromARGB(255, 36, 36, 36),
      );
}
