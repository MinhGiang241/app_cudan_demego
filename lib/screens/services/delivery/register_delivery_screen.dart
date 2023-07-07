import 'dart:isolate';
import 'dart:ui';

import 'package:app_cudan/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/delivery.dart';
import '../../../utils/utils.dart';
import '../../../widgets/dash_button.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_card.dart';
import '../../../widgets/primary_icon.dart';
import '../../../widgets/primary_screen.dart';
import '../../../widgets/primary_text_field.dart';
import '../../../widgets/select_media_widget.dart';
import 'provider/register_delivery_prv.dart';

class RegisterDelivery extends StatefulWidget {
  const RegisterDelivery({super.key});
  static const routeName = '/delivery/register';

  @override
  State<RegisterDelivery> createState() => _RegisterDeliveryState();
}

class _RegisterDeliveryState extends State<RegisterDelivery> {
  ReceivePort port = ReceivePort();
  @override
  void initState() {
    super.initState();

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

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    var isEdit = arg['isEdit'];
    Delivery delivery = Delivery();
    if (isEdit) {
      delivery = arg['data'];
    }

    return ChangeNotifierProvider(
      create: (context) => RegisterDeliveryPrv(
        delivery: delivery,
        endTime: delivery.end_hour != null
            ? TimeOfDay(
                hour: int.parse(delivery.end_hour!.split(":")[0]),
                minute: int.parse(delivery.end_hour!.split(":")[1]),
              )
            : null,
        startTime: delivery.start_hour != null
            ? TimeOfDay(
                hour: int.parse(delivery.start_hour!.split(":")[0]),
                minute: int.parse(delivery.start_hour!.split(":")[1]),
              )
            : null,
        startDate: delivery.start_time != null
            ? DateTime.parse(delivery.start_time ?? "")
            : null,
        endDate: delivery.end_time != null
            ? DateTime.parse(delivery.end_time ?? "")
            : null,
        code: delivery.code,
        id: delivery.id,
        existedImage: delivery.image ?? [],
        helpCheck: delivery.help_check ?? false,
        useElevator: delivery.elevator ?? false,
        packageItems: delivery.item_added_list ?? [],
        type: delivery.type_transfer == "IN" ? 2 : 1,
      ),
      builder: ((context, child) {
        var ruleFiles = context.watch<RegisterDeliveryPrv>().rulesFiles;

        return PrimaryScreen(
          appBar: PrimaryAppbar(
            title: isEdit
                ? S.of(context).edit_reg_deliver
                : S.of(context).reg_deliver,
          ),
          body: FutureBuilder(
            future: context.read<RegisterDeliveryPrv>().getRule(context),
            builder: (context, snapshot) {
              return Form(
                onChanged: context.watch<RegisterDeliveryPrv>().autoValid
                    ? () =>
                        context.read<RegisterDeliveryPrv>().validate(context)
                    : null,
                autovalidateMode: context.watch<RegisterDeliveryPrv>().autoValid
                    ? AutovalidateMode.onUserInteraction
                    : null,
                key: context.watch<RegisterDeliveryPrv>().formKey,
                child: SafeArea(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    children: [
                      vpad(20),
                      Row(
                        children: [
                          Text(
                            S.of(context).transfer_type,
                            style:
                                txtBodySmallRegular(color: grayScaleColorBase),
                          ),
                          Text(
                            ' *',
                            style: txtBodySmallRegular(color: redColor1),
                          )
                        ],
                      ),
                      vpad(16),
                      Row(
                        children: [
                          InkWell(
                            onTap: () => context
                                .read<RegisterDeliveryPrv>()
                                .selectTransferType(1),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color:
                                    context.watch<RegisterDeliveryPrv>().type ==
                                            1
                                        ? primaryColor4
                                        : Colors.white,
                                border:
                                    Border.all(width: 2, color: primaryColor3),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(S.of(context).tranfer_out),
                            ),
                          ),
                          hpad(30),
                          InkWell(
                            onTap: () => context
                                .read<RegisterDeliveryPrv>()
                                .selectTransferType(2),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color:
                                    context.watch<RegisterDeliveryPrv>().type ==
                                            2
                                        ? primaryColor4
                                        : Colors.white,
                                border:
                                    Border.all(width: 2, color: primaryColor3),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(S.of(context).tranfer_in),
                            ),
                          ),
                        ],
                      ),
                      vpad(16),
                      Row(
                        children: [
                          Text(
                            S.of(context).start_time,
                            style:
                                txtBodySmallRegular(color: grayScaleColorBase),
                          ),
                          Text(
                            '  *',
                            style: txtBodySmallRegular(color: redColor1),
                          )
                        ],
                      ),
                      vpad(12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: PrimaryTextField(
                              validateString: context
                                  .watch<RegisterDeliveryPrv>()
                                  .validateStartDate,
                              controller: context
                                  .read<RegisterDeliveryPrv>()
                                  .startDateController,
                              label: S.of(context).date,
                              hint: "dd/mm/yyyy",
                              isReadOnly: true,
                              isRequired: true,
                              onTap: () {
                                context
                                    .read<RegisterDeliveryPrv>()
                                    .pickStartDate(context);
                              },
                              suffixIcon: const PrimaryIcon(
                                icons: PrimaryIcons.calendar,
                              ),
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return '';
                                }
                                return null;
                              },
                            ),
                          ),
                          hpad(20),
                          Expanded(
                            flex: 1,
                            child: PrimaryTextField(
                              isRequired: true,
                              validateString: context
                                  .watch<RegisterDeliveryPrv>()
                                  .validateStartHour,
                              validator: Utils.emptyValidator,
                              controller: context
                                  .watch<RegisterDeliveryPrv>()
                                  .startHourController,
                              label: S.of(context).hour,
                              hint: "hh:mm",
                              isReadOnly: true,
                              onTap: () async {
                                await context
                                    .read<RegisterDeliveryPrv>()
                                    .pickStartHour(context);
                              },
                              suffixIcon:
                                  const PrimaryIcon(icons: PrimaryIcons.clock),
                            ),
                          ),
                        ],
                      ),

                      vpad(5),

                      // Text(
                      //   context
                      //           .watch<RegisterDeliveryPrv>()
                      //           .validateStartDate ??
                      //       '',
                      //   style: txtBodySmallRegular(color: redColorBase),
                      // ),
                      vpad(5),
                      Row(
                        children: [
                          Text(
                            S.of(context).end_time,
                            style:
                                txtBodySmallRegular(color: grayScaleColorBase),
                          ),
                          Text(
                            ' *',
                            style: txtBodySmallRegular(color: redColor1),
                          )
                        ],
                      ),
                      vpad(12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: PrimaryTextField(
                              validateString: context
                                  .watch<RegisterDeliveryPrv>()
                                  .validateEndDate,
                              controller: context
                                  .read<RegisterDeliveryPrv>()
                                  .endDateController,
                              label: S.of(context).date,
                              hint: "dd/mm/yyyy",
                              isReadOnly: true,
                              isRequired: true,
                              onTap: () {
                                context
                                    .read<RegisterDeliveryPrv>()
                                    .pickEndDate(context);
                              },
                              suffixIcon: const PrimaryIcon(
                                icons: PrimaryIcons.calendar,
                              ),
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return '';
                                }
                                return null;
                              },
                            ),
                          ),
                          hpad(20),
                          Expanded(
                            flex: 1,
                            child: PrimaryTextField(
                              validateString: context
                                  .watch<RegisterDeliveryPrv>()
                                  .validateEndHour,
                              validator: Utils.emptyValidator,
                              isRequired: true,
                              controller: context
                                  .read<RegisterDeliveryPrv>()
                                  .endHourController,
                              label: S.of(context).hour,
                              hint: "hh:mm",
                              isReadOnly: true,
                              onTap: () async {
                                await context
                                    .read<RegisterDeliveryPrv>()
                                    .pickEndHour(context);
                              },
                              suffixIcon:
                                  const PrimaryIcon(icons: PrimaryIcons.clock),
                            ),
                          ),
                        ],
                      ),

                      vpad(5),
                      // if (context.watch<RegisterDeliveryPrv>().validateEndDate !=
                      //     null)
                      // Text(
                      //   context.watch<RegisterDeliveryPrv>().validateEndDate ??
                      //       "",
                      //   style: txtBodySmallRegular(color: redColorBase),
                      // ),
                      vpad(5),
                      SelectMediaWidget(
                        title: S.of(context).photos,
                        existImages:
                            context.watch<RegisterDeliveryPrv>().existedImage,
                        images:
                            context.watch<RegisterDeliveryPrv>().imagesDelivery,
                        onRemove: context
                            .read<RegisterDeliveryPrv>()
                            .onRemoveImageDelivery,
                        onRemoveExist: context
                            .read<RegisterDeliveryPrv>()
                            .removeExistedImages,
                        onSelect: () => context
                            .read<RegisterDeliveryPrv>()
                            .onSelectImageDelivery(context),
                      ),
                      vpad(16),
                      Row(
                        children: [
                          DashButton(
                            text: S.of(context).add_package,
                            lable: S.of(context).package_info,
                            isRequired: true,
                            icon: const PrimaryIcon(
                              icons: PrimaryIcons.add_to_queue,
                            ),
                            onTap: () => context
                                .read<RegisterDeliveryPrv>()
                                .addPackage(context, null),
                          ),
                        ],
                      ),
                      vpad(16),
                      ...context
                          .watch<RegisterDeliveryPrv>()
                          .packageItems
                          .asMap()
                          .entries
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Dismissible(
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  color: secondaryColorBase,
                                  child: const Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                      size: 50,
                                    ),
                                  ),
                                ),
                                onDismissed: (direction) {
                                  context
                                      .read<RegisterDeliveryPrv>()
                                      .removeItemPackage(e.key);
                                },
                                key: UniqueKey(),
                                child: PrimaryCard(
                                  onTap: () {
                                    // context
                                    //     .read<RegisterDeliveryPrv>()
                                    //     .addPackage(context, e);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                      horizontal: 16,
                                    ),
                                    child: Row(
                                      children: [
                                        const PrimaryIcon(
                                          icons: PrimaryIcons.box,
                                          style: PrimaryIconStyle.gradient,
                                          gradients: PrimaryIconGradient.yellow,
                                          size: 32,
                                          padding: EdgeInsets.all(12),
                                          color: Colors.white,
                                        ),
                                        hpad(16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                e.value.item_name ?? '',
                                                style: txtLinkSmall(),
                                              ),
                                              vpad(2),
                                              Text(
                                                e.value.weight != null
                                                    ? '${S.of(context).weight} (kg): ${e.value.weight.toString()}'
                                                    : '',
                                                style: txtBodyXSmallRegular(),
                                              ),
                                              vpad(2),
                                              Text(
                                                e.value.dimension != null
                                                    ? '${S.of(context).dimention} (cm): ${e.value.dimension}'
                                                    : '',
                                                style: txtBodyXSmallRegular(),
                                              ),
                                              vpad(2),
                                              Text(
                                                e.value.amount != null
                                                    ? '${S.of(context).amount}: ${e.value.amount}'
                                                    : '',
                                                style: txtBodyXSmallRegular(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      vpad(16),
                      PrimaryTextField(
                        hint: S.of(context).note,
                        maxLength: 500,
                        controller: context
                            .read<RegisterDeliveryPrv>()
                            .describleController,
                        label: S.of(context).note,
                        maxLines: 3,
                      ),
                      vpad(16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          S.of(context).tranfer_rule,
                          style: txtBold(14, grayScaleColorBase),
                        ),
                      ),
                      if (ruleFiles.isNotEmpty) vpad(16),
                      if (ruleFiles.isNotEmpty)
                        ...ruleFiles.map(
                          (v) => InkWell(
                            onTap: () {
                              Utils.downloadFile(
                                context: context,
                                id: v.id,
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                v.name ?? "",
                                style: txtRegular(13, primaryColorBase),
                              ),
                            ),
                          ),
                        ),
                      vpad(16),
                      Table(
                        textBaseline: TextBaseline.ideographic,
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.baseline,
                        columnWidths: const {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(1),
                        },
                        children: [
                          TableRow(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 22.0,
                                    height: 22.0,
                                    child: Checkbox(
                                      fillColor: MaterialStateProperty.all(
                                        primaryColorBase,
                                      ),
                                      value: context
                                          .watch<RegisterDeliveryPrv>()
                                          .helpCheck,
                                      onChanged: (v) {
                                        context
                                            .read<RegisterDeliveryPrv>()
                                            .toggleHelpCheck();
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () => context
                                          .read<RegisterDeliveryPrv>()
                                          .toggleHelpCheck(),
                                      child: Text(
                                        S.of(context).need_support,
                                        style: txtBodySmallRegular(
                                          color: grayScaleColorBase,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 22.0,
                                    height: 22.0,
                                    child: Checkbox(
                                      fillColor: MaterialStateProperty.all(
                                        primaryColorBase,
                                      ),
                                      value: context
                                          .watch<RegisterDeliveryPrv>()
                                          .useElevator,
                                      onChanged: (v) {
                                        context
                                            .read<RegisterDeliveryPrv>()
                                            .toggleUseElevator();
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () => context
                                          .read<RegisterDeliveryPrv>()
                                          .toggleUseElevator(),
                                      child: Text(
                                        S.of(context).use_elevator,
                                        style: txtBodySmallRegular(
                                          color: grayScaleColorBase,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),

                      vpad(16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          PrimaryButton(
                            isLoading: context
                                .watch<RegisterDeliveryPrv>()
                                .isAddNewLoading,
                            buttonSize: ButtonSize.medium,
                            text: isEdit
                                ? S.of(context).update
                                : S.of(context).add_new,
                            onTap: () => context
                                .read<RegisterDeliveryPrv>()
                                .onSendSummitDelivery(context, false),
                          ),
                          PrimaryButton(
                            isLoading: context
                                .watch<RegisterDeliveryPrv>()
                                .isSendApproveLoading,
                            buttonType: ButtonType.green,
                            buttonSize: ButtonSize.medium,
                            text: S.of(context).send_request,
                            onTap: () => context
                                .read<RegisterDeliveryPrv>()
                                .onSendSummitDelivery(context, true),
                          ),
                        ],
                      ),
                      vpad(24),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
