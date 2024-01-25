import 'package:chatbot/constants/string.dart';
import 'package:chatbot/models/message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

part 'ai_state.dart';

class AiCubit extends Cubit<AiState> {
  AiCubit() : super(AiInitial(messages: []));

  final List<Message> _messages = [];
  final gemini = Gemini.instance;

  void init() async {
    _messages.add(Message(dummyPolicies, true));
    _callAI();
  }

  void sendMessage(String text, bool isMe) {
    _messages.add(Message(text, isMe));
    _callAI();
  }

  Future<void> _callAI() async {
    emit(AiLoading(messages: messages));
    try {
      final res = await gemini.chat(_messages
          .map((e) => Content(
              parts: [Parts(text: e.text)], role: e.isMe ? 'user' : 'model'))
          .toList());
      String rslt = '';
      for (var i = 0; i < (res?.output?.length ?? 0); i++) {
        final element = res?.output?[i];
        rslt = '$rslt$element';
      }
      _messages.add(Message(rslt, false));
      emit(AiLoaded(messages: messages));
    } catch (e) {
      emit(AiError(error: e.toString(), messages: messages));
    }
  }

  List<Message> get messages => _messages.length > 2
      ? _messages.sublist(2)
      : const [];
}
