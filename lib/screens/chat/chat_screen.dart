import 'package:app_cudan/constants/constants.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../generated/l10n.dart';
import 'bloc/chat_bloc.dart';
import 'widget/input_chat.dart';
import 'widget/messages.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  static const routeName = '/chat';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatBloc _messageBloc = ChatBloc();

  // @override
  // void initState() {
  //   super.initState();
  //   FirebaseMessaging().configure(
  //     onMessage: (Map<String, dynamic> message) async {
  //       _messageBloc.handleMessage(message['notification']['body']);
  //     },
  //   );
  // }

  @override
  void dispose() {
    _messageBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScreen(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child:
              CircleAvatar(radius: 32, child: Image.asset(AppImage.receiption)),
        ),
        // centerTitle: false,
        title: Text(S.of(context).customer_care),
        backgroundColor: primaryColor4,
      ),
      body: StreamBuilder(
          stream: _messageBloc.messages,
          builder: (context, snapshot) {
            return Column(
              children: [
                Expanded(child: Measages(messageBloc: _messageBloc)),
                InputChat(fs: _messageBloc.fs, messageBloc: _messageBloc),
                vpad(10)
              ],
            );
          }),
    );
  }
}
