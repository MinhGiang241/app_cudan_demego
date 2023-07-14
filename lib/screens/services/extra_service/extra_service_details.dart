import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/info_content_view.dart';
import '../../../models/letter_history.dart';
import '../../../models/service_registration.dart';
import '../../../models/timeline_model.dart';
import '../../../services/api_history.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_info_widget.dart';
import '../../../widgets/primary_screen.dart';
import '../../../widgets/timeline_view.dart';

class ExtraServiceDetailsScreen extends StatefulWidget {
  const ExtraServiceDetailsScreen({super.key});
  static const routeName = '/extra-service/details';

  @override
  State<ExtraServiceDetailsScreen> createState() =>
      _ExtraServiceDetailsScreenState();
}

class _ExtraServiceDetailsScreenState extends State<ExtraServiceDetailsScreen>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);
  List<LetterHistory> historyList = [];
  @override
  Widget build(BuildContext context) {
    final arg =
        ModalRoute.of(context)!.settings.arguments as ServiceRegistration;
    var isRes = context.read<ResidentInfoPrv>().residentId != null &&
        context.read<ResidentInfoPrv>().selectedApartment != null;
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
                  listInfoView: [
                    InfoContentView(
                      title: S.of(context).reg_code,
                      content: arg.code,
                      contentStyle: txtBold(16, primaryColor1),
                    ),
                    InfoContentView(
                      title: S.of(context).full_name,
                      content: isRes
                          ? arg.resident?.info_name ?? ""
                          : arg.customer_name,
                      contentStyle: txtBold(16, grayScaleColorBase),
                    ),
                    if (!isRes)
                      InfoContentView(
                        title: S.of(context).address,
                        content: arg.customer_address != null
                            ? arg.customer_address
                            : '',
                        contentStyle: txtBold(14, grayScaleColorBase),
                      ),
                    if (isRes)
                      InfoContentView(
                        title: S.of(context).apartment,
                        content: arg.apartment != null
                            ? "${arg.apartment!.name ?? ""} - ${arg.floor!.name ?? ""} - ${arg.building!.name ?? ""}"
                            : '',
                        contentStyle: txtBold(14, grayScaleColorBase),
                      ),
                    InfoContentView(
                      title: S.of(context).phone_num,
                      content: arg.phoneNumber,
                      contentStyle: txtBold(14, grayScaleColorBase),
                    ),
                    if (arg.pay != null)
                      InfoContentView(
                        title: S.of(context).payment_circle,
                        content: arg.pay != null
                            ? "${arg.pay!.use_time != null ? "${arg.pay!.use_time} " : ""}${arg.pay!.type_time}"
                            : "",
                        contentStyle: txtBold(14, grayScaleColorBase),
                      ),
                    InfoContentView(
                      title: (arg.pay != null && arg.pay!.code != "KHONGCO")
                          ? "${S.of(context).reg_date} - ${S.of(context).expired_date}"
                          : S.of(context).reg_date,
                      content: (arg.pay != null && arg.pay!.code != "KHONGCO")
                          ? "${Utils.dateFormat(arg.registration_date ?? "", 1)} - ${Utils.dateFormat(arg.expiration_date ?? "", 1)}"
                          : Utils.dateFormat(arg.registration_date ?? "", 1),
                      contentStyle: txtBold(14, grayScaleColorBase),
                    ),
                    if (arg.status == "APPROVED")
                      InfoContentView(
                        title: S.of(context).note,
                        content: arg.note ?? "",
                        contentStyle: txtBold(14, grayScaleColorBase),
                      ),
                    InfoContentView(
                      title: S.of(context).status,
                      content: genStatus(arg.status ?? ""),
                      contentStyle:
                          txtBold(14, genStatusColor(arg.status ?? "")),
                    ),
                    if (arg.status == "CANCEL")
                      if (arg.cancel_reasons != null)
                        InfoContentView(
                          title: S.of(context).cancel_reason,
                          content: arg.cancel_reasons!.name ?? "",
                          contentStyle: txtBold(14, grayScaleColorBase),
                        ),
                  ],
                ),
              )
            ],
          ),
          FutureBuilder(
            future: () async {
              APIHistory.getHistoryLetter(arg.id, 'serviceregistration')
                  .then((v) {
                if (v != null) {
                  historyList.clear();
                  for (var i in v) {
                    historyList.add(LetterHistory.fromMap(i));
                  }
                }
                historyList.sort(
                  (a, b) => a.perform_date!.compareTo(b.perform_date ?? ""),
                );
                if (mounted) {
                  setState(() {});
                }
              });
            }(),
            builder: (context, snapshot) {
              return ListView(
                children: [
                  vpad(24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TimeLineView(
                      content: historyList
                          .map(
                            (i) => TimelineModel(
                              date: i.perform_date,
                              title: i.content,
                              subTitle: i.new_status != null
                                  ? '${S.of(context).status}: ${i.ns?.name}'
                                  : null,
                              color: i.new_status != null
                                  ? genStatusColor(i.new_status ?? "")
                                  : null,
                            ),
                          )
                          .toList(),
                    ),
                  )
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
