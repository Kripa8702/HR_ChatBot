import 'package:chatbot/cubits/ai/ai_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return Scaffold(
        appBar: AppBar(
          title:
              const Text('HR ChatBot', style: TextStyle(color: Colors.white)),
          backgroundColor: const Color(0xff3369FF),
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
                                    color: message.isMe
                                        ? const Color(0xff3369FF)
                                        : Colors.grey.shade300,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                          message.isMe ? 16 : 2),
                                      topRight: Radius.circular(
                                          message.isMe ? 2 : 16),
                                      bottomLeft: const Radius.circular(16),
                                      bottomRight: const Radius.circular(16),
                                    ),
                                  ),
                                  child: Text(
                                    message.text,
                                    style: TextStyle(
                                        color: message.isMe
                                            ? Colors.white
                                            : Colors.black87),
                                  ),
                                )),
                          );
                        },
                        itemCount: state.messages.length),
                  ),
                  if (state is AiLoading)
                    const Center(child: CircularProgressIndicator()),
                  if (state is AiError)
                    Center(
                      child: Text(
                        state.error,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  const Divider(),
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
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter a search term',
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
                              icon: const Icon(Icons.send))
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ));
  }
}
