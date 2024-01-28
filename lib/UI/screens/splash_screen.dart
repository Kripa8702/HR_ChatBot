import 'dart:async';
import 'package:chatbot/UI/screens/chat.dart';
import 'package:chatbot/constants/colors.dart';
import 'package:chatbot/constants/image_constants.dart';
import 'package:chatbot/cubits/ai/ai_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    context.read<AiCubit>().init();
    super.initState();
  }
  // @override
  // void initState() {
  //   super.initState();
  //   Timer(const Duration(seconds: 3),
  //           ()=>Navigator.pushReplacement(context,
  //           MaterialPageRoute(builder:
  //               (context) =>
  //               const ChatScreen()
  //           )
  //       )
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: screenGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Hello, I'm Alto! ",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: chatColor2,
                          ),
                        ),
                        Image.asset(
                          hello,
                          height: 38,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 50),
                      child: Image.asset(
                        splash_logo,
                        height: 220,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const Text(
                      "Your very own personal AtliQ HR Chatbot. Alto is here to help you with any queries you have. ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChatScreen()));
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  // height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: chatColor2),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          "Start Chat with Alto",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: whiteColor),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 18,
                        color: whiteColor,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
