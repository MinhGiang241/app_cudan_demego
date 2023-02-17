import 'dart:async';

import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../models/rocket_chat_data.dart';
import '../bloc/chat_bloc.dart';
import '../bloc/chat_message_bloc.dart';
import 'message.dart';

class Messages extends StatefulWidget {
  Messages({
    super.key,
    required this.messageBloc,
    required this.messageMap,
  });
  final dynamic messageBloc;
  final Map<String, MessageChat> messageMap;
  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  final changeNotifier = StreamController.broadcast();
  @override
  void dispose() {
    changeNotifier.close();
    super.dispose();
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => widget.messageBloc.scroll());
  }

  @override
  Widget build(BuildContext context) {
    var user = context.read<ResidentInfoPrv>().userInfo;
    var accountId = user!.account!.id;
    var avatar = user.account!.avatar;
    var fullName = user.account!.fullName;
    WidgetsBinding.instance
        .addPostFrameCallback((_) => widget.messageBloc.scroll());
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          changeNotifier.sink.add(false);
          FocusScope.of(context).unfocus();
        },
        child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ListView(
              controller: widget.messageBloc.scrollController,
              children: [
                ...widget.messageMap.keys.map(
                  (e) => Message(
                    messageChat: widget.messageMap[e]!,
                    chatbloc: widget.messageBloc,
                    emojies: widget.messageMap[e]!.reactions ?? {},
                    shouldTriggerChange: changeNotifier.stream,
                    isMe: widget.messageBloc.user!.id ==
                        widget.messageMap[e]!.u!.id,
                    d: DateTime.now(),
                    fullName: fullName ?? "",
                    message: widget.messageMap[e]!.msg ?? "",
                    avatar: avatar,
                  ),
                )
              ],
            )

            // ScrollablePositionedList.builder(
            //   initialScrollIndex:
            //       widget.messages.isNotEmpty ? widget.messages.length - 1 : 0,
            //   shrinkWrap: true,
            //   itemCount: widget.messages.length,
            //   itemBuilder: (context, index) {
            //     widget.messageBloc.setMessageCount(widget.messages.length);
            //     if (index != -1) {
            //       return Message(
            //         shouldTriggerChange: changeNotifier.stream,
            //         isMe: widget.messageBloc.user!.id ==
            //             widget.messages[index].u!.id,
            //         d: DateTime.now(),
            //         fullName: fullName ?? "",
            //         message: widget.messages[index].msg ?? "",
            //         avatar: avatar,
            //       );
            //     } else {
            //       return vpad(0);
            //     }
            //   },
            //   itemScrollController: widget.messageBloc.itemScrollController,
            //   itemPositionsListener: widget.messageBloc.itemPositionsListener,
            // ),
            ),
      ),
    );
  }
}
