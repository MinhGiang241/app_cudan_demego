import 'dart:async';

import 'package:app_cudan/constants/constants.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../constants/api_constant.dart';
import '../../../generated/l10n.dart';
import '../../../models/feed_reaction_model.dart';
import '../../../models/rocket_chat_data.dart';
import '../../../utils/utils.dart';
import '../../../widgets/emoji_reaction.dart';
import '../../../widgets/primary_card.dart';
import '../../../widgets/primary_loading.dart';
import '../../../widgets/primary_screen.dart';
import '../bloc/chat_bloc.dart';
import 'message.dart';

class Measages extends StatefulWidget {
  Measages({super.key, required this.messageBloc, required this.messages});
  final ChatBloc messageBloc;
  final List<MessageChat> messages;
  @override
  State<Measages> createState() => _MeasagesState();
}

class _MeasagesState extends State<Measages> {
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
        },
        child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ListView(
              controller: widget.messageBloc.scrollController,
              children: [
                ...widget.messages.map(
                  (e) => Message(
                    shouldTriggerChange: changeNotifier.stream,
                    isMe: widget.messageBloc.user!.id == e.u!.id,
                    d: DateTime.now(),
                    fullName: fullName ?? "",
                    message: e.msg ?? "",
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
