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

import '../home/home_screen.dart';
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
    return WillPopScope(
      onWillPop: () async {
        bloc.setIntStateChat();
        Navigator.pushNamedAndRemoveUntil(
          context,
          HomeScreen.routeName,
          (route) => route.isCurrent,
        );

        return false;
      },
      child: GestureDetector(
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
              // bloc.streamLiveChatRoom("", "", roomId!);
              var email =
                  context.read<ResidentInfoPrv>().userInfo?.account?.email;
              var token = context.read<ResidentInfoPrv>().userInfo?.account?.id;
              var phone = context
                  .read<ResidentInfoPrv>()
                  .userInfo
                  ?.account
                  ?.phone_number;
              var name = context.read<ResidentInfoPrv>().userInfo?.info_name ??
                  context.read<ResidentInfoPrv>().userInfo?.account?.fullName;
              var residentId = context.read<ResidentInfoPrv>().residentId;

              if (state.stateChat == StateChatEnum.START) {
                bloc.sendStartMessage(token, "Bắt đầu");
              }

              if (state.stateChat == StateChatEnum.START) {
                return FutureBuilder(
                  future: () async {
                    try {
                      if (state.stateChat == StateChatEnum.START) {
                        var user = await bloc.createVisitor(
                          context,
                          email,
                          token,
                          phone,
                          name,
                          residentId,
                        );

                        print(bloc.user);
                        var roomId = bloc.user?["roomId"];
                        var vtoken = bloc.visitorToken;

                        var room = await bloc.openNewRoomLiveChat(token!);
                        if (room['success'] == false) {
                          throw (room['error']);
                        }
                        bloc.setRoomId(room?['room']?['_id']);
                        bloc.setvisitorToken(room?['room']?['v']?['token']);

                        print(vtoken);
                        var his = await bloc.loadLiveChatHistory(
                          state.roomId,
                          vtoken,
                        );
                      }

                      if (state.stateChat == StateChatEnum.START) {
                        bloc.streamLiveChatRoom("", "", roomId!);
                      }
                    } catch (e) {
                      Utils.showErrorMessage(context, e.toString());
                      bloc.hasError();
                    }
                  }(),
                  builder: (context, sn) {
                    return SafeArea(
                      child: StreamBuilder(
                        stream: state.webSocketChannel!.stream,
                        builder: (context, snapshot) {
                          log(snapshot.toString());
                          if (snapshot.connectionState ==
                              ConnectionState.active) {
                            var dataJson = json.decode(snapshot.data);
                            if (json.decode(snapshot.data)['msg'] == 'ping') {
                              print("send pong");

                              bloc.webSocketService
                                  .sendPong(state.webSocketChannel!);
                            }
                            var data = RocketChatData.fromJson(
                                json.decode(snapshot.data));
                            if (data.msg == "changed" && data.fields != null) {
                              bloc.addMessage(data.fields!.args![0]);
                            }
                            if (dataJson['msg'] == "result" &&
                                dataJson['result'] != null) {
                              var c = MessageChat.fromJson(dataJson['result']);
                              bloc.addMessage(
                                c,
                              );
                              if (c.msg == "Bắt đầu" &&
                                  state.messagesMap['start'] != null) {
                                bloc.addMessage(
                                  MessageChat(id: "start", chatMode: 1),
                                );
                              }
                            }

                            if (dataJson?['result']?['newRoom'] == true) {
                              bloc.add(BackChatMessageInit());
                              bloc.closeChatRoom(state.roomId);
                              // bloc.setRoomId(dataJson['result']['rid']);
                              // bloc.setvisitorToken(dataJson['result']['rid']);
                            }
                            if (dataJson['msg'] == "changed" &&
                                dataJson["fields"] != null &&
                                dataJson['fields']?['args']?[0]['msg'] ==
                                    "Bắt đầu") {
                              bloc.addMessage(
                                MessageChat(id: uuid.v4(), chatMode: 1),
                              );
                            }

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
                                            ),
                                          );
                                          // bloc.sendStartMessage(token, "Bắt đầu");

                                          // bloc.addMessage(MessageChat(chatMode: 1));
                                          bloc.toogleGreeting();
                                          bloc.scroll();
                                        },
                                        child: Row(
                                          children: [
                                            const Icon(Icons.login),
                                            hpad(10),
                                            Text(
                                              S.of(context).start_chat,
                                              overflow: TextOverflow.ellipsis,
                                              style: txtRegular(
                                                14,
                                                grayScaleColorBase,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                // if (state.showGreeting)
                                //   ListMessageSubject(
                                //     bloc: bloc,
                                //     toogleGreeting: () {
                                //       bloc.toogleGreeting();
                                //     },
                                //   ),
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
                                            content:
                                                S.of(context).confirm_end_chat,
                                            onConfirm: () {
                                              var rid = context
                                                  .read<ResidentInfoPrv>()
                                                  .userInfo
                                                  ?.account
                                                  ?.id;
                                              Navigator.pop(context);

                                              bloc
                                                  .closeChatRoom(rid!)
                                                  .then((v) {
                                                bloc.add(BackChatMessageInit());
                                              });
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
                                if (!state.quit &&
                                    state.stateChat == StateChatEnum.START)
                                  InputChat(
                                      messageState: state, messageBloc: bloc),
                                vpad(10)
                              ],
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.done) {
                            bloc.add(BackChatMessageInit());

                            return const Center(child: Text('done'));
                          } else if (snapshot.connectionState ==
                              ConnectionState.none) {
                            return const Center(child: Text('none'));
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(child: PrimaryLoading());
                          }

                          return const Center(child: PrimaryLoading());
                        },
                      ),
                    );
                  },
                );
              } else {
                return SafeArea(
                  child: StreamBuilder(
                    stream: state.webSocketChannel!.stream,
                    builder: (context, snapshot) {
                      log(snapshot.toString());
                      if (snapshot.connectionState == ConnectionState.active) {
                        var accountId = context
                            .read<ResidentInfoPrv>()
                            .userInfo!
                            .account
                            ?.id;

                        var dataJson = json.decode(snapshot.data);
                        if (json.decode(snapshot.data)['msg'] == 'ping') {
                          print("send pong");

                          bloc.webSocketService
                              .sendPong(state.webSocketChannel!);
                        }
                        var data =
                            RocketChatData.fromJson(json.decode(snapshot.data));
                        if (data.msg == "changed" && data.fields != null) {
                          bloc.addMessage(data.fields!.args![0]);
                        }
                        if (dataJson['msg'] == "result" &&
                            dataJson['result'] != null) {
                          var c = MessageChat.fromJson(dataJson['result']);
                          bloc.addMessage(
                            c,
                          );
                          if (c.msg == "Bắt đầu" &&
                              state.messagesMap['start'] != null) {
                            bloc.addMessage(
                              MessageChat(id: "start", chatMode: 1),
                            );
                          }
                        }

                        if (dataJson?['result']?['newRoom'] == true) {
                          bloc.add(BackChatMessageInit());
                          bloc.closeChatRoom(state.roomId);
                          // bloc.setRoomId(dataJson['result']['rid']);
                          // bloc.setvisitorToken(dataJson['result']['rid']);
                        }
                        if (dataJson['msg'] == "changed" &&
                            dataJson["fields"] != null &&
                            dataJson['fields']?['args']?[0]['msg'] ==
                                "Bắt đầu") {
                          bloc.addMessage(
                            MessageChat(id: uuid.v4(), chatMode: 1),
                          );
                        }

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
                                        ),
                                      );
                                      // bloc.sendStartMessage(token, "Bắt đầu");

                                      // bloc.addMessage(MessageChat(chatMode: 1));
                                      bloc.toogleGreeting();
                                      bloc.scroll();
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
                            // if (state.showGreeting)
                            //   ListMessageSubject(
                            //     bloc: bloc,
                            //     toogleGreeting: () {
                            //       bloc.toogleGreeting();
                            //     },
                            //   ),
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

                                          bloc.closeChatRoom(rid!).then((v) {
                                            bloc.add(BackChatMessageInit());
                                          });
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
                            if (!state.quit &&
                                state.stateChat == StateChatEnum.START)
                              InputChat(messageState: state, messageBloc: bloc),
                            vpad(10)
                          ],
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        bloc.add(BackChatMessageInit());

                        return const Center(child: Text('done'));
                      } else if (snapshot.connectionState ==
                          ConnectionState.none) {
                        return const Center(child: Text('none'));
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: PrimaryLoading());
                      }

                      return const Center(child: PrimaryLoading());
                    },
                  ),
                );
              }
            },
          ),
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
    ChatMessageBloc bloc,
  ) {
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
          // if (state.stateChat == StateChatEnum.START)
          //   InputChat(messageState: state, messageBloc: bloc),
          // vpad(10)
        ],
      ),
    );
  }
}
