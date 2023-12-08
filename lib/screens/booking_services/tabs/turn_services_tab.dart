import 'package:app_cudan/models/info_content_view.dart';
import 'package:app_cudan/screens/booking_services/prv/history_register_service_prv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_card.dart';
import '../../../widgets/primary_empty_widget.dart';
import '../../../widgets/primary_error_widget.dart';
import '../../../widgets/primary_icon.dart';
import '../../../widgets/primary_loading.dart';
import '../confirm_booking_service.dart';

class TurnServicesTab extends StatefulWidget {
  const TurnServicesTab({super.key});

  @override
  State<TurnServicesTab> createState() => _TurnServicesTabState();
}

class _TurnServicesTabState extends State<TurnServicesTab> {
  @override
  Widget build(BuildContext context) {
    var _refreshController =
        context.read<HistoryRegisterServicePrv>().turnRefreshController;
    var _emptyController =
        context.read<HistoryRegisterServicePrv>().emptyTurnRefreshController;
    return FutureBuilder(
      future: context
          .read<HistoryRegisterServicePrv>()
          .getRegisterServiceList('turn', context),
      builder: (context, snapshot) {
        var list = context.watch<HistoryRegisterServicePrv>().turnList;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: PrimaryLoading());
        } else if (snapshot.connectionState == ConnectionState.none) {
          return PrimaryErrorWidget(
            code: snapshot.hasError ? 'err' : '1',
            message: snapshot.data.toString(),
            onRetry: () async {
              setState(() {});
            },
          );
        } else if (list.isEmpty) {
          return SafeArea(
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              header: WaterDropMaterialHeader(
                backgroundColor: Theme.of(context).primaryColor,
              ),
              controller: _emptyController,
              onRefresh: () {
                setState(() {});
                _emptyController.refreshCompleted();
              },
              child: PrimaryEmptyWidget(
                emptyText: S.of(context).no_reg,
                icons: PrimaryIcons.news,
                action: () {},
              ),
            ),
          );
        }

        return SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          header: WaterDropMaterialHeader(
            backgroundColor: Theme.of(context).primaryColor,
          ),
          controller: _refreshController,
          onRefresh: () {
            setState(() {});
            _refreshController.refreshCompleted();
          },
          child: ListView(
            children: [
              vpad(12),
              ...list.map(
                (e) {
                  var listInfoContent = [
                    InfoContentView(
                      title: S.of(context).zone,
                      content: e.a?.name,
                    ),
                    InfoContentView(
                      title: S.of(context).time,
                      content:
                          '${Utils.dateFormat(e.use_date ?? '', 0)} - ${e.time_slot}',
                    ),
                    // InfoContentView(
                    //   title: S.of(context).expired_reg,
                    //   content:
                    //       '${e.sh?.use_time} ${genShelifeString(e.sh?.type_time)}',
                    // ),
                  ];
                  return PrimaryCard(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        ConfirmBookingService.routeName,
                        arguments: {
                          'register': e,
                          'service': e.se,
                          'time-start': e.time_slot?.split('-')[0].trim(),
                          'time-end': e.time_slot?.split('-')[1].trim(),
                          'mode': (e.status == "CANCEL") ? 2 : 1,
                          'area': e.a,
                          'date': e.use_date,
                          'type': 'turn',
                          'num': 1,
                          // "guest-cfg": configGuest,
                          // 'resident-cfg': configResident,
                        },
                      );
                    },
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    margin: EdgeInsets.only(bottom: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: genBookingStatusColor(e.status),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(12),
                                bottomLeft: Radius.circular(8),
                              ),
                            ),
                            child: Text(
                              genBookingStatus(e.status),
                              style: txtSemiBold(12, Colors.white),
                            ),
                          ),
                        ),
                        vpad(6),
                        Text(
                          e.se?.name ?? "",
                          style: txtRegular(12, primaryColorBase),
                        ),
                        vpad(3),
                        Text(
                          '${S.of(context).reg_code}: ${e.code}',
                          style: txtRegular(11),
                        ),
                        vpad(6),
                        ...listInfoContent.map(
                          (v) => Padding(
                            padding: EdgeInsets.only(bottom: 6),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${v.title} :',
                                    style: txtRegular(12),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    v.content ?? '',
                                    style: txtRegular(12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                '${S.of(context).created_time}: ${Utils.dateTimeFormat((e.createdTime ?? ''), 1)}',
                                style: txtRegular(11, grayScaleColor3),
                              ),
                            ),
                            hpad(3),
                            Expanded(
                              flex: 1,
                              child: Text(
                                '${(e.se?.service_charge == 'nocharge' || e.rec == null || e.rec!.isEmpty) ? S.of(context).free : genStatus(e.rec?[0].payment_status ?? "")}',
                                style: txtBold(
                                  12,
                                  (e.se?.service_charge == 'nocharge' ||
                                          e.rec == null ||
                                          e.rec!.isEmpty)
                                      ? greenColor8
                                      : primaryColorBase,
                                ),
                              ),
                            ),
                          ],
                        ),
                        vpad(12),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
