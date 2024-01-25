part of 'ai_cubit.dart';

sealed class AiState {
  final List<Message> messages;

  AiState({required this.messages});
}

final class AiInitial extends AiState {
  AiInitial({required super.messages});
}

final class AiLoading extends AiState {
  AiLoading({required super.messages});
}

final class AiLoaded extends AiState {
  AiLoaded({required super.messages});
}

final class AiError extends AiState {
  final String error;

  AiError({required this.error, required super.messages});
}
