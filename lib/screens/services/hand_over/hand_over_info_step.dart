import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:app_cudan/screens/services/hand_over/prv/accept_hand_over_prv.dart';
import 'package:app_cudan/services/api_hand_over.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/info_content_view.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_button.dart';
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
    int status,
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
      int status = data[1];
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
    var handOverCopy = context.watch<AcceptHandOverPrv>().handOverCopy;
    var ruleFiles = context.watch<AcceptHandOverPrv>().ruleFiles;
    Animation<double> animationInfoDrop = CurvedAnimation(
      parent: animationInfoController,
      curve: Curves.easeInOut,
    );
    var workArising = context.watch<AcceptHandOverPrv>().workArising;

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
                child: Form(
                  key: context.read<AcceptHandOverPrv>().infoKeyStep,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged:
                      context.read<AcceptHandOverPrv>().onChangeFormInfoStep,
                  child: Column(
                    children: [
                      vpad(16),
                      PrimaryDropDown(
                        enable: false,
                        value: handOverCopy.apartmentId,
                        label: S.of(context).surface,
                        selectList: [
                          DropdownMenuItem(
                            value: handOverCopy.apartmentId,
                            child: Text(
                              handOverCopy.a?.name! != null
                                  ? handOverCopy.label ??
                                      '${handOverCopy.a?.name} - ${handOverCopy.a?.f?.name} - ${handOverCopy.a?.b?.name}'
                                  : handOverCopy.apartmentId!,
                            ),
                          ),
                        ],
                        isDense: false,
                      ),
                      vpad(16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 4,
                            child: PrimaryTextField(
                              component: Expanded(
                                flex: 21,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: Align(
                                        alignment: Alignment.topCenter,
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
                                      child: PrimaryTextField(
                                        controller: context
                                            .read<AcceptHandOverPrv>()
                                            .realAreaController,
                                        isRequired: true,
                                        isShow: false,
                                        filter: [
                                          FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9.]'),
                                          ),
                                        ],
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                        enable: true,
                                        validator: context
                                            .read<AcceptHandOverPrv>()
                                            .validateAreaForm,
                                        validateString: context
                                            .watch<AcceptHandOverPrv>()
                                            .validaterRealArea,
                                        keyboardType: TextInputType.number,
                                        // initialValue:
                                        //     (handOver.real_acreage ?? '0')
                                        //         .toString(),
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
                                  (handOverCopy.sale?.area_of_private ?? '0')
                                      .toString(),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: Align(
                                        alignment: Alignment.topCenter,
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
                                      child: PrimaryTextField(
                                        controller: context
                                            .read<AcceptHandOverPrv>()
                                            .realFloorController,
                                        isRequired: true,
                                        isShow: false,
                                        filter: [
                                          FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9.]'),
                                          ),
                                        ],
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                        enable: true,
                                        validateString: context
                                            .watch<AcceptHandOverPrv>()
                                            .validateRealFloor,
                                        validator: context
                                            .read<AcceptHandOverPrv>()
                                            .validateAreaForm,
                                        keyboardType: TextInputType.number,
                                        // initialValue:
                                        //     (handOver.real_floor_area ?? '0')
                                        //         .toString(),
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
                                  (handOverCopy.sale?.floor_area ?? '0')
                                      .toString(),
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
                            "${handOverCopy.schedule_hour} ${Utils.dateFormat(handOverCopy.schedule_time ?? "", 1)}",
                      ),
                      vpad(16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: PrimaryTextField(
                              isReadOnly: true,
                              isRequired: true,
                              controller: context
                                  .read<AcceptHandOverPrv>()
                                  .handOverDateController,
                              validateString: context
                                  .watch<AcceptHandOverPrv>()
                                  .validateHandOverDate,
                              onTap: () {
                                context
                                    .read<AcceptHandOverPrv>()
                                    .pickHandOverDate(context);
                              },
                              label: S.of(context).reality_handover_date,
                              suffixIcon: const PrimaryIcon(
                                padding: EdgeInsets.zero,
                                icons: PrimaryIcons.calendar,
                              ),
                              validator: Utils.emptyValidator,
                            ),
                          ),
                          hpad(16),
                          Expanded(
                            child: PrimaryTextField(
                              validator: Utils.emptyValidator,
                              isReadOnly: true,
                              isRequired: true,
                              label: S.of(context).reality_handover_hour,
                              controller: context
                                  .read<AcceptHandOverPrv>()
                                  .handOverHourController,
                              validateString: context
                                  .watch<AcceptHandOverPrv>()
                                  .validateHandOverHour,
                              onTap: () {
                                context
                                    .read<AcceptHandOverPrv>()
                                    .pickHandOverHour(context);
                              },
                              suffixIcon: const PrimaryIcon(
                                padding: EdgeInsets.zero,
                                icons: PrimaryIcons.clock,
                              ),
                            ),
                          ),
                        ],
                      ),
                      vpad(16),
                      FutureBuilder(
                        future: () async {
                          var name = await APIHandOver.getHanOverPerson(
                            handOverCopy.appointmentScheduleId,
                          );

                          return name;
                        }(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var nameEmployee = snapshot.data;
                            return PrimaryTextField(
                              enable: false,
                              isRequired: true,
                              label: S.of(context).hand_over_employee,
                              initialValue: nameEmployee,
                            );
                          }
                          return vpad(0);
                        },
                      ),
                      vpad(16),
                      SelectFileWidget(
                        enable: false,
                        title: S.of(context).drawing,
                        isRequired: true,
                        isDash: false,
                        existFiles: handOverCopy.floor_plan_drawing ?? [],
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
            ),
            vpad(30),
            PrimaryTextField(
              textColor: genStatusColor(handOverCopy.status ?? ''),
              label: S.of(context).status,
              enable: false,
              initialValue: handOverCopy.s?.name,
              textStyle: txtBold(14, genStatusColor(handOverCopy.status)),
            ),
            if (handOverCopy.cancel_reason != null) vpad(16),
            if (handOverCopy.cancel_reason != null)
              PrimaryTextField(
                maxLines: 2,
                label: S.of(context).err_reason,
                enable: false,
                isReadOnly: true,
                initialValue: handOverCopy.df?.name,
              ),
            if (handOverCopy.cancel_note != null) vpad(16),
            if (handOverCopy.cancel_note != null)
              PrimaryTextField(
                maxLines: 2,
                label: S.of(context).note,
                enable: false,
                isReadOnly: true,
                initialValue: handOverCopy.cancel_note,
              ),
            if (workArising != null) vpad(16),
            if (workArising != null)
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  S.of(context).processing_result,
                  style: txtBodySmallBold(
                    color: grayScaleColorBase,
                  ),
                ),
              ),
            if (workArising?.to_do_list_result?[0].result != null) vpad(10),
            if (workArising?.to_do_list_result?[0].result != null)
              PrimaryTextField(
                maxLines: 2,
                label: S.of(context).processing_content,
                enable: false,
                isReadOnly: true,
                initialValue: workArising?.to_do_list_result?[0].result,
              ),
            if ((workArising?.to_do_list_result?[0].file ?? []).isNotEmpty)
              vpad(16),
            if ((workArising?.to_do_list_result?[0].file ?? []).isNotEmpty)
              SelectFileWidget(
                title: S.of(context).file_image,
                enable: false,
                existFiles: workArising?.to_do_list_result?[0].file ?? [],
              ),
            vpad(40),
            PrimaryButton(
              onTap: () async {
                await context.read<AcceptHandOverPrv>().infoStep2Next(context);
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
