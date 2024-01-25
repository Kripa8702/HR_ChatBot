import 'package:chatbot/constants/string.dart';
import 'package:chatbot/models/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final gemini = Gemini.instance;
  final List<Message> _messages = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _messages.add(Message(dummyPolicies, true));
    call();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('HR ChatBot'),
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
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
                                      ? Colors.blue.shade900
                                      : Colors.blue.shade700,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text(
                                message.text,
                                style: const TextStyle(color: Colors.white),
                              ),
                            )),
                      );
                    },
                    itemCount: _messages.length),
              ),
              SizedBox(
                height: 60,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter a search term',
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          setState(() {
                            _messages.add(Message(_controller.text, true));
                            _controller.clear();
                          });
                          call();
                        },
                        icon: const Icon(Icons.send))
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> call() async {
    final res = await gemini.chat(_messages
        .map((e) => Content(
            parts: [Parts(text: e.text)], role: e.isMe ? 'user' : 'model'))
        .toList());
    String rslt = '';
    for (var i = 0; i < (res?.output?.length ?? 0); i++) {
      final element = res?.output?[i];
      rslt = '$rslt$element';
    }
    setState(() {
      _messages.add(Message(rslt, false));
    });
  }
}
