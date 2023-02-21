import 'dart:math';

import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_dropdown.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:app_cudan/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
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
  late AnimationController animationInfoController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 300));
  late AnimationController animationAssetController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 300));
  late Animation<double> rotateInfoAnimation;
  late Animation<double> rotateAssetAnimation;

  // final StreamController<bool> showController = StreamController<bool>();
  @override
  void initState() {
    super.initState();
    rotateInfoAnimation =
        Tween<double>(begin: 0, end: pi).animate(animationInfoController);
    rotateAssetAnimation =
        Tween<double>(begin: 0, end: pi).animate(animationAssetController);
    // showController.add(isShow);
  }

  @override
  void dispose() {
    animationInfoController.dispose();
    animationAssetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    final status = arg['status'];
    return ChangeNotifierProvider(
      create: (context) => AcceptHandOverPrv(),
      builder: (context, snapshot) {
        var listApartmentChoice =
            context.read<ResidentInfoPrv>().listOwn.map((e) {
          return DropdownMenuItem(
            value: e.apartmentId,
            child: Text(e.apartment?.name! != null
                ? '${e.apartment?.name} - ${e.floor?.name} - ${e.building?.name}'
                : e.apartmentId!),
          );
        }).toList();
        bool isShowInfo = context.watch<AcceptHandOverPrv>().generalInfoExpand;
        bool isShowAsset = context.watch<AcceptHandOverPrv>().assetListExpand;

        Animation<double> animationInfoDrop = CurvedAnimation(
          parent: animationInfoController,
          curve: Curves.easeInOut,
        );
        Animation<double> animationAssetDrop = CurvedAnimation(
          parent: animationAssetController,
          curve: Curves.easeInOut,
        );

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
                          context.read<AcceptHandOverPrv>().toggleGeneralInfo();
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
                                child: const Icon(
                                    Icons.keyboard_arrow_down_rounded),
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
                                label: S.of(context).surface,
                                selectList: listApartmentChoice,
                                isDense: false,
                              ),
                              vpad(16),
                              PrimaryTextField(
                                validator: Utils.emptyValidator,
                                label: S.of(context).hand_over_date,
                                isRequired: true,
                                isReadOnly: true,
                                hint: "dd/mm/yyyy",
                                onTap: () => context
                                    .read<AcceptHandOverPrv>()
                                    .pickHandOverDate(context),
                                suffixIcon: const PrimaryIcon(
                                    icons: PrimaryIcons.calendar),
                                controller: context
                                    .read<AcceptHandOverPrv>()
                                    .handOverDateController,
                                validateString: context
                                    .watch<AcceptHandOverPrv>()
                                    .validateHandOverDate,
                              ),
                              vpad(16),
                              PrimaryTextField(
                                validator: Utils.emptyValidator,
                                label: S.of(context).hand_over_time,
                                isReadOnly: true,
                                isRequired: true,
                                onTap: () => context
                                    .read<AcceptHandOverPrv>()
                                    .pickHandOverTime(context),
                                suffixIcon: const PrimaryIcon(
                                    icons: PrimaryIcons.clock),
                                hint: "hh/mm",
                                controller: context
                                    .read<AcceptHandOverPrv>()
                                    .handOverTimeController,
                                validateString: context
                                    .watch<AcceptHandOverPrv>()
                                    .validateHandOverTime,
                              ),
                              vpad(16),
                              PrimaryTextField(
                                hint: S.of(context).note,
                                label: S.of(context).note,
                                maxLines: 3,
                                controller: context
                                    .read<AcceptHandOverPrv>()
                                    .noteController,
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

                          context.read<AcceptHandOverPrv>().toggleAssetList();
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.home_outlined),
                            hpad(20),
                            Text(S.of(context).asset_list,
                                style: txtBoldUnderline(14)),
                            hpad(20),
                            SizedBox(
                              height: 15.0,
                              width: 15.0,
                              child: AnimatedBuilder(
                                animation: animationAssetController,
                                builder: (context, child) => Transform.rotate(
                                  origin: const Offset(4, 4),
                                  angle: rotateAssetAnimation.value,
                                  child: child,
                                ),
                                child: const Icon(
                                    Icons.keyboard_arrow_down_rounded),
                              ),
                            ),
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
                                .data
                                .asMap()
                                .entries
                                .map((e) {
                              return AssetItem(
                                region: e.value['title'] as String,
                                selectPass: context
                                    .watch<AcceptHandOverPrv>()
                                    .selectItemPass,
                                data: e.value,
                                index: e.key,
                              );
                            }),
                            NotPassWidget(
                              selectItem:
                                  (bool value, int indexAsset, int indexItem) =>
                                      context
                                          .read<AcceptHandOverPrv>()
                                          .selectItemPass(
                                              value, indexAsset, indexItem),
                              status: status,
                              list: context
                                  .watch<AcceptHandOverPrv>()
                                  .notPassList,
                            ),
                          ],
                        )),
                      ),
                      vpad(16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            'Biên bản bàn giao',
                            textAlign: TextAlign.start,
                            style: txtMediumUnderline(13, greenColorBase),
                          ),
                        ),
                      ),
                      vpad(16),
                      PrimaryTextField(
                        enable: false,
                        isReadOnly: true,
                        initialValue: genStatus(status),
                        textColor: genStatusColor(status),
                      ),
                      vpad(40),
                      PrimaryButton(
                        onTap: () {},
                        width: dvWidth(context) - 24,
                        text: S.of(context).close,
                      ),
                      vpad(60),
                    ],
                  ),
                )),
              ),
            ));
      },
    );
  }
}
