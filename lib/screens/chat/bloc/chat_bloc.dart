import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

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

  int messageCount = 0;

  bool init = true;

  notInit() {
    init = false;
  }

  void setMessageCount(count) {
    messageCount = count;
    init = false;
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

  summitedMessage(value, accountId, accountName) async {
    if (textEditionController.text.trim().isNotEmpty) {
      var m = textEditionController.text.trim();

      textEditionController.clear();
      await fs.collection('Messages').doc().set({
        'message': m,
        'time': DateTime.now(),
        'accountId': accountId,
        "accountName": accountName
      });
    }
  }

  void handleMessage(String message) {
    _messageController.add(message);
  }

  void dispose() {
    _messageController.close();
  }
}
