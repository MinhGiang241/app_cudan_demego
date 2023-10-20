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
  List<types.Message> messages = [
    types.TextMessage(
      author: types.User(
        lastName: "Giang",
        firstName: "Minh",
        imageUrl:
            'https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o=',
        id: '82091008-a484-4a89-ae75-a22bf8d6f3ad',
      ),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: "Đây là message test",
    )
  ];
  List<types.Message> v = [
    types.TextMessage(
      author: types.User(
        lastName: "Giang",
        firstName: "Minh",
        imageUrl:
            'https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o=',
        id: '82091008-a484-4a89-ae75-a22bf8d6f3ad',
      ),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: "Đây là message test",
    )
  ];
  types.User? employee;
  String? authToken;
  String? visitorToken;
  String? roomId;
  WebSocketChannel? webSocketChannel;
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
  }) {
    return NewChatState(
      isInit: isInit ?? this.isInit,
      user: user ?? this.user,
      messages: messages ?? this.messages,
      employee: employee ?? this.employee,
      authToken: authToken ?? this.authToken,
      visitorToken: visitorToken ?? this.visitorToken,
      roomId: roomId ?? this.roomId,
      webSocketChannel: webSocketChannel ?? this.webSocketChannel,
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
    ];
  }
}
