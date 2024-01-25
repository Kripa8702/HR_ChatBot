import 'package:chatbot/constants/colors.dart';
import 'package:chatbot/constants/image_constants.dart';
import 'package:chatbot/cubits/ai/ai_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    context.read<AiCubit>().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: screenGradient,
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(50)
                  ),
                ),
                Image.asset(splash_logo, height: 45,),
              ],
            ),
            title: const Text(
              'Alto',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            backgroundColor: chatColor1,
            elevation: 20,
          ),
          body: Center(
            child: BlocBuilder<AiCubit, AiState>(
              builder: (context, state) {
                Future.delayed(const Duration(milliseconds: 100), () {
                  _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                  );
                });
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          controller: _scrollController,
                          itemBuilder: (context, index) {
                            final message = state.messages[index];
                            return Padding(
                              padding: EdgeInsets.only(
                                left: message.isMe ? 64 : 8,
                                right: message.isMe ? 8 : 64,
                              ),
                              child: Align(
                                alignment: message.isMe
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Container(
                                  margin: const EdgeInsets.all(8),
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color:
                                        message.isMe ? chatColor1 : chatColor2,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                          message.isMe ? 16 : 2),
                                      topRight: Radius.circular(
                                          message.isMe ? 2 : 16),
                                      bottomLeft: const Radius.circular(16),
                                      bottomRight: const Radius.circular(16),
                                    ),
                                  ),
                                  child: message.isMe
                                      ? Text(
                                          message.text,
                                          style: const TextStyle(
                                              color: whiteColor),
                                        )
                                      : Markdown(
                                          data: message.text,
                                          shrinkWrap: true,
                                          styleSheet: MarkdownStyleSheet
                                                  .fromTheme(Theme.of(context))
                                              .copyWith(
                                                  p: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          color: whiteColor)),
                                        ),
                                ),
                              ),
                            );
                          },
                          itemCount: state.messages.length),
                    ),
                    if (state is AiLoading)
                      const Center(
                        child: CircularProgressIndicator(
                          color: chatColor2,
                        ),
                      ),
                    if (state is AiError)
                      Center(
                        child: Text(
                          state.error,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    SizedBox(
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _controller,
                                onSubmitted: (value) async {
                                  context
                                      .read<AiCubit>()
                                      .sendMessage(_controller.text, true);
                                  setState(() {
                                    _controller.clear();
                                  });
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  filled: true,
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  hintText: "Type a message",
                                  fillColor: whiteColor,
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () async {
                                  if (_controller.text.isNotEmpty) {
                                    context
                                        .read<AiCubit>()
                                        .sendMessage(_controller.text, true);
                                    setState(() {
                                      _controller.clear();
                                    });
                                  }
                                },
                                icon: const Icon(
                                  Icons.send,
                                  color: chatColor2,
                                ))
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                );
              },
            ),
          )),
    );
  }
}
