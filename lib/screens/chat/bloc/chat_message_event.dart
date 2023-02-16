part of 'chat_message_bloc.dart';

@immutable
abstract class ChatMessageEvent {}

@immutable
class LoadChatMessageStart extends ChatMessageEvent {
  LoadChatMessageStart();
}

@immutable
class BackChatMessageInit extends ChatMessageEvent {
  BackChatMessageInit();
}
