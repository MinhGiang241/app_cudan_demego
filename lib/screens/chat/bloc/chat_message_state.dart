// ignore_for_file: must_be_immutable

part of 'chat_message_bloc.dart';

@immutable
abstract class ChatMessageState {}

class ChatMessageInitial extends ChatMessageState {
  ChatMessageInitial({
    this.user,
    this.authToken,
  });

  @override
  String? authToken;
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
    webSocketService.registerGuestChat(webSocketChannel!, token, name, email);
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
      rid,
      token,
      message,
    );
  }

  Future openNewRoomLiveChat(String roomId) async {
    return await webSocketService.openNewRoomLiveChat(
      webSocketChannel!,
      roomId,
    );
  }

  void streamLiveChatRoom(String visitorToken, String id, String param) {
    webSocketService.streamLiveChatRoom(
      webSocketChannel!,
      visitorToken,
      id,
      param,
    );
  }

  void addMessage(MessageChat m) {
    messagesMap[m.id ?? ''] = m;
  }

  void setReaction(String emoji, String messageId) {
    webSocketService.setReaction(webSocketChannel!, emoji, messageId);
  }

  addAllMessage(List<MessageChat> a) {
    for (var i in a) {
      messagesMap[i.id ?? ""] = i;
    }
  }

  Future loadLiveChatHistory(roomId) async {
    await webSocketService.loadLiveChatHistory(roomId).then((v) {
      print(v);
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
}

class ChatMessageGreeting extends ChatMessageState {
  ChatMessageGreeting({this.user, this.authToken});
  String? authToken;
  User? user;
}

class ChatMessageStart extends ChatMessageState {
  ChatMessageStart({
    this.user,
    this.authToken,
  });
  final String? authToken;
  final User? user;
  bool showGreeting = true;
  void toogleGreeting() {
    showGreeting = !showGreeting;
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
    webSocketService.setReaction(webSocketChannel!, emoji, messageId);
  }

  void sendGreetingMessage(String val) {
    if (val.isNotEmpty) {
      webSocketService.sendMessageOnRoom(
        val.trim(),
        webSocketChannel!,
        WebsocketConnect.room,
      );
    }
  }

  void sendMessage(String rid) {
    if (textEditionController.text.isNotEmpty) {
      // webSocketService.sendMessageOnChannel(textEditionController.text,
      //     webSocketChannel!, WebsocketConnect.channel);
      print('text:${textEditionController.text.trim()}');
      webSocketService.sendMessageLiveChat(
        webSocketChannel!,
        "id",
        rid,
        rid,
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
      rid,
      token,
      message,
    );
  }

  void streamLiveChatRoom(String visitorToken, String id, String param) {
    webSocketService.streamLiveChatRoom(
      webSocketChannel!,
      visitorToken,
      id,
      param,
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

  sendUploadFileOnLiveChat(File file, token, roomId) {
    webSocketService.sendUploadFileOnLiveChat(
      webSocketChannel!,
      roomId,
      file,
      textEditionController.text.trim(),
      token,
    );
    textEditionController.clear();
  }
}
