import 'package:app_cudan/models/delivery.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../constants/api_constant.dart';
import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/info_content_view.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_info_widget.dart';
import '../../../widgets/primary_screen.dart';
import '../../../widgets/timeline_view.dart';
import '../transport_card/add_new_transport_card.dart';
import 'register_delivery_screen.dart';

class PackageDetailScreen extends StatefulWidget {
  const PackageDetailScreen({super.key});
  static const routeName = '/delivery/details';

  @override
  State<PackageDetailScreen> createState() => _PackageDetailScreenState();
}

class _PackageDetailScreenState extends State<PackageDetailScreen>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);
  @override
  Widget build(BuildContext context) {
    final arg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    var card = arg['card'] as Delivery;
    var isOwner = arg['isOwner'] ?? false;
    var cancel = arg['cancel'] as Function?;
    var accept = arg['accept'] as Function?;
    var refuse = arg['refuse'] as Function?;
    var send = arg['send'] as Function?;

    return PrimaryScreen(
      appBar: PrimaryAppbar(
        title: S.of(context).details,
        tabController: tabController,
        isTabScrollabel: false,
        tabs: [
          Tab(text: S.of(context).details),
          Tab(text: S.of(context).history),
        ],
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          ListView(
            children: [
              vpad(24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: PrimaryInfoWidget(
                  label: S.of(context).delivery_info,
                  listInfoView: [
                    InfoContentView(
                      isHorizontal: true,
                      title: S.of(context).apartment,
                      content:
                          "${card.a?.name ?? ""} - ${card.a?.f?.name ?? ""} - ${card.a?.b?.name ?? ""}",
                    ),
                    InfoContentView(
                      isHorizontal: true,
                      title: S.of(context).full_name,
                      content: card.re?.info_name ?? "",
                    ),
                    InfoContentView(
                      isHorizontal: true,
                      title: S.of(context).transfer_type,
                      content: card.type_transfer == "IN"
                          ? S.of(context).tranfer_in
                          : S.of(context).tranfer_out,
                    ),
                    InfoContentView(
                      isHorizontal: true,
                      title: S.of(context).start_time,
                      content:
                          '${(card.start_hour != null ? "${card.start_hour!.substring(0, 5)} " : "")}${Utils.dateFormat(card.end_time ?? "", 1)}',
                    ),
                    InfoContentView(
                      isHorizontal: true,
                      title: S.of(context).end_time,
                      content:
                          '${(card.end_hour != null ? "${card.end_hour!.substring(0, 5)} " : "")}${Utils.dateFormat(card.end_time ?? "", 1)}',
                    ),
                    InfoContentView(
                      isHorizontal: true,
                      title: S.of(context).letter_num,
                      content: card.code,
                      contentStyle: txtBold(16, purpleColorBase),
                    ),
                    if (card.r != null)
                      InfoContentView(
                        isHorizontal: true,
                        title: S.of(context).cancel_reason,
                        content: card.r?.name ?? "",
                      ),
                    if (card.describe != null)
                      InfoContentView(
                        isHorizontal: true,
                        title: S.of(context).description,
                        content: card.describe,
                      ),
                    InfoContentView(
                      isHorizontal: true,
                      title: S.of(context).letter_status,
                      content: !isOwner
                          ? (card.status == "WAIT_OWNER" ||
                                  card.status == "WAIT_MANAGER")
                              ? S.of(context).wait_approve
                              : card.s?.name ?? ""
                          : card.status == 'WAIT_MANAGER'
                              ? S.of(context).wait_approve
                              : card.s?.name ?? "",
                      contentStyle: genContentStyle(
                        !isOwner
                            ? (card.status == "WAIT_OWNER" ||
                                    card.status == "WAIT_MANAGER")
                                ? "WAIT"
                                : card.status ?? ""
                            : card.status == "WAIT_MANAGER"
                                ? "WAIT"
                                : card.status ?? "",
                      ),
                    ),
                    if (card.image!.isNotEmpty)
                      InfoContentView(
                        title: S.of(context).photos,
                        images: card.image!.isEmpty
                            ? null
                            : [
                                ...card.image!.map(
                                  (v) =>
                                      "${ApiConstants.uploadURL}/?load=${v.id}",
                                )
                              ],
                      )
                  ],
                ),
              ),
              vpad(24),
              Padding(
                padding: const EdgeInsets.only(
                  left: 12,
                ),
                child: Text(
                  S.of(context).package_info,
                  style: txtMedium(14, grayScaleColor2),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Column(
                  children: [
                    ...card.item_added_list!.map(
                      (e) => Column(
                        children: [
                          PrimaryInfoWidget(
                            listInfoView: [
                              InfoContentView(
                                title: S.of(context).package_name,
                                content: e.item_name,
                              ),
                              InfoContentView(
                                title: '${S.of(context).weight} (kg)',
                                content: e.weight.toString(),
                              ),
                              InfoContentView(
                                title: '${S.of(context).dimention} (cm)',
                                content: e.dimension,
                              ),
                            ],
                          ),
                          vpad(16),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Table(
                  // textBaseline: TextBaseline.ideographic,
                  // defaultVerticalAlignment: TableCellVerticalAlignment.baseline,
                  columnWidths: const {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(1),
                  },
                  children: [
                    TableRow(
                      children: [
                        Wrap(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 20.0,
                                  height: 20.0,
                                  child: Checkbox(
                                    fillColor: MaterialStateProperty.all(
                                      primaryColorBase,
                                    ),
                                    value: card.help_check,
                                    onChanged: (v) {},
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    S.of(context).need_support,
                                    style: txtBodySmallRegular(
                                      color: grayScaleColorBase,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20.0,
                              height: 20.0,
                              child: Checkbox(
                                fillColor:
                                    MaterialStateProperty.all(primaryColorBase),
                                value: card.help_check,
                                onChanged: (v) {},
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Text(
                                S.of(context).use_elevator,
                                style: txtBodySmallRegular(
                                  color: grayScaleColorBase,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              if (isOwner && card.status == 'WAIT_OWNER') vpad(30),
              if (isOwner && card.status == 'WAIT_OWNER')
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    PrimaryButton(
                      isLoading: false,
                      buttonType: ButtonType.red,
                      buttonSize: ButtonSize.medium,
                      text: S.of(context).refuse,
                      onTap: () {
                        refuse!(context, card);
                      },
                    ),
                    PrimaryButton(
                      isLoading: false,
                      buttonSize: ButtonSize.medium,
                      buttonType: ButtonType.green,
                      text: S.of(context).confirm,
                      onTap: () {
                        accept!(context, card);
                      },
                    ),
                  ],
                ),
              if ((card.status == "WAIT_OWNER" ||
                      card.status == 'WAIT_MANAGER') &&
                  !isOwner)
                vpad(30),
              if ((card.status == "WAIT_OWNER" ||
                      card.status == 'WAIT_MANAGER') &&
                  !isOwner)
                PrimaryButton(
                  isLoading: false,
                  buttonSize: ButtonSize.medium,
                  buttonType: ButtonType.red,
                  text: S.of(context).reg_cancel,
                  onTap: () {
                    cancel!(context, card);
                  },
                ),
              if (card.status == "NEW") vpad(30),
              if (card.status == "NEW")
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    PrimaryButton(
                      isLoading: false,
                      buttonSize: ButtonSize.medium,
                      text: S.of(context).edit,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RegisterDelivery.routeName,
                          arguments: {"isEdit": true, "data": card},
                        );
                      },
                    ),
                    PrimaryButton(
                      isLoading: false,
                      buttonType: ButtonType.green,
                      buttonSize: ButtonSize.medium,
                      text: S.of(context).send_request,
                      onTap: () {
                        send!(context, card);
                      },
                    ),
                  ],
                ),
              vpad(bottomSafePad(context) + 24)
            ],
          ),
          ListView(
            children: [
              vpad(24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TimeLineView(),
              )
            ],
          )
        ],
      ),
    );
  }
}
