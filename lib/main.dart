import 'package:flutter/material.dart';
import 'screens/home_page.dart';

void main() => runApp(const CoffeeApp());

class CoffeeApp extends StatelessWidget {
  const CoffeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'SF Pro Display',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A1A1A),
          brightness: Brightness.light,
        ),
      ),
    );
  }
}

