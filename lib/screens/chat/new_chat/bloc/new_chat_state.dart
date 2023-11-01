// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'new_chat_bloc.dart';

// class NewChatState extends Equatable {
//   const NewChatState();

//   @override
//   List<Object> get props => [];
// }

class NewChatState {
  bool isInit;
  types.User? user;
  List<types.Message> messages = [];

  types.User? employee;
  String? authToken;
  String? visitorToken;
  String? roomId;
  WebSocketChannel? webSocketChannel;
  int percent = 0;
  int count = 0;
  bool isActiveScreen = true;
  CustomWebSocketService webSocketService = CustomWebSocketService();
  NewChatState({
    this.isInit = false,
    this.user,
    required this.messages,
    this.employee,
    this.authToken,
    this.visitorToken,
    this.roomId,
    this.webSocketChannel,
    this.percent = 0,
    this.count = 0,
    this.isActiveScreen = true,
  }) {
    if (!isInit) {
      webSocketChannel = NewChatServices.shared.connectToWebSocketLiveChat(
        WebsocketConnect.webSocketUrl,
      );
    }
  }

  NewChatState copyWith({
    bool? isInit,
    types.User? user,
    List<types.Message>? messages,
    types.User? employee,
    String? authToken,
    String? visitorToken,
    String? roomId,
    WebSocketChannel? webSocketChannel,
    int? percent,
    int? count,
    bool? isActiveScreen,
  }) {
    return NewChatState(
      isInit: isInit ?? this.isInit,
      user: user ?? this.user,
      messages: messages ?? this.messages,
      employee: employee ?? this.employee,
      authToken: authToken ?? this.authToken,
      visitorToken: visitorToken ?? this.visitorToken,
      roomId: roomId ?? this.roomId,
      percent: percent ?? this.percent,
      webSocketChannel: webSocketChannel ?? this.webSocketChannel,
      count: count ?? this.count,
      isActiveScreen: isActiveScreen ?? this.isActiveScreen,
    );
  }

  @override
  List<dynamic> get props {
    return [
      isInit,
      user,
      messages,
      employee,
      authToken,
      visitorToken,
      roomId,
      webSocketChannel,
      percent,
      count,
      isActiveScreen,
    ];
  }
}
