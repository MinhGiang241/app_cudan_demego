part of 'chat_message_bloc.dart';

@immutable
abstract class ChatMessageEvent {}

@immutable
class LoadChatMessageStart extends ChatMessageEvent {
  LoadChatMessageStart({this.roomId});
  String? roomId;
}

@immutable
class BackChatMessageInit extends ChatMessageEvent {
  BackChatMessageInit();
}
