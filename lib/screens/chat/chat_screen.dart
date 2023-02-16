import 'dart:convert';

import 'package:app_cudan/constants/constants.dart';
import 'package:app_cudan/screens/chat/bloc/chat_message_bloc.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_loading.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rocket_chat_flutter_connector/models/authentication.dart';
import 'package:rocket_chat_flutter_connector/web_socket/notification.dart'
    as rocket_notification;

import '../../generated/l10n.dart';
import '../../models/rocket_chat_data.dart';
import '../../widgets/primary_card.dart';
import '../../widgets/primary_error_widget.dart';
import '../home/prv/home_prv.dart';
import 'bloc/chat_bloc.dart';
import 'bloc/websocket_connect.dart';
import 'widget/input_chat.dart';
import 'widget/messages.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
  });
  static const routeName = '/chat';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

final ChatBloc _messageBloc = ChatBloc();
final ChatMessageBloc bloc = ChatMessageBloc();

class _ChatScreenState extends State<ChatScreen> {
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: PrimaryScreen(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(4.0),
            child: CircleAvatar(
                radius: 32, child: Image.asset(AppImage.receiption)),
          ),
          // centerTitle: false,
          title: Text(S.of(context).customer_care),
          backgroundColor: primaryColor4,
        ),
        body: BlocBuilder<ChatMessageBloc, ChatMessageState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is ChatMessageInitial) {
              return SafeArea(
                  child: Column(
                children: [
                  Expanded(
                      child: FutureBuilder(
                    future: () {
                      print('dd');
                    }(),
                    builder: (context, state) {
                      return vpad(0);
                    },
                  )),
                  Align(
                    alignment: Alignment.center,
                    child: IntrinsicWidth(
                      child: PrimaryCard(
                        background: grayScaleColor4,
                        padding: const EdgeInsets.all(6),
                        onTap: () {
                          // widget.ctx.watch<HomePrv>().toogleNavigatorFooter();
                          bloc.add(LoadChatMessageStart());
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.login),
                            hpad(10),
                            Text(
                              S.of(context).start_chat,
                              overflow: TextOverflow.ellipsis,
                              style: txtRegular(14, grayScaleColorBase),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  vpad(10)
                ],
              ));
            } else if (state is ChatMessageStart) {
              return FutureBuilder(
                future: _messageBloc.getAuthentication(context),
                builder: (context, AsyncSnapshot<Authentication> snapshot) {
                  if (snapshot.hasError) {
                    return PrimaryErrorWidget(
                        code: snapshot.hasError ? "err" : "1",
                        message: snapshot.data.toString(),
                        onRetry: () async {
                          setState(() {});
                        });
                  }
                  if (snapshot.hasData) {
                    print(snapshot);
                    _messageBloc.user = snapshot.data!.data!.me;

                    _messageBloc.webSocketChannel = _messageBloc
                        .webSocketService
                        .connectToWebSocket(WebsocketConnect.webSocketUrl,
                            authToken: snapshot.data!.data!.authToken!);
                    print(_messageBloc.webSocketChannel);
                    _messageBloc.webSocketService
                        .streamChannelMessagesSubscribe(
                            _messageBloc.webSocketChannel!,
                            WebsocketConnect.channel);
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
              );
            } else {
              return const PrimaryLoading();
            }
          },
        ),
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
      _messageBloc.addMessage(data.fields!.args![0]);
    }

    return Column(
      children: [
        Expanded(
            child: Messages(
          messageMap: _messageBloc.messagesMap,
          messageBloc: _messageBloc,
          messages: _messageBloc.messagesList,
        )),
        Align(
          alignment: Alignment.center,
          child: IntrinsicWidth(
            child: PrimaryCard(
              background: grayScaleColor4,
              padding: const EdgeInsets.all(6),
              onTap: () {
                bloc.add(BackChatMessageInit());
                // widget.ctx.watch<HomePrv>().toogleNavigatorFooter();
              },
              child: Row(
                children: [
                  const Icon(Icons.login),
                  hpad(10),
                  Text(
                    S.of(context).end_chat,
                    overflow: TextOverflow.ellipsis,
                    style: txtRegular(14, grayScaleColorBase),
                  )
                ],
              ),
            ),
          ),
        ),
        InputChat(messageBloc: _messageBloc),
        vpad(10)
      ],
    );
  }
}
