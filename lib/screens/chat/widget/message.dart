// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'package:app_cudan/models/rocket_chat_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:emoji_dialog_picker/emoji_dialog_picker.dart';
import 'package:flutter/material.dart';

import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../constants/api_constant.dart';
import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_card.dart';
import '../../../widgets/primary_image_netword.dart';
import '../bloc/websocket_connect.dart';

var dio = Dio();

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
  dynamic chatbloc;

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

  downloadFile(String url, Map<String, String> headers) async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      final baseStorage = await getExternalStorageDirectory();

      var taskId = await FlutterDownloader.enqueue(
        url: url,
        headers: headers, // optional: header send with url (auth token etc)
        savedDir: baseStorage!.path,
        showNotification:
            true, // show download progress in status bar (for Android)
        saveInPublicStorage: true,
        openFileFromNotification:
            true, // click on notification to open downloaded file (for Android)
      );
      await FlutterDownloader.open(taskId: taskId!);
    }
  }

  final ReceivePort _port = ReceivePort();

  @override
  initState() {
    super.initState();
    streamSubscription = widget.shouldTriggerChange.listen((_) {
      setState(() {
        showVisible = false;
      });
    });
    IsolateNameServer.registerPortWithName(
      _port.sendPort,
      'downloader_send_port',
    );
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];

      if (status == DownloadTaskStatus.complete) {
        print('Download complete');
      }
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    streamSubscription.cancel();
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
    String id,
    DownloadTaskStatus status,
    int progress,
  ) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
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
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
      // color: Colors.amber,
      child: Column(
        crossAxisAlignment:
            widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          // Portal(
          //   child: PortalTarget(
          //     // closeDuration: const Duration(milliseconds: 200),
          //     visible: showVisible,
          //     anchor: const Aligned(
          //       follower: Alignment.center,
          //       target: Alignment.center,
          //     ),
          //     portalFollower: PrimaryCard(
          //       borderRadius: BorderRadius.circular(24),
          //       width: dvWidth(context) * 0.7,
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           hpad(5),
          //           GestureDetector(
          //             onTap: () {
          //               addEmoji("❤️");
          //             },
          //             child: const Text(
          //               "❤️",
          //               style: TextStyle(fontSize: 25),
          //             ),
          //           ),
          //           GestureDetector(
          //             onTap: () {
          //               addEmoji("👍");
          //             },
          //             child: const Text(
          //               "👍",
          //               style: TextStyle(fontSize: 25),
          //             ),
          //           ),
          //           GestureDetector(
          //             onTap: () {
          //               addEmoji("👎");
          //             },
          //             child: const Text(
          //               "👎",
          //               style: TextStyle(fontSize: 25),
          //             ),
          //           ),
          //           GestureDetector(
          //             onTap: () {
          //               addEmoji("😆");
          //             },
          //             child: const Text(
          //               "😆",
          //               style: TextStyle(fontSize: 25),
          //             ),
          //           ),
          //           EmojiButton(
          //             emojiPickerView: EmojiPickerView(
          //               onEmojiSelected: (v) {
          //                 addEmoji(v);
          //               },
          //             ),
          //             child: const Text(
          //               "➕",
          //               style: TextStyle(fontSize: 25),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          // child:
          SizedBox(
            width: dvWidth(context),
            child: Align(
              alignment:
                  widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.end,
                children: [
                  if (!widget.isMe)
                    const Padding(
                      padding: EdgeInsets.only(bottom: 12.0),
                      child: CircleAvatar(
                        radius: 10,
                        backgroundImage: AssetImage(AppImage.receiption),
                      ),
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
                        background:
                            widget.isMe ? primaryColor4 : grayScaleColor4,
                        // width: dvWidth(context) * 0.7,
                        constraints: BoxConstraints(
                          minWidth: 40,
                          maxWidth: dvWidth(context) * 0.7,
                        ),
                        margin: const EdgeInsets.only(top: 2, bottom: 12),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        child: Column(
                          children: [
                            if (widget.messageChat.attachments!.isNotEmpty)
                              Wrap(
                                children: [
                                  ...widget.messageChat.attachments!.map(
                                    (c) => Column(
                                      mainAxisAlignment: widget.isMe
                                          ? MainAxisAlignment.end
                                          : MainAxisAlignment.start,
                                      children: [
                                        if (c.image_type == null)
                                          InkWell(
                                            onTap: () async {
                                              await Utils.downloadFile(
                                                context: context,
                                                url:
                                                    "${WebsocketConnect.serverUrl}${c.title_link}?download",
                                                headers: {
                                                  // "Accept-Encoding":
                                                  //     "gzip, deflate, br",

                                                  'Accept':
                                                      'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,file/pdf,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9',
                                                  'Host': 'chat.demego.vn',
                                                  // 'Cookie':
                                                  //     "rc_token=${widget.chatbloc.authToken ?? ""}; rc_uid=${widget.chatbloc.user!.id ?? ""};SL_G_WPT_TO=en; SL_GWPT_Show_Hide_tmp=1; SL_wptGlobTipTmp=1; __zi=3000.SSZzejyD5TyuZFocr4KFr6AEgBYQInUNFfoYfuW91O4atFtXWWj0nI3U_Ek5HKZ199RqxuT3GSGuCJK.1",
                                                  // "sec-ch-ua":
                                                  //     '"Not_A Brand";v="99", "Google Chrome";v="109", "Chromium";v="109"',
                                                  // "sec-ch-ua-mobile":
                                                  //     "?0",
                                                  // "sec-ch-ua-platform":
                                                  //     '"Windows"',
                                                  // "Sec-Fetch-Dest":
                                                  //     "document",
                                                  // "Sec-Fetch-Mode":
                                                  //     "navigate",
                                                  // "Sec-Fetch-Site":
                                                  //     "none",
                                                  // "Sec-Fetch-User":
                                                  //     "?1",
                                                  // "Upgrade-Insecure-Requests":
                                                  //     "1",
                                                  // "User-Agent":
                                                  //     "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36"
                                                },
                                              );

                                              // await launchUrl(
                                              //   Uri.parse(
                                              //       "${WebsocketConnect.serverUrl}${c.title_link}?download"),
                                              //   mode: LaunchMode
                                              //       .platformDefault,
                                              //   webViewConfiguration:
                                              //       WebViewConfiguration(
                                              //     headers: {
                                              //       "Connection":
                                              //           "keep-alive",
                                              //       "Accept-Encoding":
                                              //           "gzip, deflate, br",
                                              //       'Accept':
                                              //           'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9',
                                              //       'Host':
                                              //           'chat.masflex.vn',
                                              //       'Cookie':
                                              //           "rc_token=${widget.chatbloc.token ?? ""}; rc_uid=${widget.chatbloc.user!.id ?? ""}"
                                              //     },
                                              //   ),
                                              // );
                                            },
                                            child: Text(
                                              c.title!,
                                              textAlign: widget.isMe
                                                  ? TextAlign.end
                                                  : TextAlign.start,
                                              style: txtRegular(
                                                14,
                                                primaryColorBase,
                                              ),
                                            ),
                                          ),
                                        if (c.image_type != null &&
                                            c.image_type!.contains("image"))
                                          InkWell(
                                            onTap: () async {
                                              Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  pageBuilder: (
                                                    context,
                                                    animation,
                                                    secondaryAnimation,
                                                  ) =>
                                                      PhotoViewer(
                                                    link:
                                                        "${WebsocketConnect.serverUrl}${c.image_url}",
                                                    listLink: [
                                                      "${WebsocketConnect.serverUrl}${c.image_url}"
                                                    ],
                                                    initIndex: 0,
                                                    heroTag: "tag",
                                                  ),
                                                  transitionsBuilder: (
                                                    context,
                                                    animation,
                                                    secondaryAnimation,
                                                    child,
                                                  ) {
                                                    return FadeTransition(
                                                      opacity: animation,
                                                      child: child,
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  "${WebsocketConnect.serverUrl}${c.image_url}",
                                              placeholder: (
                                                context,
                                                url,
                                              ) =>
                                                  const CircularProgressIndicator(),
                                              errorWidget: (
                                                context,
                                                url,
                                                error,
                                              ) =>
                                                  const Icon(
                                                Icons.error,
                                              ),
                                              httpHeaders: {
                                                "Authorization":
                                                    "Bearer ${widget.chatbloc.authToken}",
                                                "X-User-Id":
                                                    widget.chatbloc.user!.id ??
                                                        "",
                                                "X-Auth-Token":
                                                    widget.chatbloc.authToken ??
                                                        ""
                                              },
                                            ),
                                          ),
                                        if (c.description != null &&
                                            c.description!.isNotEmpty)
                                          Text(
                                            c.description!,
                                            textAlign: widget.isMe
                                                ? TextAlign.end
                                                : TextAlign.start,
                                            style: txtRegular(
                                              14,
                                              grayScaleColorBase,
                                            ),
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
                                style: txtRegular(14, grayScaleColorBase),
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
                                  width: 0.5,
                                ),
                                padding: const EdgeInsets.all(2),
                                background: Colors.white,
                                child: Row(
                                  children: [
                                    Text(
                                      emojiParser.get(e.key).code,
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    if (e.value['usernames'].length > 1)
                                      Text(
                                        e.value["usernames"].length.toString(),
                                        style: txtBold(
                                          10,
                                          grayScaleColorBase,
                                        ),
                                      ),
                                  ],
                                ),
                              );
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
                                "${ApiConstants.uploadURL}?load=${widget.avatar}",
                              )
                            : const AssetImage(
                                AppImage.defaultAvatar,
                              ) as ImageProvider,
                      ),
                    ),
                ],
              ),
            ),
          ),
          //   ),
          // ),
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
