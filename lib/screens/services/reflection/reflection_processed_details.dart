// ignore_for_file: unused_local_variable

import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:app_cudan/models/reflection.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_dropdown.dart';
import 'package:app_cudan/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/area.dart';
import '../../../models/info_content_view.dart';
import '../../../models/multi_select_view_model.dart';
import '../../../models/response_resident_own.dart';
import '../../../services/api_reflection.dart';
import '../../../services/api_service.dart';
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
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );
  late AnimationController animationResultController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );
  late Animation<double> rotateInfoAnimation;
  late Animation<double> rotateResultAnimation;
  var listAreaType = [
    DropdownMenuItem(
      value: 'PIN',
      child: Text(S.current.pin),
    ),
    DropdownMenuItem(
      value: 'BUILDING',
      child: Text(S.current.building),
    )
  ];
  List<MultiSelectViewModel> listZoneChoice = [];
  List<MultiSelectViewModel> listFloorChoice = [];

  @override
  void initState() {
    super.initState();
    rotateInfoAnimation =
        Tween<double>(begin: 0, end: pi).animate(animationInfoController);
    rotateResultAnimation =
        Tween<double>(begin: 0, end: pi).animate(animationResultController);

    IsolateNameServer.registerPortWithName(
      _port.sendPort,
      'downloader_send_port',
    );
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];

      if (status == DownloadTaskStatus.complete) {
        print("Download complete");
      }
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
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
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    animationInfoController.dispose();
    animationResultController.dispose();
    super.dispose();
  }

  ReceivePort _port = ReceivePort();

  bool isShowInfo = true;
  bool isShowResult = true;

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
      body: FutureBuilder(
        future: () async {
          await APIReflection.getListAreaByType(arg.areaType ?? '').then((v) {
            listZoneChoice.clear();
            for (var i in v) {
              var a = Area.fromMap(i);
              var s = MultiSelectViewModel(
                value: a.id,
                title: a.name,
                isSelected: false,
              );
              if (arg.areaType == 'PIN' &&
                  arg.areaIds != null &&
                  arg.areaIds!.contains(i["_id"])) {
                s.isSelected = true;
              }
              listZoneChoice.add(
                s,
              );
            }
          });
          await APIReflection.getFloorList(
            arg.apartmentId,
          ).then((v) {
            listFloorChoice.clear();
            if (v != null) {
              for (var i in v) {
                var floor = Floor.fromJson(i);
                var s = MultiSelectViewModel(
                  title: '${floor.name}-${floor.b?.name}',
                  value: floor.id,
                  isSelected: false,
                );

                if (arg.areaType == 'BUILDING' &&
                    arg.floorIds != null &&
                    arg.floorIds!.contains(i["_id"])) {
                  s.isSelected = true;
                }
                listFloorChoice.add(s);
              }
            }
          });

          print(listZoneChoice);
          print(listFloorChoice);
        }(),
        builder: (context, snapshot) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    vpad(20),
                    InkWell(
                      // onTap: () {
                      //   if (isShowInfo) {
                      //     isShowInfo = false;
                      //     animationInfoController.reverse();
                      //   } else {
                      //     isShowInfo = true;
                      //     animationInfoController.forward();
                      //   }
                      // },
                      child: Row(
                        children: [
                          const Icon(Icons.layers_outlined),
                          hpad(20),
                          Text(
                            S.of(context).general_info,
                            style: txtBoldUnderline(14),
                          ),
                          hpad(30),
                          // SizedBox(
                          //   height: 15.0,
                          //   width: 15.0,
                          //   child: AnimatedBuilder(
                          //     animation: animationInfoController,
                          //     builder: (context, child) => Transform.rotate(
                          //       origin: const Offset(4, 4),
                          //       angle: rotateInfoAnimation.value,
                          //       child: child,
                          //     ),
                          //     child: const Icon(Icons.keyboard_arrow_down_rounded),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    // SizeTransition(
                    //   sizeFactor: animationInfoDrop,
                    //   child:

                    SingleChildScrollView(
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
                            initialValue: Utils.dateFormat(arg.date ?? '', 1),
                            enable: false,
                          ),
                          vpad(12),
                          PrimaryTextField(
                            label: S.of(context).reflection_type,
                            initialValue: arg.ticket_type == 'COMPLAIN'
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
                          PrimaryDropDown(
                            hint: '',
                            selectList: listAreaType,
                            label: S.of(context).zone_type,
                            value: arg.areaType,
                            enable: false,
                          ),
                          vpad(12),
                          PrimaryDropDown(
                            hint: '',
                            isMultiple: true,
                            selectMultileList: arg.areaType == 'PIN'
                                ? listZoneChoice
                                : listFloorChoice,
                            label: S.of(context).zone,
                            value: arg.areaType == 'PIN'
                                ? arg.areaIds
                                : arg.floorIds,
                            enable: false,
                          ),
                          if (arg.files!.isNotEmpty) vpad(12),
                          if (arg.files!.isNotEmpty)
                            Text(
                              S.of(context).photos,
                              style: txtBodySmallRegular(
                                color: grayScaleColorBase,
                              ),
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
                                    ...arg.files!.map(
                                      (e) => Padding(
                                        padding:
                                            const EdgeInsets.only(right: 14),
                                        child: PrimaryImageNetwork(
                                          path:
                                              "${ApiService.shared.uploadURL}?load=${e.id ?? ""}&regcode=${ApiService.shared.regCode}",
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          vpad(12),
                          PrimaryTextField(
                            textColor: genStatusColor(arg.status ?? ''),
                            label: S.of(context).status,
                            enable: false,
                            initialValue: arg.s!.name,
                            textStyle:
                                txtBold(14, genStatusColor(arg.status ?? "")),
                          ),
                          vpad(12),
                        ],
                      ),
                    ),
                    // ),
                    vpad(12),
                    InkWell(
                      // onTap: () {
                      //   if (isShowResult) {
                      //     isShowResult = false;
                      //     animationResultController.reverse();
                      //   } else {
                      //     isShowResult = true;
                      //     animationResultController.forward();
                      //   }
                      // },
                      child: Row(
                        children: [
                          const Icon(Icons.layers_outlined),
                          hpad(20),
                          Text(
                            S.of(context).processing_result,
                            style: txtBoldUnderline(14),
                          ),
                          hpad(30),
                          // SizedBox(
                          //   height: 15.0,
                          //   width: 15.0,
                          //   child: AnimatedBuilder(
                          //     animation: animationResultController,
                          //     builder: (context, child) => Transform.rotate(
                          //       origin: const Offset(4, 4),
                          //       angle: rotateResultAnimation.value,
                          //       child: child,
                          //     ),
                          //     child: const Icon(Icons.keyboard_arrow_down_rounded),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    vpad(12),
                    // SizeTransition(
                    //   sizeFactor: animationResultDrop,
                    //   child:
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          PrimaryTextField(
                            maxLines: 3,
                            label: S.of(context).processing_content,
                            initialValue:
                                arg.result?.to_do_list_result?[0].result ?? '',
                            enable: false,
                          ),
                          // vpad(12),
                          // PrimaryTextField(
                          //   maxLines: 3,
                          //   label: S.of(context).note,
                          //   initialValue: arg.result_note ?? '',
                          //   enable: false,
                          // ),
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
                          ...(arg.result?.to_do_list_result?[0].file ?? []).map(
                            (e) => InkWell(
                              onTap: () async {
                                await Utils.downloadFile(
                                  url:
                                      '${ApiService.shared.uploadURL}?load=${e.id}&regcode=${ApiService.shared.regCode}',
                                  context: context,
                                );
                                // await launchUrl(
                                //   Uri.parse(
                                //     '${ApiConstants.uploadURL}?load=${e.id}',
                                //   ),
                                //   mode: LaunchMode.externalApplication,
                                // );
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
                    // ),
                    vpad(50)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
