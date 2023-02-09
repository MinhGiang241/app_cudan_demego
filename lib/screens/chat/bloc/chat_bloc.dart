import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:rocket_chat_flutter_connector/models/authentication.dart';
import 'package:rocket_chat_flutter_connector/models/channel.dart';
import 'package:rocket_chat_flutter_connector/models/room.dart';
import 'package:rocket_chat_flutter_connector/models/user.dart';
import 'package:rocket_chat_flutter_connector/services/authentication_service.dart';
import 'package:rocket_chat_flutter_connector/web_socket/web_socket_service.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../models/rocket_chat_data.dart';
import '../custom/custom_websocket_service.dart';
import 'websocket_connect.dart';

class ChatBloc {
  final StreamController<String> _messageController =
      StreamController<String>();
  Stream<String> get messages => _messageController.stream;
  final Stream<QuerySnapshot> messageStream = FirebaseFirestore.instance
      .collection('Messages')
      .orderBy('time')
      .snapshots();
  final TextEditingController textEditionController = TextEditingController();

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  final fs = FirebaseFirestore.instance;
  List<MessageChat> messagesList = [];
  int messageCount = 0;

  bool init = true;

  notInit() {
    init = false;
  }

  void setMessageCount(count) {
    messageCount = count;
    init = false;
  }

  void addMessage(MessageChat m) {
    messagesList.add(m);
  }

  addAllMessage(List<MessageChat> a) {
    messagesList.addAll(a);
  }

  void setMessage(List<MessageChat> m) {
    messagesList = [...m.reversed];
  }

  void scroll(int index) {
    itemScrollController.scrollTo(
        index: index,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOutCubic);
  }

  selectEmoji(String emoji) {
    textEditionController.text = textEditionController.text + emoji;
  }

  summitedMessage(accountId, accountName) async {
    // if (textEditionController.text.trim().isNotEmpty) {
    //   var m = textEditionController.text.trim();

    //   textEditionController.clear();
    //   await fs.collection('Messages').doc().set({
    //     'message': m,
    //     'time': DateTime.now(),
    //     'accountId': accountId,
    //     "accountName": accountName
    //   });
    // }
  }

  void handleMessage(String message) {
    _messageController.add(message);
  }

  void dispose() {
    _messageController.close();
    // webSocketChannel!.sink.close();
  }

  // Rocket chat

  WebSocketChannel? webSocketChannel;
  CustomWebSocketService webSocketService = CustomWebSocketService();
  User? user;

  void sendMessage() {
    if (textEditionController.text.isNotEmpty) {
      // webSocketService.sendMessageOnChannel(textEditionController.text,
      //     webSocketChannel!, WebsocketConnect.channel);

      webSocketService.sendMessageOnRoom(
          textEditionController.text, webSocketChannel!, WebsocketConnect.room);
      textEditionController.clear();
    }
  }

  Future<Authentication> getAuthentication() async {
    final AuthenticationService authenticationService =
        AuthenticationService(WebsocketConnect.rocketHttpService);
    return await authenticationService.login(
        WebsocketConnect.username, WebsocketConnect.password);
  }
}
