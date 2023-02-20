// ignore_for_file: must_be_immutable

part of 'chat_message_bloc.dart';

@immutable
abstract class ChatMessageState {}

class ChatMessageInitial extends ChatMessageState {
  ChatMessageInitial({
    this.user,
    this.authToken,
  });

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
  void addMessage(MessageChat m) {
    messagesMap[m.id ?? ''] = m;
  }

  addAllMessage(List<MessageChat> a) {
    for (var i in a) {
      messagesMap[i.id ?? ""] = i;
    }
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
          val.trim(), webSocketChannel!, WebsocketConnect.room);
    }
  }

  void sendMessage() {
    if (textEditionController.text.isNotEmpty) {
      // webSocketService.sendMessageOnChannel(textEditionController.text,
      //     webSocketChannel!, WebsocketConnect.channel);

      webSocketService.sendMessageOnRoom(
          textEditionController.text, webSocketChannel!, WebsocketConnect.room);
      textEditionController.clear();
    }
  }

  uploadFileOnRoom(
    File file,
  ) {
    webSocketService.sendUploadFileOnRoom(
        webSocketChannel!,
        WebsocketConnect.room,
        file,
        textEditionController.text.trim(),
        authToken,
        user!.id);
    textEditionController.clear();
  }
}
