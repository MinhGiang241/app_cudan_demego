// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable, constant_identifier_names

part of 'chat_message_bloc.dart';

@immutable
abstract class ChatMessageState {}

enum StateChatEnum {
  INIT,
  START,
}

class ChatState {
  String? authToken;
  String? visitorToken;
  String? roomId;
  Map<String, dynamic>? user;
  bool isExistedSubject = false;
  WebSocketChannel? webSocketChannel;
  CustomWebSocketService webSocketService = CustomWebSocketService();
  ScrollController scrollController = ScrollController();
  StreamController<String> messageController = StreamController();
  Map<String, MessageChat> messagesMap = {};
  bool showGreeting = true;
  final TextEditingController textEditionController = TextEditingController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final List<MessageChat> messagesList = [];
  bool quit;
  StateChatEnum stateChat;
  bool isBack = false;
  bool init = true;
  ChatState({
    this.authToken,
    this.visitorToken,
    this.roomId,
    this.user,
    this.webSocketChannel,
    required this.messagesMap,
    required this.showGreeting,
    required this.stateChat,
    this.quit = false,
    this.isBack = false,
    this.init = true,
  });

  ChatState copyWith({
    String? authToken,
    String? visitorToken,
    String? roomId,
    Map<String, dynamic>? user,
    WebSocketChannel? webSocketChannel,
    bool? showGreeting,
    StateChatEnum? stateChat,
    bool? quit,
  }) {
    return ChatState(
      messagesMap: messagesMap,
      authToken: authToken ?? this.authToken,
      visitorToken: visitorToken ?? this.visitorToken,
      roomId: roomId ?? this.roomId,
      user: user ?? this.user,
      webSocketChannel: webSocketChannel ?? this.webSocketChannel,
      showGreeting: showGreeting ?? this.showGreeting,
      stateChat: stateChat ?? this.stateChat,
      quit: quit ?? this.quit,
    );
  }
}
