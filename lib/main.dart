import 'package:chatbot/UI/screens/chat.dart';
import 'package:chatbot/constants/string.dart';
import 'package:chatbot/cubits/ai/ai_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

void main() {
  Gemini.init(apiKey: apiKey, enableDebugging: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AiCubit>(create: (context) => AiCubit()),
      ],
      child: MaterialApp(
          title: 'Flutter Gemini',
          themeMode: ThemeMode.light,
          debugShowCheckedModeBanner: false,
          darkTheme: ThemeData.light(
            useMaterial3: true,
          ).copyWith(
              colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color(0xff3369FF),
                  primary: const Color(0xff3369FF)),
              scaffoldBackgroundColor: Colors.white),
          home: const ChatScreen()),
    );
  }
}
