import 'package:flutter/material.dart';
import 'package:password_app/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Password App',
      theme:ThemeData(
        colorScheme: const ColorScheme.light()
      ),
      home: HomeScreen()
    );
  }
}