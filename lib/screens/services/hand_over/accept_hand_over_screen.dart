import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:app_cudan/models/hand_over.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_dropdown.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:app_cudan/widgets/primary_text_field.dart';
import 'package:app_cudan/widgets/select_file_widget.dart';
import 'package:app_cudan/widgets/select_media_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:provider/provider.dart';

import '../../../constants/api_constant.dart';
import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/asset_Item_view_model.dart';
import '../../../models/info_content_view.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_icon.dart';
import '../../auth/prv/resident_info_prv.dart';
import 'prv/accept_hand_over_prv.dart';
import 'widget/asset_item.dart';
import 'widget/not_pass_widget.dart';

class AcceptHandOverScreen extends StatefulWidget {
  const AcceptHandOverScreen({super.key});
  static const routeName = '/hand-over/accept';

  @override
  State<AcceptHandOverScreen> createState() => _AcceptHandOverScreenState();
}

class _AcceptHandOverScreenState extends State<AcceptHandOverScreen>
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
  late AnimationController animationAssetController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );
  late AnimationController animationMaterialController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );
  late Animation<double> rotateInfoAnimation;
  late Animation<double> rotateAssetAnimation;
  late Animation<double> rotateMaterialAnimation;

  // final StreamController<bool> showController = StreamController<bool>();
  @override
  void initState() {
    super.initState();
    rotateInfoAnimation =
        Tween<double>(begin: 0, end: pi).animate(animationInfoController);
    rotateAssetAnimation =
        Tween<double>(begin: 0, end: pi).animate(animationAssetController);
    rotateMaterialAnimation =
        Tween<double>(begin: 0, end: pi).animate(animationMaterialController);
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
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    animationInfoController.dispose();
    animationAssetController.dispose();
    animationMaterialController.dispose();
    IsolateNameServer.removePortNameMapping('downloader_send_port');

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    final status = arg['status'];
    HandOver handOver = arg['handover'];

    Map<String, dynamic> material = {};
    if (handOver.material_list != null) {
      for (var i in handOver.material_list!) {
        // material[i.]
      }
    }

    return ChangeNotifierProvider(
      create: (context) => AcceptHandOverPrv(handOver),
      builder: (context, snapshot) {
        bool isShowInfo = context.watch<AcceptHandOverPrv>().generalInfoExpand;
        bool isShowAsset = context.watch<AcceptHandOverPrv>().assetListExpand;
        bool isShowMaterial =
            context.watch<AcceptHandOverPrv>().materialListExpand;

        Animation<double> animationInfoDrop = CurvedAnimation(
          parent: animationInfoController,
          curve: Curves.easeInOut,
        );
        Animation<double> animationAssetDrop = CurvedAnimation(
          parent: animationAssetController,
          curve: Curves.easeInOut,
        );
        Animation<double> animationMaterialDrop = CurvedAnimation(
          parent: animationMaterialController,
          curve: Curves.easeInOut,
        );

        return FutureBuilder(
          future: context.read<AcceptHandOverPrv>().getRuleFiles(),
          builder: (context, snapshot) {
            var ruleFiles = context.watch<AcceptHandOverPrv>().ruleFiles;
            return PrimaryScreen(
              appBar: PrimaryAppbar(
                title: S.of(context).accept_hand_over,
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: SingleChildScrollView(
                    child: Form(
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
                              // showController.add(isShow);
                              context
                                  .read<AcceptHandOverPrv>()
                                  .toggleGeneralInfo();
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.layers_outlined),
                                hpad(20),
                                Text(
                                  S.of(context).general_info,
                                  style: txtBoldUnderline(14),
                                ),
                                hpad(30),
                                SizedBox(
                                  height: 15.0,
                                  width: 15.0,
                                  child: AnimatedBuilder(
                                    animation: animationInfoController,
                                    builder: (context, child) =>
                                        Transform.rotate(
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
                              key: context.read<AcceptHandOverPrv>().infoKey,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: PrimaryTextField(
                                          unit: '(m²)',
                                          label:
                                              S.of(context).s_usage_apartment,
                                          isRequired: true,
                                          enable: false,
                                          initialValue:
                                              (handOver.floor_area ?? '0')
                                                  .toString(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  vpad(16),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: PrimaryTextField(
                                          unit: '(m²)',
                                          label: S.of(context).s_cons_apartment,
                                          isRequired: true,
                                          enable: false,
                                          initialValue:
                                              (handOver.real_floor_area ?? '0')
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
                                        "${handOver.schedule_hour} ${Utils.dateFormat(handOver.schedule_time ?? "", 1)}",
                                  ),
                                  vpad(16),
                                  PrimaryTextField(
                                    enable: false,
                                    isRequired: true,
                                    label: S.of(context).hand_over_employee,
                                    initialValue:
                                        "${handOver.schedule_hour} ${Utils.dateFormat(handOver.schedule_time ?? "", 1)}",
                                  ),
                                  vpad(16),
                                  SelectFileWidget(
                                    enable: false,
                                    title: S.of(context).drawing,
                                    isRequired: true,
                                    isDash: false,
                                    existFiles: handOver.floor_plan_drawing ??
                                        // ?.map(
                                        //   (v) =>
                                        //       "${ApiConstants.uploadURL}?load=${v.id}",
                                        // )
                                        // .toList() ??
                                        [],
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
                                  ...ruleFiles.map(
                                    (v) => Align(
                                      alignment: Alignment.centerLeft,
                                      child: InkWell(
                                        onTap: () {
                                          Utils.downloadFile(
                                            context: context,
                                            id: v.id,
                                          );
                                        },
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
                                          child: Text(
                                            v.name ?? "",
                                            style: txtRegular(
                                              13,
                                              primaryColorBase,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          vpad(30),

                          InkWell(
                            onTap: () {
                              if (isShowAsset) {
                                isShowAsset = false;
                                animationAssetController.reverse();
                              } else {
                                isShowAsset = true;
                                animationAssetController.forward();
                              }

                              context
                                  .read<AcceptHandOverPrv>()
                                  .toggleAssetList();
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.house_siding_rounded),
                                hpad(20),
                                Expanded(
                                  child: Text(
                                    S.of(context).material_list,
                                    style: txtBoldUnderline(14),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                hpad(20),
                                SizedBox(
                                  height: 15.0,
                                  width: 15.0,
                                  child: AnimatedBuilder(
                                    animation: animationAssetController,
                                    builder: (context, child) =>
                                        Transform.rotate(
                                      origin: const Offset(4, 4),
                                      angle: rotateAssetAnimation.value,
                                      child: child,
                                    ),
                                    child: const Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                    ),
                                  ),
                                ),
                                hpad(10),
                              ],
                            ),
                          ),
                          SizeTransition(
                            sizeFactor: animationAssetDrop,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  vpad(16),
                                  ...context
                                      .watch<AcceptHandOverPrv>()
                                      .assetList
                                      .entries
                                      .map((e) {
                                    return AssetItem(
                                      vote: true,
                                      type: DetailType.ASSET,
                                      region: e.value[0].assetposition
                                              ?.asset_postision ??
                                          "",
                                      selectPass: context
                                          .watch<AcceptHandOverPrv>()
                                          .selectItemPass,
                                      data: AssetItemViewModel(
                                        type: 'material',
                                        title: e.value[0].assetposition
                                            ?.asset_postision,
                                        list: e.value
                                            .map(
                                              (e) => ItemViewModel(
                                                id: e.id,
                                                code: e.id,
                                                name: e.name_additional,
                                                achieve: e.achieve ?? false,
                                                not_achieve:
                                                    e.not_achieve ?? false,
                                              ),
                                            )
                                            .toList(),
                                      ),
                                      index: e.key,
                                    );
                                  }),
                                  vpad(3),
                                  // NotPassWidget(
                                  //   selectItem: (
                                  //     bool value,
                                  //     int indexAsset,
                                  //     int indexItem,
                                  //   ) =>
                                  //       context
                                  //           .read<AcceptHandOverPrv>()
                                  //           .selectItemPass(
                                  //             value,
                                  //             indexAsset,
                                  //             indexItem,
                                  //           ),
                                  //   status: status,
                                  //   list: context
                                  //       .watch<AcceptHandOverPrv>()
                                  //       .notPassList,
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          vpad(30),
                          InkWell(
                            onTap: () {
                              if (isShowMaterial) {
                                isShowMaterial = false;
                                animationMaterialController.reverse();
                              } else {
                                isShowMaterial = true;
                                animationMaterialController.forward();
                              }

                              context
                                  .read<AcceptHandOverPrv>()
                                  .toggleMaterialList();
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.home_outlined),
                                hpad(20),
                                Expanded(
                                  child: Text(
                                    S.of(context).asset_list,
                                    style: txtBoldUnderline(14),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                hpad(20),
                                SizedBox(
                                  height: 15.0,
                                  width: 15.0,
                                  child: AnimatedBuilder(
                                    animation: animationMaterialController,
                                    builder: (context, child) =>
                                        Transform.rotate(
                                      origin: const Offset(4, 4),
                                      angle: rotateMaterialAnimation.value,
                                      child: child,
                                    ),
                                    child: const Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                    ),
                                  ),
                                ),
                                hpad(10),
                              ],
                            ),
                          ),
                          vpad(16),
                          SizeTransition(
                            sizeFactor: animationMaterialDrop,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  vpad(16),
                                  ...context
                                      .watch<AcceptHandOverPrv>()
                                      .materialList
                                      .entries
                                      .map((e) {
                                    return AssetItem(
                                      vote: true,
                                      type: DetailType.MATERIAL,
                                      region: e.value[0].assetposition
                                              ?.asset_postision ??
                                          "",
                                      selectPass: context
                                          .watch<AcceptHandOverPrv>()
                                          .selectItemPass,
                                      data: AssetItemViewModel(
                                        type: 'material',
                                        title: e.value[0].assetposition
                                            ?.asset_postision,
                                        list: e.value
                                            .map(
                                              (e) => ItemViewModel(
                                                id: e.id,
                                                code: e.code,
                                                name: e.materiallist
                                                    ?.material_list,
                                                achieve: e.achieve ?? false,
                                                not_achieve:
                                                    e.not_achieve ?? false,
                                              ),
                                            )
                                            .toList(),
                                      ),
                                      index: e.key,
                                    );
                                  }),
                                  vpad(3),
                                  // NotPassWidget(
                                  //   selectItem: (
                                  //     bool value,
                                  //     int indexAsset,
                                  //     int indexItem,
                                  //   ) =>
                                  //       context
                                  //           .read<AcceptHandOverPrv>()
                                  //           .selectItemPass(
                                  //             value,
                                  //             indexAsset,
                                  //             indexItem,
                                  //           ),
                                  //   status: status,
                                  //   list: context
                                  //       .watch<AcceptHandOverPrv>()
                                  //       .notPassList,
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          vpad(16),
                          PrimaryTextField(
                            textColor: genStatusColor(status ?? ''),
                            label: S.of(context).status,
                            enable: false,
                            initialValue: handOver.s?.name,
                            textStyle: txtBold(14, genStatusColor(status)),
                          ),
                          if (handOver.cancel_note != null) vpad(16),
                          if (handOver.cancel_note != null)
                            PrimaryTextField(
                              maxLines: 2,
                              label: S.of(context).err_reason,
                              enable: false,
                              isReadOnly: true,
                              initialValue: genStatus(status),
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
                          Row(
                            children: [
                              Expanded(
                                child: PrimaryButton(
                                  buttonType: ButtonType.orange,
                                  onTap: () {},
                                  width: dvWidth(context) - 24,
                                  text: S.of(context).err_report,
                                ),
                              ),
                              hpad(20),
                              Expanded(
                                child: PrimaryButton(
                                  onTap: () {},
                                  width: dvWidth(context) - 24,
                                  text: S.of(context).accept_hand_over,
                                ),
                              ),
                            ],
                          ),
                          vpad(60),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
