import 'package:app_cudan/models/letter_history.dart';
import 'package:app_cudan/services/api_history.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/info_content_view.dart';
import '../../../models/timeline_model.dart';
import '../../../models/transportation_card.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_card.dart';
import '../../../widgets/primary_icon.dart';
import '../../../widgets/primary_info_widget.dart';
import '../../../widgets/primary_screen.dart';
import '../../../widgets/timeline_view.dart';
import '../../auth/prv/resident_info_prv.dart';
import 'add_new_transport_card.dart';
import 'transport_details_letter_screen.dart';

class TransportLetterDetailsScreen extends StatefulWidget {
  const TransportLetterDetailsScreen({super.key});
  static const routeName = '/transport/details-letter';

  @override
  State<TransportLetterDetailsScreen> createState() =>
      _TransportLetterDetailsScreenState();
}

class _TransportLetterDetailsScreenState
    extends State<TransportLetterDetailsScreen> with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);
  List<LetterHistory> historyList = [];

  @override
  Widget build(BuildContext context) {
    final arg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    var card = arg['card'] as TransportCard;
    var sendRequest = arg['sendRequest'] as Function;
    var cancel = arg['cancel'] as Function;
    return PrimaryScreen(
      appBar: PrimaryAppbar(
        title: S.of(context).trans_reg_card_details,
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
                  // label: S.of(context).resident_info,
                  listInfoView: [
                    InfoContentView(
                      isHorizontal: true,
                      title: S.of(context).letter_num,
                      content: card.code,
                      contentStyle: txtBold(16, purpleColorBase),
                    ),
                    InfoContentView(
                      isHorizontal: true,
                      title: S.of(context).full_name,
                      content: card.name_resident ??
                          card.name ??
                          card.re?.info_name ??
                          context.read<ResidentInfoPrv>().userInfo?.info_name ??
                          context
                              .read<ResidentInfoPrv>()
                              .userInfo
                              ?.account
                              ?.fullName ??
                          "",
                      contentStyle: txtBold(14),
                    ),
                    // if (card.card_type != 'CUSTOMER')
                    InfoContentView(
                      isHorizontal: true,
                      title: S.of(context).address,
                      content: card.address ??
                          ("${context.read<ResidentInfoPrv>().selectedApartment?.apartment?.name ?? ""} - ${context.read<ResidentInfoPrv>().selectedApartment?.floor?.name ?? ""} - ${context.read<ResidentInfoPrv>().selectedApartment?.building?.name ?? ""}"),
                    ),

                    // InfoContentView(
                    //   isHorizontal: true,
                    //   title: S.of(context).address,
                    //   content: card.address,
                    // ),
                    InfoContentView(
                      isHorizontal: true,
                      title: S.of(context).cmnd,
                      content: card.identity,
                    ),
                    InfoContentView(
                      isHorizontal: true,
                      title: S.of(context).phone_num,
                      content:
                          card.phone_number ?? card.re?.phone_required ?? "",
                    ),
                    InfoContentView(
                      isHorizontal: true,
                      title: S.of(context).reg_date,
                      content: Utils.dateFormat(
                        card.registration_date ?? "",
                        1,
                      ),
                    ),
                    InfoContentView(
                      isHorizontal: true,
                      title: S.of(context).letter_status,
                      content: card.s?.name ?? "",
                      contentStyle: genContentStyle(card.ticket_status ?? ""),
                    ),
                    if (card.reasons != null)
                      InfoContentView(
                        isHorizontal: true,
                        title: S.of(context).cancel_reason,
                        content: card.r?.name ?? "",
                      ),
                    if (card.note_reason != null)
                      InfoContentView(
                        isHorizontal: true,
                        title: S.of(context).note,
                        content: card.note_reason,
                      ),
                  ],
                ),
              ),
              vpad(16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    S.of(context).list_transport,
                    style: txtBodySmallRegular(color: grayScaleColorBase),
                  ),
                ),
              ),
              vpad(16),
              ...(card.transports_list ?? []).asMap().entries.map((e) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 12),
                  child: PrimaryCard(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        TransportDetailsLetterScreen.routeName,
                        arguments: {"item": e.value},
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 16,
                      ),
                      child: Row(
                        children: [
                          PrimaryIcon(
                            icons: genTransIcon(e.value.vehicleType?.code),
                            style: PrimaryIconStyle.gradient,
                            gradients: PrimaryIconGradient.yellow,
                            size: 32,
                            padding: const EdgeInsets.all(12),
                            color: Colors.white,
                          ),
                          hpad(16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${S.of(context).transport}: ${e.value.vehicleType?.name}',
                                  style: txtLinkSmall(),
                                ),
                                vpad(2),
                                if (e.value.vehicleType?.code != "BICYCLE")
                                  Text(
                                    '${S.of(context).licene_plate}: ${e.value.number_plate}',
                                    style: txtBodyXSmallRegular(),
                                  ),
                                if (e.value.vehicleType?.code != "BICYCLE")
                                  vpad(2),
                                if (e.value.vehicleType?.code != "BICYCLE")
                                  Text(
                                    "${S.of(context).reg_num}: ${e.value.registration_number ?? ""}",
                                    style: txtBodyXSmallRegular(),
                                  ),
                                if (e.value.vehicleType?.code != "BICYCLE")
                                  vpad(2),
                                if (e.value.vehicleType?.code != "BICYCLE")
                                  Text(
                                    "${S.of(context).num_seat}: ${e.value.seats ?? ""}",
                                    style: txtBodyXSmallRegular(),
                                  ),
                                // vpad(2),
                                // Text(
                                //   "${S.of(context).expired_date}: ${Utils.dateFormat(e.value.expire_date ?? "", 1)}",
                                //   style: txtBodyXSmallRegular(),
                                // ),
                                vpad(2),
                                Text(
                                  "${S.of(context).shelflife_money}: ${e.value.shelfLife?.use_time} ${genShelifeString(e.value.shelfLife?.type_time)}",
                                  style: txtBodyXSmallRegular(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
              vpad(16),
              Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      activeColor: primaryColorBase,
                      value: card.integrated,
                      onChanged: (v) {},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        S.of(context).intergrate_existed_resident_card,
                        style: txtRegular(14, grayScaleColorBase),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                ],
              ),
              if (card.ticket_status == "WAIT") vpad(30),
              if (card.ticket_status == "WAIT")
                PrimaryButton(
                  isLoading: false,
                  buttonSize: ButtonSize.medium,
                  buttonType: ButtonType.red,
                  text: S.of(context).reg_cancel,
                  onTap: () {
                    cancel(context, card);
                  },
                ),
              if (card.ticket_status == "NEW") vpad(30),
              if (card.ticket_status == "NEW")
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    PrimaryButton(
                      buttonType: ButtonType.orange,
                      isLoading: false,
                      buttonSize: ButtonSize.medium,
                      text: S.of(context).edit,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AddNewTransportCardScreen.routeName,
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
                        sendRequest(context, card);
                      },
                    ),
                  ],
                ),
              vpad(kBottomNavigationBarHeight),
            ],
          ),
          FutureBuilder(
            future: () async {
              APIHistory.getHistoryLetter(card.id, 'transportcard').then((v) {
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
            builder: (context, snpshot) {
              return ListView(
                children: [
                  vpad(24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TimeLineView(
                      content: historyList
                          .map(
                            (i) => TimelineModel(
                              color: i.new_status != null
                                  ? genStatusColor(i.new_status ?? "")
                                  : null,
                              date: i.perform_date,
                              title: i.content,
                              subTitle: i.new_status != null
                                  ? '${S.of(context).status}: ${i.ns?.name}'
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
