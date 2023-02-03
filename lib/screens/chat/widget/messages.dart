import 'package:app_cudan/constants/constants.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_feed_reaction/widgets/emoji_reaction.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../constants/api_constant.dart';
import '../../../generated/l10n.dart';
import '../../../utils/utils.dart';
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

            return Padding(
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
                  return Message(
                    isMe: accountId == qs['accountId'],
                    d: d,
                    fullName: fullName ?? "",
                    message: qs['message'],
                    avatar: avatar,
                  );
                  //  Align(
                  //   alignment: accountId == qs['accountId']
                  //       ? Alignment.centerRight
                  //       : Alignment.centerLeft,
                  //   // color: Colors.amber,
                  //   child: Column(
                  //     crossAxisAlignment: accountId == qs['accountId']
                  //         ? CrossAxisAlignment.end
                  //         : CrossAxisAlignment.start,
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 8),
                  //         child: Text(
                  //           accountId == qs['accountId']
                  //               ? fullName ?? ''
                  //               : S.of(context).customer_care,
                  //           style: txtBodySmallBold(color: grayScaleColorBase),
                  //         ),
                  //       ),
                  //       vpad(4),
                  //       Wrap(
                  //         crossAxisAlignment: WrapCrossAlignment.end,
                  //         children: [
                  //           if (accountId != qs['accountId'])
                  //             const Padding(
                  //               padding: EdgeInsets.only(bottom: 4.0),
                  //               child: CircleAvatar(
                  //                   radius: 10,
                  //                   backgroundImage:
                  //                       AssetImage(AppImage.receiption)),
                  //             ),
                  //           if (accountId != qs['accountId']) hpad(2),
                  //           PrimaryCard(
                  //             borderRadius: BorderRadius.circular(24),
                  //             background: accountId == qs['accountId']
                  //                 ? primaryColor4
                  //                 : grayScaleColor4,
                  //             width: dvWidth(context) * 0.7,
                  //             margin: const EdgeInsets.only(top: 4, bottom: 4),
                  //             padding: const EdgeInsets.symmetric(
                  //                 horizontal: 12, vertical: 12),
                  //             child: Text(
                  //               qs['message'],
                  //               textAlign: accountId == qs['accountId']
                  //                   ? TextAlign.end
                  //                   : TextAlign.start,
                  //               style: txtRegular(14, grayScaleColorBase),
                  //             ),
                  //           ),
                  //           if (accountId == qs['accountId']) hpad(2),
                  //           if (accountId == qs['accountId'])
                  //             Padding(
                  //               padding: const EdgeInsets.only(bottom: 4.0),
                  //               child: CircleAvatar(
                  //                 radius: 10,
                  //                 backgroundImage: avatar != null
                  //                     ? CachedNetworkImageProvider(
                  //                         "${ApiConstants.uploadURL}?load=$avatar")
                  //                     : const AssetImage(
                  //                         AppImage.defaultAvatar,
                  //                       ) as ImageProvider,
                  //               ),
                  //             ),
                  //         ],
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 8),
                  //         child: Text(
                  //           Utils.dateTimeFormat(d.toIso8601String(), 0),
                  //           style:
                  //               txtBodySmallRegular(color: grayScaleColorBase),
                  //         ),
                  //       ),
                  //       vpad(4)
                  //     ],
                  //   ),
                  // );

                  // PrimaryCard(
                  //   width: dvWidth(context) * 0.5,
                  //   margin: const EdgeInsets.symmetric(vertical: 5),
                  //   padding:
                  //       const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  //   child: Text(qs['message']),
                  // );
                },
                itemScrollController: widget.messageBloc.itemScrollController,
                itemPositionsListener: widget.messageBloc.itemPositionsListener,
              ),
            );
          }),
    );
  }
}
