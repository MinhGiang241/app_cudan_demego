import 'dart:math';

import 'package:app_cudan/models/reflection.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_text_field.dart';
import 'package:app_cudan/widgets/select_media_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/api_constant.dart';
import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_image_netword.dart';
import '../../../widgets/primary_screen.dart';

class ReflectionProcessedDetails extends StatefulWidget {
  const ReflectionProcessedDetails({super.key});
  static const routeName = '/reflection/procceed';

  @override
  State<ReflectionProcessedDetails> createState() =>
      _ReflectionProcessedDetailsState();
}

class _ReflectionProcessedDetailsState extends State<ReflectionProcessedDetails>
    with TickerProviderStateMixin {
  late AnimationController animationInfoController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 300));
  late AnimationController animationResultController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 300));
  late Animation<double> rotateInfoAnimation;
  late Animation<double> rotateResultAnimation;
  @override
  void initState() {
    super.initState();
    rotateInfoAnimation =
        Tween<double>(begin: 0, end: pi).animate(animationInfoController);
    rotateResultAnimation =
        Tween<double>(begin: 0, end: pi).animate(animationResultController);
  }

  @override
  void dispose() {
    animationInfoController.dispose();
    animationResultController.dispose();
    super.dispose();
  }

  bool isShowInfo = false;
  bool isShowResult = false;

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Reflection;

    Animation<double> animationInfoDrop = CurvedAnimation(
      parent: animationInfoController,
      curve: Curves.easeInOut,
    );
    Animation<double> animationResultDrop = CurvedAnimation(
      parent: animationResultController,
      curve: Curves.easeInOut,
    );
    return PrimaryScreen(
      appBar: PrimaryAppbar(
        title: S.of(context).reflection_details,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: SingleChildScrollView(
            child: Column(
              children: [
                vpad(20),
                InkWell(
                  onTap: () {
                    if (isShowInfo) {
                      isShowInfo = false;
                      animationInfoController.reverse();
                    } else {
                      isShowInfo = true;
                      animationInfoController.forward();
                    }
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.layers_outlined),
                      hpad(20),
                      Text(S.of(context).general_info,
                          style: txtBoldUnderline(14)),
                      hpad(30),
                      SizedBox(
                        height: 15.0,
                        width: 15.0,
                        child: AnimatedBuilder(
                          animation: animationInfoController,
                          builder: (context, child) => Transform.rotate(
                            origin: const Offset(4, 4),
                            angle: rotateInfoAnimation.value,
                            child: child,
                          ),
                          child: const Icon(Icons.keyboard_arrow_down_rounded),
                        ),
                      ),
                    ],
                  ),
                ),
                SizeTransition(
                  sizeFactor: animationInfoDrop,
                  child: SingleChildScrollView(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      vpad(12),
                      PrimaryTextField(
                        label: S.of(context).letter_num,
                        initialValue: arg.code,
                        enable: false,
                      ),
                      vpad(12),
                      PrimaryTextField(
                        label: S.of(context).date_send,
                        initialValue: Utils.dateFormat(arg.date ?? "", 1),
                        enable: false,
                      ),
                      vpad(12),
                      PrimaryTextField(
                        label: S.of(context).reflection_type,
                        initialValue: arg.ticket_type == "COMPLAIN"
                            ? S.of(context).complain
                            : S.of(context).feedback,
                        enable: false,
                      ),
                      vpad(12),
                      PrimaryTextField(
                        label: S.of(context).reflection_reason,
                        initialValue: arg.opinionContribute?.content,
                        enable: false,
                      ),
                      vpad(12),
                      PrimaryTextField(
                        maxLines: 3,
                        label: S.of(context).note,
                        initialValue: arg.opinionContribute?.description,
                        enable: false,
                      ),
                      vpad(12),
                      PrimaryTextField(
                        label: S.of(context).zone_type,
                        initialValue: arg.code,
                        enable: false,
                      ),
                      vpad(12),
                      PrimaryTextField(
                        label: S.of(context).zone,
                        initialValue: arg.code,
                        enable: false,
                      ),
                      vpad(12),
                      if (arg.files!.isNotEmpty)
                        Text(
                          S.of(context).photos,
                          style: txtBodySmallRegular(color: grayScaleColorBase),
                        ),
                      if (arg.files!.isNotEmpty) vpad(12),
                      if (arg.files!.isNotEmpty)
                        SizedBox(
                          height: 116,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...arg.files!.map((e) => Padding(
                                      padding: const EdgeInsets.only(right: 14),
                                      child: PrimaryImageNetwork(
                                        path:
                                            "${ApiConstants.uploadURL}?load=${e.id ?? ""}",
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        )
                    ],
                  )),
                ),
                vpad(12),
                InkWell(
                  onTap: () {
                    if (isShowResult) {
                      isShowResult = false;
                      animationResultController.reverse();
                    } else {
                      isShowResult = true;
                      animationResultController.forward();
                    }
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.layers_outlined),
                      hpad(20),
                      Text(S.of(context).processing_result,
                          style: txtBoldUnderline(14)),
                      hpad(30),
                      SizedBox(
                        height: 15.0,
                        width: 15.0,
                        child: AnimatedBuilder(
                          animation: animationResultController,
                          builder: (context, child) => Transform.rotate(
                            origin: const Offset(4, 4),
                            angle: rotateResultAnimation.value,
                            child: child,
                          ),
                          child: const Icon(Icons.keyboard_arrow_down_rounded),
                        ),
                      ),
                    ],
                  ),
                ),
                vpad(12),
                SizeTransition(
                  sizeFactor: animationResultDrop,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        PrimaryTextField(
                          maxLines: 3,
                          label: S.of(context).processing_content,
                          initialValue: arg.process_content ?? "",
                          enable: false,
                        ),
                        vpad(12),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            S.of(context).attachment_file,
                            textAlign: TextAlign.start,
                            style: txtMediumUnderline(14, primaryColorBase),
                          ),
                        ),
                        vpad(12),
                        ...arg.document!.map(
                          (e) => InkWell(
                            onTap: () async {
                              await launchUrl(
                                Uri.parse(
                                    "${ApiConstants.uploadURL}?load=${e.id}"),
                                mode: LaunchMode.externalApplication,
                              );
                            },
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                e.name ?? "",
                                textAlign: TextAlign.left,
                                style: txtMedium(
                                  14,
                                  primaryColor6,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                vpad(50)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
