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
import '../../utils/utils.dart';
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

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ChatMessageBloc bloc = context.read<ChatMessageBloc>();

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
              state.webSocketChannel = state.webSocketService
                  .connectToWebSocket(WebsocketConnect.webSocketUrl,
                      authToken: bloc.authToken);
              state.webSocketService.getLastes50Message(
                state.webSocketChannel!,
                WebsocketConnect.room,
              );
              return SafeArea(
                  child: Column(
                children: [
                  Expanded(
                      child: StreamBuilder(
                    stream: state.webSocketChannel!.stream,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return const Center(child: PrimaryLoading());
                        case ConnectionState.done:
                          return const Center(child: PrimaryLoading());
                        case ConnectionState.waiting:
                          return const Center(child: PrimaryLoading());
                        case ConnectionState.active:
                          return _initStateRender(snapshot, state, bloc);
                        default:
                          return const Center(child: PrimaryLoading());
                      }
                      // print(snapshot);
                      // if (snapshot.hasError) {
                      //   return PrimaryErrorWidget(
                      //       code: snapshot.hasError ? "err" : "1",
                      //       message: snapshot.data.toString(),
                      //       onRetry: () async {
                      //         setState(() {});
                      //       });
                      // }
                      // if (!snapshot.hasData) {
                      //   if (snapshot.data != null &&
                      //       json.decode(snapshot.data)['msg'] == 'ping') {
                      //     print("send pong");
                      //     state.webSocketService
                      //         .sendPong(state.webSocketChannel!);
                      //   }
                      //   var data =
                      //       RocketChatData.fromJson(json.decode(snapshot.data));
                      //   if (data.msg == "changed" && data.fields != null) {
                      //     state.addAllMessage(data.result!.messages!);
                      //   }
                      //   return Messages(
                      //     messageMap: state.messagesMap,
                      //     messageBloc: state,
                      //   );
                      // }
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
            } else if (state is ChatMessageGreeting) {
              return vpad(0);
            } else if (state is ChatMessageStart) {
              state.webSocketChannel = state.webSocketService
                  .connectToWebSocket(WebsocketConnect.webSocketUrl,
                      authToken: bloc.authToken);
              print('authTojen; ${bloc.authToken}');
              state.webSocketService.streamChannelMessagesSubscribe(
                state.webSocketChannel!,
                WebsocketConnect.channel,
              );
              // state.webSocketService.getLastes50Message(
              //   state.webSocketChannel!,
              //   WebsocketConnect.room,
              // );

              return StreamBuilder(
                stream: state.webSocketChannel!.stream,
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
                      return _activeStateRender(snapshot, state, bloc);
                    default:
                      return const Center(child: PrimaryLoading());
                  }
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

  Widget _initStateRender(snapshot, state, bloc) {
    print(snapshot);
    if (json.decode(snapshot.data)['msg'] == 'ping') {
      print("send pong");
      state.webSocketService.sendPong(state.webSocketChannel!);
    }
    var data = RocketChatData.fromJson(json.decode(snapshot.data));

    if (data.msg == "added") {
      for (var element in data.result!.messages!) {
        state.addMessage(MessageChat.fromJson(json.decode(element.toString())));
      }
    }

    return vpad(0);
  }

  Widget _activeStateRender(AsyncSnapshot<dynamic> snapshot, state, bloc) {
    if (json.decode(snapshot.data)['msg'] == 'ping') {
      print("send pong");
      state.webSocketService.sendPong(state.webSocketChannel!);
    }
    var data = RocketChatData.fromJson(json.decode(snapshot.data));
    if (data.msg == "changed" && data.fields != null) {
      state.addMessage(data.fields!.args![0]);
    }

    return Column(
      children: [
        Expanded(
            child: Messages(
          messageMap: state.messagesMap,
          messageBloc: state,
        )),
        Align(
          alignment: Alignment.center,
          child: IntrinsicWidth(
            child: PrimaryCard(
              background: grayScaleColor4,
              padding: const EdgeInsets.all(6),
              onTap: () {
                Utils.showConfirmMessage(
                    context: context,
                    title: S.of(context).end,
                    content: S.of(context).confirm_end_chat,
                    onConfirm: () {
                      Navigator.pop(context);
                      bloc.add(BackChatMessageInit());
                    });

                // widget.ctx.watch<HomePrv>().toogleNavigatorFooter();
              },
              child: Row(
                children: [
                  const Icon(Icons.logout),
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
        InputChat(messageBloc: state),
        vpad(10)
      ],
    );
  }
}
