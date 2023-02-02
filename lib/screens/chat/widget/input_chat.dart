import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_dialog_picker/emoji_dialog_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../widgets/primary_card.dart';
import '../bloc/chat_bloc.dart';

class InputChat extends StatelessWidget {
  const InputChat({super.key, required this.fs, required this.messageBloc});
  final FirebaseFirestore fs;
  final ChatBloc messageBloc;

  @override
  Widget build(BuildContext context) {
    var user = context.read<ResidentInfoPrv>().userInfo;
    var accountId = user!.account!.id;
    var accountName = user.account!.fullName;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        children: [
          InkWell(
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(
                  Icons.folder_copy_outlined,
                  color: grayScaleColor2,
                ),
              )),
          InkWell(
              onTap: () {},
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
                  color: grayScaleColor4),
              child: TextField(
                onSubmitted: (value) {
                  messageBloc.summitedMessage(value, accountId, accountName);
                },
                controller: messageBloc.textEditionController,
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
                          onEmojiSelected: messageBloc.selectEmoji),
                      child: const Icon(Icons.emoji_emotions_outlined),
                    ),
                  ),

                  //  InkWell(
                  //   onTap: () {},
                  //   child: const Icon(Icons.emoji_emotions_outlined),
                  // ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
