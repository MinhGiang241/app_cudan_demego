// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable, constant_identifier_names

part of 'chat_message_bloc.dart';

@immutable
abstract class ChatMessageState {}

class ChatMessageInitial extends ChatMessageState {
  ChatMessageInitial({
    this.user,
    this.authToken,
    this.roomId,
    required this.visitorToken,
  });

  String? authToken;
  String visitorToken;
  String? roomId;
  User? user;
  WebSocketChannel? webSocketChannel;
  CustomWebSocketService webSocketService = CustomWebSocketService();
  ScrollController scrollController = ScrollController();
  StreamController<String> messageController = StreamController();
  void scroll() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  final Map<String, MessageChat> messagesMap = {};

  void registerGuestChat(String token, String name, String email) {
    webSocketService.registerGuestChat(
      webSocketChannel!,
      visitorToken,
      name,
      email,
    );
  }

  void getInitialDataLive() {
    webSocketService.getInitialDataLive(
      webSocketChannel!,
    );
  }

  void sendMessageLiveChat(
    String id,
    String rid,
    String token,
    String message,
  ) {
    webSocketService.sendMessageLiveChat(
      webSocketChannel!,
      id,
      roomId ?? rid,
      visitorToken,
      message,
    );
  }

  Future openNewRoomLiveChat(String token) async {
    return await webSocketService.openNewRoomLiveChat(
      webSocketChannel!,
      token,
      null,
    );
  }

  setRoomId(String? rId) {
    roomId = rId;
  }

  bool init = true;
  setNotInit() {
    init = false;
  }

  void streamLiveChatRoom(String visitorToken, String id, String param) {
    webSocketService.streamLiveChatRoom(
      webSocketChannel!,
      visitorToken,
      roomId ?? id,
      roomId ?? param,
    );
  }

  void addMessage(MessageChat m) {
    messagesMap[m.id ?? ''] = m;
  }

  void setReaction(String emoji, String messageId) {
    webSocketService.setReaction(
      webSocketChannel!,
      emoji,
      messageId,
      visitorToken,
    );
  }

  addAllMessage(List<MessageChat> a) {
    for (var i in a) {
      messagesMap[i.id ?? ""] = i;
    }
  }

  Future closeLiveChatRoom() async {}

  Future loadLiveChatHistory(roomId, token) async {
    await webSocketService.loadLiveChatHistory(roomId, token).then((v) {
      if (v['messages'] != null) {
        messagesMap.clear();
        for (var i in v['messages'].reversed) {
          var me = MessageChat.fromJson(i);
          // print(i);
          messagesMap[me.id ?? ""] = me;
        }
      }
    });
  }

  genUniqueId() {
    return uuid.v4();
  }

  void sendStartMessage(String? token, String message) {
    if (message.isNotEmpty) {
      webSocketService.sendMessageLiveChat(
        webSocketChannel!,
        genUniqueId(),
        roomId ?? '',
        token ?? "",
        message,
      );
    }
  }
}

class ChatMessageGreeting extends ChatMessageState {
  ChatMessageGreeting({this.user, this.authToken});
  String? authToken;
  User? user;
}

bool init = true;

class ChatMessageStart extends ChatMessageState {
  ChatMessageStart({
    this.user,
    this.authToken,
    this.roomId,
    required this.visitorToken,
    this.webSocketChannel,
  });
  final String? authToken;
  String visitorToken;
  String? roomId;
  User? user;
  bool showGreeting = true;
  void toogleGreeting() {
    showGreeting = !showGreeting;
  }

  setRoomId(String? rId) {
    roomId = rId;
  }

  StreamController<String> messageController = StreamController();
  // Stream<String> get messages => messageController.stream;

  final TextEditingController textEditionController = TextEditingController();

  // final ItemScrollController itemScrollController = ItemScrollController();
  ScrollController scrollController = ScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  final List<MessageChat> messagesList = [];
  final Map<String, MessageChat> messagesMap = {};

  void addMessage(MessageChat m) {
    messagesList.add(m);
    messagesMap[m.id ?? ''] = m;
  }

  addAllMessage(List<MessageChat> a) {
    messagesList.addAll(a);
  }

  void setMessage(List<MessageChat> m) {
    messagesList.addAll([...m]);
  }

  void scroll() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  selectEmoji(String emoji) {
    textEditionController.text = textEditionController.text + emoji;
  }

  void handleMessage(String message) {
    messageController.add(message);
  }

  void dispose() {
    messageController.close();
    // webSocketChannel!.sink.close();
  }

  // Rocket chat

  WebSocketChannel? webSocketChannel;
  CustomWebSocketService webSocketService = CustomWebSocketService();

  void updateChat(MessageChat message, WebSocketChannel socketChannel) {
    webSocketService.updateMessageOnRoom(
      message,
      socketChannel,
    );
  }

  void setReaction(String emoji, String messageId) {
    webSocketService.setReaction(
      webSocketChannel!,
      emoji,
      messageId,
      visitorToken,
    );
  }

  void closeChatRoom(String rid) {
    webSocketService.closeLiveChatRoom(rid, visitorToken);
  }

  genUniqueId() {
    return uuid.v4();
  }

  closeLiveChat(String rid) {
    webSocketService.closeLiveChatRoom(rid, visitorToken);
  }

  void sendGreetingMessage(String rid, String token, String message) {
    if (message.isNotEmpty) {
      webSocketService.sendMessageLiveChat(
        webSocketChannel!,
        genUniqueId(),
        roomId ?? rid,
        token,
        message,
      );
    }
  }

  void sendStartMessage(String? token, String message) {
    if (message.isNotEmpty) {
      webSocketService.sendMessageLiveChat(
        webSocketChannel!,
        genUniqueId(),
        roomId ?? '',
        token ?? "",
        message,
      );
    }
  }

  void sendMessage(String token) {
    if (textEditionController.text.isNotEmpty) {
      // webSocketService.sendMessageOnChannel(textEditionController.text,
      //     webSocketChannel!, WebsocketConnect.channel);
      print('text:${textEditionController.text.trim()}');
      webSocketService.sendMessageLiveChat(
        webSocketChannel!,
        genUniqueId(),
        roomId ?? token,
        token,
        textEditionController.text.trim(),
      );
      textEditionController.clear();
    }
  }

  void sendMessageLiveChat(
    String id,
    String rid,
    String token,
    String message,
  ) {
    webSocketService.sendMessageLiveChat(
      webSocketChannel!,
      id,
      roomId ?? token,
      visitorToken,
      message,
    );
  }

  void streamLiveChatRoom(String visitorToken, String id, String param) {
    webSocketService.streamLiveChatRoom(
      webSocketChannel!,
      visitorToken,
      roomId ?? id,
      roomId ?? param,
    );
  }

  uploadFileOnRoom(File file, token) {
    webSocketService.sendUploadFileOnRoom(
      webSocketChannel!,
      WebsocketConnect.room,
      file,
      textEditionController.text.trim(),
      token,
      user!.id,
    );
    textEditionController.clear();
  }

  sendUploadFileOnLiveChat(File file, token, rid) {
    webSocketService.sendUploadFileOnLiveChat(
      webSocketChannel!,
      roomId ?? rid,
      file,
      textEditionController.text.trim(),
      visitorToken,
    );
    textEditionController.clear();
  }
}

enum StateChatEnum {
  INIT,
  START,
}

class ChatState {
  String? authToken;
  String? visitorToken;
  String? roomId;
  Map<String, dynamic>? user;
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
