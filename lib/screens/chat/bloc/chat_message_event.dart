// ignore_for_file: must_be_immutable

part of 'chat_message_bloc.dart';

@immutable
abstract class ChatMessageEvent {}

@immutable
class LoadChatMessageStart extends ChatMessageEvent {
  LoadChatMessageStart({
    this.roomId,
    this.visitorToken,
    this.webSocketChannel,
    this.messagesMap,
  });
  String? roomId;
  WebSocketChannel? webSocketChannel;
  String? visitorToken;
  Map<String, MessageChat>? messagesMap = {};
}

@immutable
class BackChatMessageInit extends ChatMessageEvent {
  BackChatMessageInit();

  bool isBack = true;
}
