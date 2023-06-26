import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:app_cudan/screens/services/hand_over/prv/accept_hand_over_prv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/info_content_view.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_card.dart';
import '../../../widgets/primary_dropdown.dart';
import '../../../widgets/primary_icon.dart';
import '../../../widgets/primary_text_field.dart';
import '../../../widgets/select_file_widget.dart';

class HandOverInfoStep extends StatefulWidget {
  const HandOverInfoStep({super.key});

  @override
  State<HandOverInfoStep> createState() => _HandOverInfoStepState();
}

class _HandOverInfoStepState extends State<HandOverInfoStep>
    with TickerProviderStateMixin {
  ReceivePort port = ReceivePort();

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

  late AnimationController animationInfoController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  late Animation<double> rotateInfoAnimation;

  @override
  void initState() {
    super.initState();
    rotateInfoAnimation =
        Tween<double>(begin: 0, end: pi).animate(animationInfoController);

    // showController.add(isShow);
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      'downloader_send_port',
    );
    port.listen((dynamic data) {
      // String id = data[0];
      DownloadTaskStatus status = data[1];
      // int progress = data[2];

      if (status == DownloadTaskStatus.complete) {
        print("Download complete");
        log(data);
      }
      setState(() {});

      FlutterDownloader.registerCallback(downloadCallback);
    });
  }

  @override
  void dispose() {
    animationInfoController.dispose();
    IsolateNameServer.removePortNameMapping('downloader_send_port');

    super.dispose();
  }

  var isShowInfo = false;
  @override
  Widget build(BuildContext context) {
    var handOver = context.watch<AcceptHandOverPrv>().handOver;
    var ruleFiles = context.watch<AcceptHandOverPrv>().ruleFiles;
    Animation<double> animationInfoDrop = CurvedAnimation(
      parent: animationInfoController,
      curve: Curves.easeInOut,
    );

    return SingleChildScrollView(
      child: Form(
        child: Column(
          children: [
            vpad(20),
            InkWell(
              onTap: () {
                if (isShowInfo) {
                  setState(() {
                    isShowInfo = false;
                    animationInfoController.reverse();
                  });
                } else {
                  setState(() {
                    isShowInfo = true;
                    animationInfoController.forward();
                  });
                }
                // showController.add(isShow);
                context.read<AcceptHandOverPrv>().toggleGeneralInfo();
              },
              child: Row(
                children: [
                  const Icon(Icons.layers_outlined),
                  hpad(20),
                  Text(
                    S.of(context).general_info,
                    style: txtBoldUnderline(14),
                    overflow: TextOverflow.ellipsis,
                  ),
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
                      child: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // if (isShowInfo)
            SizeTransition(
              sizeFactor: animationInfoDrop,
              child: SingleChildScrollView(
                // key: context.read<AcceptHandOverPrv>().infoKey,
                child: Column(
                  children: [
                    vpad(16),
                    PrimaryDropDown(
                      enable: false,
                      value: handOver.apartmentId,
                      label: S.of(context).surface,
                      selectList: [
                        DropdownMenuItem(
                          value: handOver.apartmentId,
                          child: Text(
                            handOver.a?.name! != null
                                ? handOver.label ??
                                    '${handOver.a?.name} - ${handOver.a?.f?.name} - ${handOver.a?.b?.name}'
                                : handOver.apartmentId!,
                          ),
                        )
                      ],
                      isDense: false,
                    ),
                    vpad(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 4,
                          child: PrimaryTextField(
                            component: Expanded(
                              flex: 21,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        S.of(context).reality,
                                        textAlign: TextAlign.center,
                                        style: txtBodySmallRegular(
                                          color: grayScaleColorBase,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 15,
                                    child: PrimaryCard(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 12,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 16,
                                        horizontal: 12,
                                      ),
                                      child: Text(
                                        (handOver.real_acreage ?? "0")
                                            .toString(),
                                        style: txtBodySmallBold(
                                          color: grayScaleColor3,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Text(
                                      '(m²)',
                                      style: txtBodySmallBold(
                                        color: grayScaleColor3,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            label: S.of(context).s_usage_apartment,
                            isRequired: true,
                            enable: false,
                            initialValue:
                                (handOver.floor_area ?? '0').toString(),
                          ),
                        ),
                      ],
                    ),
                    vpad(16),
                    Row(
                      children: [
                        hpad(5),
                        Expanded(
                          flex: 4,
                          child: PrimaryTextField(
                            component: Expanded(
                              flex: 21,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        S.of(context).reality,
                                        textAlign: TextAlign.center,
                                        style: txtBodySmallRegular(
                                          color: grayScaleColorBase,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 15,
                                    child: PrimaryCard(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 12,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 16,
                                        horizontal: 12,
                                      ),
                                      child: Text(
                                        (handOver.real_floor_area ?? "0")
                                            .toString(),
                                        style: txtBodySmallBold(
                                          color: grayScaleColor3,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Text(
                                      '(m²)',
                                      style: txtBodySmallBold(
                                        color: grayScaleColor3,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            label: S.of(context).s_cons_apartment,
                            isRequired: true,
                            enable: false,
                            initialValue:
                                (handOver.real_floor_area ?? '0').toString(),
                          ),
                        ),
                      ],
                    ),
                    vpad(16),
                    PrimaryTextField(
                      enable: false,
                      isRequired: true,
                      label: S.of(context).time_hanover,
                      initialValue:
                          "${handOver.schedule_hour} ${Utils.dateFormat(handOver.schedule_time ?? "", 1)}",
                    ),
                    vpad(16),
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryTextField(
                            enable: false,
                            initialValue: Utils.dateFormat(
                              handOver.date ?? "",
                              1,
                            ),
                            label: S.of(context).reality_handover_date,
                            suffixIcon: const PrimaryIcon(
                              padding: EdgeInsets.zero,
                              icons: PrimaryIcons.calendar,
                            ),
                          ),
                        ),
                        hpad(16),
                        Expanded(
                          child: PrimaryTextField(
                            enable: false,
                            initialValue: handOver.hour,
                            label: S.of(context).reality_handover_hour,
                            suffixIcon: const PrimaryIcon(
                              padding: EdgeInsets.zero,
                              icons: PrimaryIcons.clock,
                            ),
                          ),
                        ),
                      ],
                    ),
                    vpad(16),
                    PrimaryTextField(
                      enable: false,
                      isRequired: true,
                      label: S.of(context).hand_over_employee,
                      initialValue: handOver.e?.name ?? '',
                    ),
                    vpad(16),
                    SelectFileWidget(
                      enable: false,
                      title: S.of(context).drawing,
                      isRequired: true,
                      isDash: false,
                      existFiles: handOver.floor_plan_drawing ?? [],
                    ),
                    vpad(16),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${S.of(context).hand_over_rule}:",
                        style: txtBodySmallBold(
                          color: grayScaleColorBase,
                        ),
                      ),
                    ),
                    if (ruleFiles.isNotEmpty) vpad(12),
                    SelectFileWidget(
                      enable: false,
                      // title:
                      //     "${S.of(context).hand_over_rule}:",
                      isRequired: true,
                      isDash: false,
                      existFiles: ruleFiles,
                    ),
                  ],
                ),
              ),
            ),
            vpad(30),
            PrimaryTextField(
              textColor: genStatusColor(handOver.status ?? ''),
              label: S.of(context).status,
              enable: false,
              initialValue: handOver.s?.name,
              textStyle: txtBold(14, genStatusColor(handOver.status)),
            ),
            if (handOver.cancel_reason != null) vpad(16),
            if (handOver.cancel_reason != null)
              PrimaryTextField(
                maxLines: 2,
                label: S.of(context).err_reason,
                enable: false,
                isReadOnly: true,
                initialValue: handOver.cancel_reason,
              ),
            if (handOver.cancel_note != null) vpad(16),
            if (handOver.cancel_note != null)
              PrimaryTextField(
                maxLines: 2,
                label: S.of(context).note,
                enable: false,
                isReadOnly: true,
                initialValue: handOver.cancel_note,
              ),
            vpad(40),

            PrimaryButton(
              onTap: () async {
                await context.read<AcceptHandOverPrv>().checkHandleHandOver(
                      context,
                    );
              },
              text: S.of(context).next,
            ),

            vpad(60),
          ],
        ),
      ),
    );
  }
}
