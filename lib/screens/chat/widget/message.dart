// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';

import 'package:app_cudan/models/rocket_chat_data.dart';
import 'package:badges/badges.dart' as B;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:emoji_dialog_picker/emoji_dialog_picker.dart';
import 'package:flutter/material.dart';

import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';

import '../../../constants/api_constant.dart';
import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_card.dart';
import '../../../widgets/primary_image_netword.dart';
import '../bloc/chat_bloc.dart';
import '../bloc/websocket_connect.dart';

class Message extends StatefulWidget {
  Message({
    super.key,
    required this.isMe,
    required this.fullName,
    required this.message,
    this.avatar,
    required this.d,
    required this.shouldTriggerChange,
    required this.emojies,
    required this.chatbloc,
    required this.messageChat,
  });
  final bool isMe;

  final String fullName;
  final String message;
  final MessageChat messageChat;
  final String? avatar;
  final DateTime d;
  final Stream<dynamic> shouldTriggerChange;
  Map<String, dynamic> emojies;
  ChatBloc chatbloc;

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  var emojiParser = EmojiParser();
  late Stream shouldTriggerChange;
  bool isShow = false;
  bool showVisible = false;
  late Offset _tapPosition;
  late StreamSubscription streamSubscription;
  @override
  initState() {
    super.initState();
    streamSubscription = widget.shouldTriggerChange.listen((_) {
      setState(() {
        showVisible = false;
      });
    });
  }

  @override
  didUpdateWidget(Message old) {
    super.didUpdateWidget(old);
    // in case the stream instance changed, subscribe to the new one
    if (widget.shouldTriggerChange != old.shouldTriggerChange) {
      streamSubscription.cancel();
      streamSubscription = widget.shouldTriggerChange.listen((_) {
        setState(() {
          showVisible = false;
        });
      });
    }
  }

  addEmoji(String emoji) {
    setState(() {
      showVisible = !showVisible;
    });
    widget.chatbloc
        .setReaction(emojiParser.getEmoji(emoji).full, widget.messageChat.id!);
  }

  removeEmoji(String emoji) {}

  @override
  dispose() {
    super.dispose();
    streamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
      // color: Colors.amber,
      child: Column(
        crossAxisAlignment:
            widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Portal(
              child: PortalTarget(
                  // closeDuration: const Duration(milliseconds: 200),
                  visible: showVisible,
                  anchor: const Aligned(
                    follower: Alignment.center,
                    target: Alignment.center,
                  ),
                  portalFollower: PrimaryCard(
                    borderRadius: BorderRadius.circular(24),
                    width: dvWidth(context) * 0.7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        hpad(5),
                        GestureDetector(
                            onTap: () {
                              addEmoji("❤️");
                            },
                            child: const Text(
                              "❤️",
                              style: TextStyle(fontSize: 25),
                            )
                            // Image.asset('assets/emojies/sad.png',
                            //     width: 35),
                            ),
                        GestureDetector(
                            onTap: () {
                              addEmoji("👍");
                            },
                            child: const Text(
                              "👍",
                              style: TextStyle(fontSize: 25),
                            )
                            // Image.asset('assets/emojies/heart.png',
                            //     width: 35),
                            ),
                        GestureDetector(
                            onTap: () {
                              addEmoji("👎");
                            },
                            child: const Text(
                              "👎",
                              style: TextStyle(fontSize: 25),
                            )
                            // Image.asset('assets/emojies/care.png',
                            //     width: 35),
                            ),
                        GestureDetector(
                            onTap: () {
                              addEmoji("😆");
                            },
                            child: const Text(
                              "😆",
                              style: TextStyle(fontSize: 25),
                            )
                            // Image.asset('assets/emojies/lol.png',
                            //     width: 35),
                            ),
                        EmojiButton(
                          emojiPickerView:
                              EmojiPickerView(onEmojiSelected: (v) {
                            addEmoji(v);
                          }),
                          child: const Text(
                            "➕",
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                      ],
                    ),
                  ),
                  child: SizedBox(
                    width: dvWidth(context),
                    child: Align(
                      alignment: widget.isMe
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.end,
                        children: [
                          // if (widget.isMe && widget.message.length < 14)
                          //   hpad(120),
                          if (!widget.isMe)
                            const Padding(
                              padding: EdgeInsets.only(bottom: 12.0),
                              child: CircleAvatar(
                                  radius: 10,
                                  backgroundImage:
                                      AssetImage(AppImage.receiption)),
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
                                onTapDown: (TapDownDetails details) {
                                  _tapPosition = details.globalPosition;
                                },
                                onLongPress: () async {
                                  setState(() {
                                    showVisible = !showVisible;
                                  });
                                },
                                borderRadius: BorderRadius.circular(24),
                                background: widget.isMe
                                    ? primaryColor4
                                    : grayScaleColor4,
                                // width: dvWidth(context) * 0.7,
                                constraints: BoxConstraints(
                                    minWidth: 40,
                                    maxWidth: dvWidth(context) * 0.7),
                                margin:
                                    const EdgeInsets.only(top: 2, bottom: 12),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
                                child: Column(
                                  children: [
                                    if (widget
                                        .messageChat.attachments!.isNotEmpty)
                                      Wrap(
                                        children: [
                                          ...widget.messageChat.attachments!
                                              .map(
                                            (c) => Column(
                                              mainAxisAlignment: widget.isMe
                                                  ? MainAxisAlignment.end
                                                  : MainAxisAlignment.start,
                                              children: [
                                                if (c.image_type == null)
                                                  InkWell(
                                                    onTap: () async {
                                                      final cookieManager =
                                                          WebviewCookieManager();
                                                      Map<String, String>
                                                          hCookies = {
                                                        "rc_token": widget
                                                                .chatbloc
                                                                .token ??
                                                            "",
                                                        "rc_uid": widget
                                                                .chatbloc
                                                                .user!
                                                                .id ??
                                                            ""
                                                      };
                                                      String cookies = '';
                                                      int index = 0;
                                                      final gotCookies =
                                                          await cookieManager
                                                              .getCookies(
                                                                  "https://youtube.com/");
                                                      for (var item
                                                          in gotCookies) {
                                                        hCookies[
                                                                'Set-Cookie[$index]'] =
                                                            item.toString();
                                                        index++;

                                                        print(item);
                                                      }

                                                      await launchUrl(
                                                          Uri.parse(
                                                              "${WebsocketConnect.serverUrl}${c.title_link}?download"),
                                                          webViewConfiguration:
                                                              WebViewConfiguration(
                                                                  headers: {
                                                                "Cookie":
                                                                    "SL_G_WPT_TO=en; rc_uid=8s8DNw6Mufd3ozMaB; rc_token=0GE1c8NOZdbHhOw1u2CdZ0nw-_SAowF-FsIogdmsGlr; SL_GWPT_Show_Hide_tmp=1; SL_wptGlobTipTmp=1"
                                                              }));
                                                    },
                                                    child: Text(
                                                      c.title!,
                                                      textAlign: widget.isMe
                                                          ? TextAlign.end
                                                          : TextAlign.start,
                                                      style: txtRegular(
                                                          14, primaryColorBase),
                                                    ),
                                                  ),
                                                if (c.image_type != null &&
                                                    c.image_type!
                                                        .contains("image"))
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          PageRouteBuilder(
                                                            pageBuilder: (context,
                                                                    animation,
                                                                    secondaryAnimation) =>
                                                                PhotoViewer(
                                                                    link:
                                                                        "${WebsocketConnect.serverUrl}${c.image_url}",
                                                                    listLink: [
                                                                      "${WebsocketConnect.serverUrl}${c.image_url}"
                                                                    ],
                                                                    initIndex:
                                                                        0,
                                                                    heroTag:
                                                                        "tag"),
                                                            transitionsBuilder:
                                                                (context,
                                                                    animation,
                                                                    secondaryAnimation,
                                                                    child) {
                                                              return FadeTransition(
                                                                opacity:
                                                                    animation,
                                                                child: child,
                                                              );
                                                            },
                                                          ));
                                                    },
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          "${WebsocketConnect.serverUrl}${c.image_url}",
                                                      placeholder: (context,
                                                              url) =>
                                                          const CircularProgressIndicator(),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Icon(
                                                              Icons.error),
                                                      httpHeaders: {
                                                        "Authorization":
                                                            "Bearer ${widget.chatbloc.token}",
                                                        "X-User-Id": widget
                                                                .chatbloc
                                                                .user!
                                                                .id ??
                                                            "",
                                                        "X-Auth-Token": widget
                                                                .chatbloc
                                                                .token ??
                                                            ""
                                                      },
                                                    ),
                                                  ),
                                                if (c.description != null)
                                                  Text(
                                                    c.description!,
                                                    textAlign: widget.isMe
                                                        ? TextAlign.end
                                                        : TextAlign.start,
                                                    style: txtRegular(
                                                        14, grayScaleColorBase),
                                                  )
                                              ],
                                            ),

                                            // InkWell(
                                            //   onTap: () {},
                                            //   child: Image.memory(
                                            //     base64Decode(
                                            //         c.image_preview ?? ""),
                                            //     width: dvWidth(context) * 0.4,
                                            //     fit: BoxFit.contain,
                                            //   ),
                                            // ),
                                          )
                                        ],
                                      ),
                                    if (widget.message.isNotEmpty)
                                      Text(
                                        widget.message,
                                        textAlign: widget.isMe
                                            ? TextAlign.end
                                            : TextAlign.start,
                                        style:
                                            txtRegular(14, grayScaleColorBase),
                                      ),
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: widget.isMe ? null : 0,
                                left: !widget.isMe ? null : 0,
                                child: Wrap(
                                  children: [
                                    ...widget.emojies.entries.map((e) {
                                      print(e.value['usernames'].length);
                                      return PrimaryCard(
                                          border: Border.all(
                                              color: grayScaleColor4,
                                              width: 0.5),
                                          padding: const EdgeInsets.all(2),
                                          background: Colors.white,
                                          child: Row(
                                            children: [
                                              Text(
                                                emojiParser.get(e.key).code,
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                              if (e.value['usernames'].length >
                                                  1)
                                                Text(
                                                    e.value["usernames"].length
                                                        .toString(),
                                                    style: txtBold(10,
                                                        grayScaleColorBase)),
                                            ],
                                          ));
                                    })
                                  ],
                                ),
                              )
                            ],
                          ),
                          // if (!widget.isMe && widget.message.length < 14)
                          //   hpad(120),
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
                    ),
                  ))),
          if (isShow)
            Row(
              mainAxisAlignment:
                  widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                Text(
                  widget.isMe ? widget.fullName : S.of(context).customer_care,
                  style: txtBodyMediumBold(color: grayScaleColorBase),
                  overflow: TextOverflow.ellipsis,
                ),
                if (widget.fullName.isNotEmpty)
                  Text(
                    " - ",
                    style: txtBodyMediumBold(color: grayScaleColorBase),
                  ),
                Text(
                  Utils.dateTimeFormat(widget.d.toIso8601String(), 0),
                  style: txtBodySmallRegular(color: grayScaleColorBase),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          vpad(4)
        ],
      ),
    );
  }
}
