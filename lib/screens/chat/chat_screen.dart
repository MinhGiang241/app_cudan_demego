import 'dart:convert';

import 'package:app_cudan/constants/constants.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_loading.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rocket_chat_flutter_connector/models/authentication.dart';
import 'package:rocket_chat_flutter_connector/web_socket/notification.dart'
    as rocket_notification;

import '../../generated/l10n.dart';
import '../../models/rocket_chat_data.dart';
import '../../widgets/primary_error_widget.dart';
import 'bloc/chat_bloc.dart';
import 'bloc/websocket_connect.dart';
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
      body: FutureBuilder(
        future: _messageBloc.getAuthentication(),
        builder: (context, AsyncSnapshot<Authentication> snapshot) {
          // if (snapshot.hasError) {
          //   return PrimaryErrorWidget(
          //       code: snapshot.hasError ? "err" : "1",
          //       message: snapshot.data.toString(),
          //       onRetry: () async {
          //         setState(() {});
          //       });
          // }
          if (snapshot.hasData) {
            print(snapshot);
            _messageBloc.user = snapshot.data!.data!.me;

            _messageBloc.webSocketChannel = _messageBloc.webSocketService
                .connectToWebSocket(WebsocketConnect.webSocketUrl,
                    authToken: snapshot.data!.data!.authToken!);
            print(_messageBloc.webSocketChannel);
            _messageBloc.webSocketService.streamChannelMessagesSubscribe(
                _messageBloc.webSocketChannel!, WebsocketConnect.channel);
            // _messageBloc.webSocketService.streamChannelMessagesUnsubscribe(
            //     _messageBloc.webSocketChannel!, WebsocketConnect.channel);
            // _messageBloc.webSocketService.getLastes50Message(
            //   _messageBloc.webSocketChannel!,
            //   WebsocketConnect.room,
            // );

            return StreamBuilder(
              stream: _messageBloc.webSocketChannel!.stream,
              builder: (context, snapshot) {
                rocket_notification.Notification? notification =
                    snapshot.hasData
                        ? rocket_notification.Notification.fromMap(
                            jsonDecode(snapshot.data))
                        : null;
                print(snapshot);
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return const Center(child: PrimaryLoading());
                  case ConnectionState.done:
                    return const Center(child: PrimaryLoading());
                  case ConnectionState.waiting:
                    return const Center(child: PrimaryLoading());
                  case ConnectionState.active:
                    return _activeStateRender(snapshot);
                  default:
                    return const Center(child: PrimaryLoading());
                }
              },
            );
          }
          print(snapshot);
          return const Center(child: PrimaryLoading());
        },
      ),
    );
  }

  Widget _activeStateRender(AsyncSnapshot<dynamic> snapshot) {
    if (json.decode(snapshot.data)['msg'] == 'ping') {
      print("send pong");
      _messageBloc.webSocketService.sendPong(_messageBloc.webSocketChannel!);
    }
    var data = RocketChatData.fromJson(json.decode(snapshot.data));
    if (data.msg == "changed" && data.fields != null) {
      _messageBloc.addAllMessage(data.fields!.args ?? []);
    }
    // if (data.msg == "result") {
    //   if (data.result != null &&
    //       data.result!.messages != null &&
    //       data.result!.messages!.isNotEmpty) {
    //     _messageBloc.setMessage(data.result!.messages!);
    //   }
    //   if (data.result_chat != null &&
    //       data.result_chat != null &&
    //       data.result_chat!.msg!.isNotEmpty) {
    //     _messageBloc.addMessage(data.result_chat!);
    //   }
    // }

    return Column(
      children: [
        Expanded(
            child: Measages(
          messageBloc: _messageBloc,
          messages: _messageBloc.messagesList,
        )),
        InputChat(messageBloc: _messageBloc),
        vpad(10)
      ],
    );
  }
}
