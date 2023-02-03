import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../constants/api_constant.dart';
import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_card.dart';

class Message extends StatefulWidget {
  const Message({
    super.key,
    required this.isMe,
    required this.fullName,
    required this.message,
    this.avatar,
    required this.d,
  });
  final bool isMe;
  final String fullName;
  final String message;
  final String? avatar;
  final DateTime d;

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  bool isShow = false;
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
        // color: Colors.amber,
        child: Column(
          crossAxisAlignment:
              widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.end,
              children: [
                if (!widget.isMe)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 12.0),
                    child: CircleAvatar(
                        radius: 10,
                        backgroundImage: AssetImage(AppImage.receiption)),
                  ),
                if (!widget.isMe) hpad(2),
                Stack(
                  children: [
                    PrimaryCard(
                      isShadow: false,
                      onTap: () {
                        setState(() {
                          isShow = !isShow;
                        });
                      },
                      borderRadius: BorderRadius.circular(24),
                      background: widget.isMe ? primaryColor4 : grayScaleColor4,
                      width: dvWidth(context) * 0.7,
                      margin: const EdgeInsets.only(top: 2, bottom: 12),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      child: Text(
                        widget.message,
                        textAlign:
                            widget.isMe ? TextAlign.end : TextAlign.start,
                        style: txtRegular(14, grayScaleColorBase),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 10,
                      child: PrimaryCard(
                        padding: const EdgeInsets.all(2),
                        background: Colors.white,
                        child: Wrap(
                          children: const [
                            Icon(
                              color: redColor1,
                              Icons.face,
                              size: 18,
                            ),
                            Icon(
                              color: redColor1,
                              Icons.handshake,
                              size: 18,
                            ),
                            Icon(
                              color: redColor1,
                              Icons.sailing,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                if (widget.isMe) hpad(2),
                if (widget.isMe)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: CircleAvatar(
                      radius: 10,
                      backgroundImage: widget.avatar != null
                          ? CachedNetworkImageProvider(
                              "${ApiConstants.uploadURL}?load=${widget.avatar}")
                          : const AssetImage(
                              AppImage.defaultAvatar,
                            ) as ImageProvider,
                    ),
                  ),
              ],
            ),
            if (isShow)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  widget.isMe ? widget.fullName : S.of(context).customer_care,
                  style: txtBodyMediumBold(color: grayScaleColorBase),
                ),
              ),
            if (isShow) vpad(2),
            if (isShow)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  Utils.dateTimeFormat(widget.d.toIso8601String(), 0),
                  style: txtBodySmallRegular(color: grayScaleColorBase),
                ),
              ),
            vpad(4)
          ],
        ));
  }
}
