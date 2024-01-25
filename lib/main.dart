import 'package:chatbot/UI/screens/chat.dart';
import 'package:chatbot/constants/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

void main() {
  Gemini.init(
      apiKey: apiKey, enableDebugging: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Gemini',
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark(
          useMaterial3: true,
        ).copyWith(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            cardTheme: CardTheme(color: Colors.blue.shade900)),
        home: const ChatScreen());
  }
}
