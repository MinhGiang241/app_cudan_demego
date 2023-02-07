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
import '../../../utils/utils.dart';
import '../../../widgets/emoji_reaction.dart';
import '../../../widgets/primary_card.dart';
import '../../../widgets/primary_loading.dart';
import '../../../widgets/primary_screen.dart';
import '../bloc/chat_bloc.dart';
import 'message.dart';

class Measages extends StatefulWidget {
  const Measages({super.key, required this.messageBloc});
  final ChatBloc messageBloc;
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

  @override
  Widget build(BuildContext context) {
    var user = context.read<ResidentInfoPrv>().userInfo;
    var accountId = user!.account!.id;
    var avatar = user.account!.avatar;
    var fullName = user.account!.fullName;
    return SafeArea(
      child: StreamBuilder(
          stream: widget.messageBloc.messageStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text(S.of(context).error);
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: PrimaryLoading(),
              );
            }
            if (snapshot.hasData && !widget.messageBloc.init) {
              if (snapshot.data!.docs.isNotEmpty) {
                widget.messageBloc.scroll(snapshot.data!.docs.length - 1);
              }
            }

            return GestureDetector(
              onTap: () {
                changeNotifier.sink.add(false);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ScrollablePositionedList.builder(
                  initialScrollIndex: snapshot.data!.docs.isNotEmpty
                      ? snapshot.data!.docs.length - 1
                      : 0,
                  // shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    // widget.messageBloc.scroll(snapshot.data!.docs.length - 1);
                    QueryDocumentSnapshot qs =
                        snapshot.data!.docs[index < 0 ? 0 : index];
                    Timestamp t = qs['time'];
                    DateTime d = t.toDate();

                    widget.messageBloc
                        .setMessageCount(snapshot.data!.docs.length);
                    return

                        // IntrinsicHeight(
                        //   child: Portal(
                        //     child: PortalTarget(
                        //       visible: true,
                        //       anchor: Aligned(
                        //         follower: Alignment.center,
                        //         target: Alignment.center,
                        //       ),
                        //       portalFollower: Padding(
                        //         padding: EdgeInsets.only(bottom: 12),
                        //         child: Container(
                        //           child: Stack(
                        //             alignment: Alignment.bottomCenter,
                        //             children: <Widget>[
                        //               // Box
                        //               // if (widget.reactions.isNotEmpty) _backgroudBoxBuilder(),
                        //               // emojies
                        //               PrimaryCard(
                        //                 width: 250,
                        //                 child: Row(children: [
                        //                   Row(
                        //                     children: [
                        //                       Image.asset('assets/emojies/heart.png',
                        //                           width: 60),
                        //                       Image.asset('assets/emojies/care.png',
                        //                           width: 60),
                        //                       Image.asset('assets/emojies/lol.png',
                        //                           width: 60),
                        //                       Image.asset('assets/emojies/sad.png',
                        //                           width: 60),
                        //                     ],
                        //                   ),
                        //                 ]),
                        //               )
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //       child:

                        // ),
                        // ),
                        // );

                        Message(
                      shouldTriggerChange: changeNotifier.stream,
                      isMe: accountId == qs['accountId'],
                      d: d,
                      fullName: fullName ?? "",
                      message: qs['message'],
                      avatar: avatar,
                    );
                  },
                  itemScrollController: widget.messageBloc.itemScrollController,
                  itemPositionsListener:
                      widget.messageBloc.itemPositionsListener,
                ),
              ),
            );
          }),
    );
  }
}
