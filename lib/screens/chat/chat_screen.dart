import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:app_cudan/constants/constants.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/screens/chat/bloc/chat_message_bloc.dart';

import 'package:app_cudan/widgets/primary_loading.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rocket_chat_flutter_connector/web_socket/notification.dart'
    as rocket_notification;

import '../../generated/l10n.dart';
import '../../models/rocket_chat_data.dart';
import '../../utils/utils.dart';
import '../../widgets/primary_card.dart';

import 'bloc/websocket_connect.dart';
import 'widget/input_chat.dart';
import 'widget/list_message_subject.dart';
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
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
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
    var token = context.read<ResidentInfoPrv>().userInfo?.account?.id;
    var roomId = context.read<ResidentInfoPrv>().userInfo?.account?.id;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: PrimaryScreen(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(4.0),
            child: CircleAvatar(
              radius: 32,
              child: Image.asset(AppImage.receiption),
            ),
          ),
          // centerTitle: false,
          title: Text(S.of(context).customer_care),
          backgroundColor: primaryColor4,
        ),
        body: BlocBuilder<ChatMessageBloc, ChatState>(
          bloc: bloc,
          builder: (context, state) {
            // if (state.stateChat == StateChatEnum.INIT) {
            state.webSocketChannel =
                bloc.webSocketService.connectToWebSocketLiveChat(
              WebsocketConnect.webSocketUrl,
            );
            // }

            var email =
                context.read<ResidentInfoPrv>().userInfo?.account?.email;
            var token = context.read<ResidentInfoPrv>().userInfo?.account?.id;
            var phone =
                context.read<ResidentInfoPrv>().userInfo?.account?.userName;
            var name =
                context.read<ResidentInfoPrv>().userInfo?.account?.fullName;
            var residentId = context.read<ResidentInfoPrv>().residentId;
            return FutureBuilder(
              future: () async {
                if (state.stateChat == StateChatEnum.INIT) {
                  await bloc.createVisitor(
                    context,
                    email,
                    token,
                    phone,
                    name,
                    residentId,
                  );
                  var room = await bloc.openNewRoomLiveChat(token!);
                  bloc.setRoomId(room?['room']?['_id']);

                  var his = await bloc.loadLiveChatHistory(
                    room?['room']?['_id'],
                    roomId,
                  );
                }
              }(),
              builder: (context, sn) {
                if (sn.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: PrimaryLoading(),
                  );
                }
                bloc.streamLiveChatRoom(token!, token, roomId!);
                return SafeArea(
                  child: StreamBuilder(
                    stream: state.webSocketChannel!.stream,
                    builder: (context, snapshot) {
                      log(snapshot.toString());
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            Expanded(
                              child: _activeStateRender(
                                snapshot,
                                state,
                                bloc,
                              ),
                            ),
                            if (state.stateChat == StateChatEnum.INIT)
                              Align(
                                alignment: Alignment.center,
                                child: IntrinsicWidth(
                                  child: PrimaryCard(
                                    background: grayScaleColor4,
                                    padding: const EdgeInsets.all(6),
                                    onTap: () {
                                      bloc.add(
                                        LoadChatMessageStart(
                                          roomId: state.roomId,
                                          messagesMap: state.messagesMap,
                                          // webSocketChannel:
                                          //     state.webSocketChannel,
                                        ),
                                      );

                                      Future.delayed(
                                        const Duration(milliseconds: 400),
                                      ).then((v) {
                                        bloc.sendStartMessage(token, "Bắt đầu");
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        const Icon(Icons.login),
                                        hpad(10),
                                        Text(
                                          S.of(context).start_chat,
                                          overflow: TextOverflow.ellipsis,
                                          style: txtRegular(
                                              14, grayScaleColorBase),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            if (state.showGreeting)
                              ListMessageSubject(
                                bloc: bloc,
                                toogleGreeting: () {
                                  bloc.toogleGreeting();
                                },
                              ),
                            if (state.stateChat == StateChatEnum.START)
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
                                          var rid = context
                                              .read<ResidentInfoPrv>()
                                              .userInfo
                                              ?.account
                                              ?.id;
                                          Navigator.pop(context);
                                          bloc.add(BackChatMessageInit());
                                          bloc.closeChatRoom(rid!);
                                        },
                                      );

                                      // widget.ctx.watch<HomePrv>().toogleNavigatorFooter();
                                    },
                                    child: Row(
                                      children: [
                                        const Icon(Icons.logout),
                                        hpad(10),
                                        Text(
                                          S.of(context).end_chat,
                                          overflow: TextOverflow.ellipsis,
                                          style: txtRegular(
                                              14, grayScaleColorBase),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            if (!state.showGreeting &&
                                state.stateChat == StateChatEnum.START)
                              InputChat(messageState: state, messageBloc: bloc),
                            vpad(10)
                          ],
                        );
                      }
                      return const Center(child: PrimaryLoading());
                    },
                  ),
                );
              },
            );

            // if (state.stateChat == StateChatEnum.INIT) {
            //   state.webSocketChannel =
            //       state.webSocketService.connectToWebSocketLiveChat(
            //     WebsocketConnect.webSocketUrl,
            //   );

            //   var token = context.read<ResidentInfoPrv>().userInfo?.account?.id;
            //   var roomId =
            //       context.read<ResidentInfoPrv>().userInfo?.account?.id;

            //   // var contextBloc = context.read<ChatMessageBloc>();
            //   return FutureBuilder(
            //     future: () async {
            //       var room = await bloc.openNewRoomLiveChat(token!);
            //       bloc.setRoomId(room?['room']?['_id']);
            //       var his = await bloc.loadLiveChatHistory(
            //         room?['room']?['_id'],
            //         roomId,
            //       );
            //     }(),
            //     builder: (context, sn) {
            //       if (sn.connectionState == ConnectionState.waiting) {
            //         return const Center(
            //           child: PrimaryLoading(),
            //         );
            //       }

            //       bloc.streamLiveChatRoom(token!, token, roomId!);
            //       return SafeArea(
            //         child:
            //             // Column(
            //             //   children: [
            //             //     Expanded(child: Text("sasaslsllas")),
            //             //   ],
            //             // )
            //             Column(
            //           children: [
            //             Expanded(
            //               child: StreamBuilder(
            //                 stream: state.webSocketChannel!.stream,
            //                 builder: (context, snapshot) {
            //                   log(snapshot.toString());

            //                   switch (snapshot.connectionState) {
            //                     case ConnectionState.none:
            //                       return const Center(
            //                         child: PrimaryLoading(),
            //                       );
            //                     case ConnectionState.done:
            //                       return const Center(
            //                         child: PrimaryLoading(),
            //                       );
            //                     case ConnectionState.waiting:
            //                       return const Center(
            //                         child: PrimaryLoading(),
            //                       );
            //                     case ConnectionState.active:
            //                       return _initStateRender(
            //                         snapshot,
            //                         state,
            //                         bloc,
            //                         token,
            //                       );
            //                     default:
            //                       return const Center(
            //                         child: PrimaryLoading(),
            //                       );
            //                   }
            //                 },
            //               ),
            //             ),
            //             Align(
            //               alignment: Alignment.center,
            //               child: IntrinsicWidth(
            //                 child: PrimaryCard(
            //                   background: grayScaleColor4,
            //                   padding: const EdgeInsets.all(6),
            //                   onTap: () {
            //                     bloc.add(
            //                       LoadChatMessageStart(
            //                         roomId: state.roomId,
            //                       ),
            //                     );
            //                     Future.delayed(
            //                       const Duration(milliseconds: 400),
            //                     ).then((v) {
            //                       bloc.sendStartMessage(token, "Bắt đầu");
            //                     });
            //                   },
            //                   child: Row(
            //                     children: [
            //                       const Icon(Icons.login),
            //                       hpad(10),
            //                       Text(
            //                         S.of(context).start_chat,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: txtRegular(14, grayScaleColorBase),
            //                       )
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //             ),
            //             vpad(10)
            //           ],
            //         ),
            //       );
            //     },
            //   );
            // } else if (state.stateChat == StateChatEnum.START) {
            //   state.webSocketChannel =
            //       state.webSocketService.connectToWebSocketLiveChat(
            //     WebsocketConnect.webSocketUrl,
            //   );
            //   var token = context.read<ResidentInfoPrv>().userInfo?.account?.id;
            //   var roomId = state.roomId;
            //   bloc.streamLiveChatRoom(token!, token, token);

            //   return StreamBuilder(
            //     stream: state.webSocketChannel!.stream,
            //     builder: (context, snapshot) {
            //       log(snapshot.toString());
            //       // rocket_notification.Notification? notification =
            //       //     snapshot.hasData
            //       //         ? rocket_notification.Notification.fromMap(
            //       //             jsonDecode(snapshot.data),
            //       //           )
            //       //         : null;

            //       switch (snapshot.connectionState) {
            //         case ConnectionState.none:
            //           return const Center(child: PrimaryLoading());
            //         case ConnectionState.done:
            //           return const Center(child: PrimaryLoading());
            //         case ConnectionState.waiting:
            //           return const Center(child: PrimaryLoading());
            //         case ConnectionState.active:
            //           return _activeStateRender(
            //             snapshot,
            //             state,
            //             bloc,
            //           );
            //         default:
            //           return const Center(child: PrimaryLoading());
            //       }
            //     },
            //   );
            // } else {
            //   return const PrimaryLoading();
            // }
          },
        ),
      ),
    );
  }

  Widget _initStateRender(snapshot, ChatState state, bloc, token) {
    if (json.decode(snapshot.data)['msg'] == 'ping') {
      print("send pong");
      bloc.webSocketService.sendPong(state.webSocketChannel!);
    }
    var data = RocketChatData.fromJson(json.decode(snapshot.data));

    if (data.msg == "added" && data.result != null) {
      for (var element in data.result!.messages!) {
        bloc.addMessage(MessageChat.fromJson(json.decode(element.toString())));
      }
    }
    var dataJson = json.decode(snapshot.data);

    if (dataJson['msg'] == "result" && dataJson['result'] != null) {
      bloc.addMessage(MessageChat.fromJson(dataJson['result']));
    }
    if (data.msg == "result" && data.result != null) {
      var d = data.result!.messages!.reversed.toList();
      for (var el in d) {
        // var m = json.decode(element.toString());
        bloc.addMessage(el);
      }
    }
    if (data.msg == "changed" && data.fields != null) {
      bloc.addMessage(data.fields!.args![0]);
    }

    // Timer.periodic(const Duration(seconds: 1), (timer) {
    //   state.webSocketService.streamChannelMessagesSubscribe(
    //     state.webSocketChannel!,
    //     WebsocketConnect.channel,
    //   );
    // });

    return Messages(
      refreshController: _refreshController,
      messageMap: state.messagesMap,
      messageBloc: bloc,
      messageState: state,
      onRefresh: () {
        bloc.loadLiveChatHistory(state.roomId, token);
        _refreshController.refreshCompleted();
      },
    );
  }

  Widget _activeStateRender(
    AsyncSnapshot<dynamic> snapshot,
    ChatState state,
    bloc,
  ) {
    var accountId = context.read<ResidentInfoPrv>().userInfo!.account?.id;

    var dataJson = json.decode(snapshot.data);
    if (json.decode(snapshot.data)['msg'] == 'ping') {
      print("send pong");
      bloc.webSocketService.sendPong(state.webSocketChannel!);
    }
    var data = RocketChatData.fromJson(json.decode(snapshot.data));
    if (data.msg == "changed" && data.fields != null) {
      bloc.addMessage(data.fields!.args![0]);
    }
    if (dataJson['msg'] == "result" && dataJson['result'] != null) {
      bloc.addMessage(MessageChat.fromJson(dataJson['result']));
    }

    if (dataJson['result']['newRoom'] == true) {
      bloc.setRoomId(dataJson['result']['rid']);
    }

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Messages(
              refreshController: _refreshController,
              messageMap: state.messagesMap,
              messageBloc: bloc,
              messageState: state,
            ),
          ),
          // if (state.showGreeting)
          //   ListMessageSubject(
          //     bloc: bloc,
          //     toogleGreeting: () {
          //       setState(() {
          //         bloc.toogleGreeting();
          //       });
          //     },
          //   ),
          // if (state.stateChat == StateChatEnum.START)
          //   Align(
          //     alignment: Alignment.center,
          //     child: IntrinsicWidth(
          //       child: PrimaryCard(
          //         background: grayScaleColor4,
          //         padding: const EdgeInsets.all(6),
          //         onTap: () {
          //           Utils.showConfirmMessage(
          //             context: context,
          //             title: S.of(context).end,
          //             content: S.of(context).confirm_end_chat,
          //             onConfirm: () {
          //               var rid = context
          //                   .read<ResidentInfoPrv>()
          //                   .userInfo
          //                   ?.account
          //                   ?.id;
          //               Navigator.pop(context);
          //               bloc.add(BackChatMessageInit());
          //               bloc.closeChatRoom(rid!);
          //             },
          //           );

          //           // widget.ctx.watch<HomePrv>().toogleNavigatorFooter();
          //         },
          //         child: Row(
          //           children: [
          //             const Icon(Icons.logout),
          //             hpad(10),
          //             Text(
          //               S.of(context).end_chat,
          //               overflow: TextOverflow.ellipsis,
          //               style: txtRegular(14, grayScaleColorBase),
          //             )
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // if (!state.showGreeting && state.stateChat == StateChatEnum.START)
          //   InputChat(messageState: state, messageBloc: bloc),
          vpad(10)
        ],
      ),
    );
  }
}
