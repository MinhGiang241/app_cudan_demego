import 'dart:io';

import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:emoji_dialog_picker/emoji_dialog_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:provider/provider.dart';
import '../../../constants/constants.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_card.dart';
import '../../../widgets/primary_icon.dart';
import '../../../widgets/primary_image_netword.dart';

class InputChat extends StatefulWidget {
  const InputChat({super.key, required this.messageBloc});
  final dynamic messageBloc;

  @override
  State<InputChat> createState() => _InputChatState();
}

var listImageExt = ['png', 'jpg', 'jpeg'];

class _InputChatState extends State<InputChat> {
  final List<File> pickedImages = [];
  final List<File> pickedFile = [];

  @override
  Widget build(BuildContext context) {
    var user = context.read<ResidentInfoPrv>().userInfo;
    var accountId = user!.account!.id;
    var accountName = user.account!.fullName;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Column(
        children: [
          if (pickedFile.isNotEmpty)
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      await OpenFile.open(pickedFile[0].path);
                    },
                    child: Text(
                      pickedFile[0].path.split('/').last,
                      overflow: TextOverflow.ellipsis,
                      style: txtSemiBold(14, primaryColorBase),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        pickedFile.clear();
                      });
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: redColor,
                    ))
              ],
            ),
          if (pickedImages.isNotEmpty)
            Container(
                height: 100,
                padding: const EdgeInsets.only(right: 14.0),
                child: Stack(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: PrimaryImageNetwork(
                          file: pickedImages[0],
                          height: 300,
                        )

                        //  Image.file(e.value),
                        ),
                    Positioned(
                      top: 2,
                      right: 2,
                      child: PrimaryIcon(
                        icons: PrimaryIcons.close,
                        style: PrimaryIconStyle.gradient,
                        gradients: PrimaryIconGradient.red,
                        color: Colors.white,
                        padding: const EdgeInsets.all(4),
                        onTap: () {
                          setState(() {
                            pickedImages.clear();
                          });
                        },
                      ),
                    )
                  ],
                )),
          vpad(10),
          Row(
            children: [
              InkWell(
                  onTap: () async {
                    await Utils.selectFile(context, false).then((value) {
                      setState(() {
                        pickedImages.clear();
                        pickedFile.clear();
                        if (value != null) {
                          for (var i in value) {
                            if (listImageExt
                                .contains(i!.name.split('.').last)) {
                              pickedImages.add(File(i.path));
                            } else {
                              pickedFile.add(File(i.path));
                            }
                          }
                        }
                      });
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.folder_copy_outlined,
                      color: grayScaleColor2,
                    ),
                  )),
              InkWell(
                  onTap: () async {
                    await Utils.selectImage(context, true).then((value) {
                      if (value != null) {
                        final list =
                            value.map<File>((e) => File(e.path)).toList();
                        setState(() {
                          pickedFile.clear();
                          pickedImages.clear();
                          pickedImages.addAll(list);
                        });
                      }
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: grayScaleColor2,
                    ),
                  )),
              Expanded(
                child: PrimaryCard(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: grayScaleColor6),
                  child: TextField(
                    onSubmitted: (value) {
                      // messageBloc.summitedMessage(accountId, accountName);
                      widget.messageBloc.sendMessage();
                    },
                    controller: widget.messageBloc.textEditionController,
                    style: txtBodySmallBold(color: grayScaleColorBase),
                    cursorColor: primaryColor2,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      hintText: "Aa",
                      hintStyle: txtBodySmallBold(color: grayScaleColor3),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide:
                              const BorderSide(color: primaryColor2, width: 2)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                      suffixIcon: SizedBox(
                        width: 20,
                        child: EmojiButton(
                          emojiPickerView: EmojiPickerView(
                              onEmojiSelected: widget.messageBloc.selectEmoji),
                          child: const Icon(Icons.emoji_emotions_outlined),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              hpad(5),
              InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  // messageBloc.summitedMessage(accountId, accountName);
                  if (pickedFile.isEmpty && pickedImages.isEmpty) {
                    widget.messageBloc.sendMessage();
                  } else {
                    var uploads = pickedFile + pickedImages;

                    widget.messageBloc.uploadFileOnRoom(uploads[0]);
                    setState(() {
                      pickedFile.clear();
                      pickedImages.clear();
                    });
                  }
                },
                child: const Icon(
                  Icons.send,
                  color: grayScaleColorBase,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
