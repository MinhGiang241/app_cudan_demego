part of 'chat_message_bloc.dart';

@immutable
abstract class ChatMessageEvent {}

@immutable
class LoadChatMessageStart extends ChatMessageEvent {
  LoadChatMessageStart({this.roomId, this.visitorToken, this.webSocketChannel});
  String? roomId;
  WebSocketChannel? webSocketChannel;
  String? visitorToken;
}

@immutable
class BackChatMessageInit extends ChatMessageEvent {
  BackChatMessageInit();
}
