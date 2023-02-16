part of 'chat_message_bloc.dart';

@immutable
abstract class ChatMessageState {}

class ChatMessageInitial extends ChatMessageState {}

class ChatMessageStart extends ChatMessageState {}
