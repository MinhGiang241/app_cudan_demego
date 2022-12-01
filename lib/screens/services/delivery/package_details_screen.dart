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
import '../../../widgets/primary_info_widget.dart';
import '../../../widgets/primary_screen.dart';
import '../../../widgets/timeline_view.dart';

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
    final arg = ModalRoute.of(context)!.settings.arguments as Delivery;

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
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: PrimaryInfoWidget(
                    label: S.of(context).delivery_info,
                    listInfoView: [
                      InfoContentView(
                        isHorizontal: true,
                        title: S.of(context).transfer_type,
                        content: arg.type_transfer == "IN"
                            ? S.of(context).tranfer_in
                            : S.of(context).tranfer_out,
                      ),
                      InfoContentView(
                        isHorizontal: true,
                        title: S.of(context).start_time,
                        content:
                            '${(arg.start_hour != null ? "${arg.start_hour!.substring(0, 5)} " : "")}${Utils.dateFormat(arg.end_time ?? "", 0)}',
                      ),
                      InfoContentView(
                        isHorizontal: true,
                        title: S.of(context).end_time,
                        content:
                            '${(arg.end_hour != null ? "${arg.end_hour!.substring(0, 5)} " : "")}${Utils.dateFormat(arg.end_time ?? "", 0)}',
                      ),
                      InfoContentView(
                        isHorizontal: true,
                        title: S.of(context).card_num,
                        content: arg.code,
                        contentStyle: txtBold(16, purpleColorBase),
                      ),
                      if (arg.describe != null)
                        InfoContentView(
                          isHorizontal: true,
                          title: S.of(context).description,
                          content: arg.describe,
                          contentStyle: txtBold(16, purpleColorBase),
                        ),
                      InfoContentView(
                          isHorizontal: true,
                          title: S.of(context).letter_status,
                          content: genStatus(arg.status ?? ''),
                          contentStyle: genContentStyle(arg.status ?? "")),
                      if (arg.image!.isNotEmpty)
                        InfoContentView(
                            title: S.of(context).photos,
                            images: arg.image!.isEmpty
                                ? null
                                : [
                                    ...arg.image!.map((v) =>
                                        "${ApiConstants.uploadURL}/?load=${v.id}")
                                  ])
                    ],
                  ),
                ),
                vpad(24),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 12,
                  ),
                  child: Text(
                    S.of(context).package,
                    style: txtMedium(14, grayScaleColor2),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Column(
                    children: [
                      ...arg.item_added_list!.map((e) => Column(
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
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 22.0,
                        height: 22.0,
                        child: Checkbox(
                          fillColor:
                              MaterialStateProperty.all(primaryColorBase),
                          value: arg.help_check,
                          onChanged: (v) {},
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text(S.of(context).need_support,
                            style:
                                txtBodySmallRegular(color: grayScaleColorBase)),
                      )
                    ],
                  ),
                ),
                vpad(bottomSafePad(context) + 24)
              ],
            ),
            ListView(
              children: [
                vpad(24),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: TimeLineView(),
                )
              ],
            )
          ],
        ));
  }
}
