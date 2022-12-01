import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../../constants/api_constant.dart';
import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/info_content_view.dart';
import '../../../models/transportation_card.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_info_widget.dart';
import '../../../widgets/primary_screen.dart';
import '../../../widgets/timeline_view.dart';
import 'tabs/trans_letter_list_tabs.dart';

class TransportationCardDetails extends StatefulWidget {
  const TransportationCardDetails({super.key});
  static const routeName = '/transportation-card/details';

  @override
  State<TransportationCardDetails> createState() =>
      _TransportationCardDetailsState();
}

class _TransportationCardDetailsState extends State<TransportationCardDetails>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);
  @override
  Widget build(BuildContext context) {
    final arg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    var card = arg['card'] as TransportationCard;
    var lockCard = arg['lockCard'];
    return PrimaryScreen(
        appBar: PrimaryAppbar(
          title: S.of(context).trans_card_details,
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
                      label: S.of(context).resident_info,
                      listInfoView: [
                        InfoContentView(
                            isHorizontal: true,
                            title: S.of(context).full_name,
                            content: context
                                        .watch<ResidentInfoPrv>()
                                        .userInfo!
                                        .info_name !=
                                    null
                                ? context
                                    .watch<ResidentInfoPrv>()
                                    .userInfo!
                                    .info_name!
                                    .toUpperCase()
                                : '',
                            contentStyle: txtBold(16, primaryColor1)),
                        InfoContentView(
                            isHorizontal: true,
                            title: S.of(context).email,
                            content: context
                                        .watch<ResidentInfoPrv>()
                                        .userInfo!
                                        .email !=
                                    null
                                ? context
                                    .watch<ResidentInfoPrv>()
                                    .userInfo!
                                    .email!
                                : '',
                            contentStyle: txtBold(14)),
                        InfoContentView(
                          isHorizontal: true,
                          title:
                              // ignore: unnecessary_string_interpolations
                              S.of(context).phone_num,
                          content: context
                                      .watch<ResidentInfoPrv>()
                                      .userInfo!
                                      .phone_required !=
                                  null
                              ? context
                                  .watch<ResidentInfoPrv>()
                                  .userInfo!
                                  .phone_required!
                              : '',
                        ),
                        InfoContentView(
                            isHorizontal: true,
                            title: S.of(context).expired,
                            content: Utils.dateFormat(
                                '2022-10-28T03:35:33.057+0000', 0)),
                        // InfoContentView(
                        //     title: S.of(context).status,
                        //     content: "widget.item.ai?.text!",
                        //     contentStyle: txtSemiBold(14, greenColorBase)),
                      ]),
                ),
                vpad(16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: PrimaryInfoWidget(
                      label: S.of(context).trans_info,
                      listInfoView: [
                        InfoContentView(
                          isHorizontal: true,
                          title: S.of(context).trans_type,
                          content: card.vehicleType!.name,
                        ),
                        if (card.type != 'BICYCLE')
                          InfoContentView(
                            isHorizontal: true,
                            title: S.of(context).licene_plate,
                            content: card.number_plate,
                          ),
                        if (card.type != 'BICYCLE')
                          InfoContentView(
                            isHorizontal: true,
                            title: S.of(context).reg_num,
                            content: card.registration_number,
                          ),
                        if (card.registration_image_front != null ||
                            card.registration_image_back != null ||
                            card.other_image != null)
                          InfoContentView(title: S.of(context).photos, images: [
                            if (card.registration_image_front != null)
                              "${ApiConstants.uploadURL}?load=${card.registration_image_front}",
                            if (card.registration_image_back != null)
                              "${ApiConstants.uploadURL}?load=${card.registration_image_back}",
                            if (card.other_image != null)
                              ...card.other_image!.map(
                                (e) => "${ApiConstants.uploadURL}?load=${e.id}",
                              )
                          ]),
                        InfoContentView(
                            title: S.of(context).card_num,
                            content: card.code!.toUpperCase(),
                            contentStyle: txtBold(16, purpleColorBase)),
                        InfoContentView(
                            title: S.of(context).letter_status,
                            content: genStatus(card.ticket_status ?? ''),
                            contentStyle:
                                genContentStyle(card.ticket_status ?? "")),
                        if (card.card_status != null)
                          InfoContentView(
                            title: S.of(context).card_status,
                            content: genStatus(card.card_status ?? ''),
                            contentStyle:
                                genContentStyle(card.card_status ?? ""),
                          ),
                        if (card.ticket_status == "CANCEL")
                          InfoContentView(
                            title: S.of(context).reject_reason,
                            content: card.cancel_reason != null
                                ? card.cancel_reason!.name ?? ""
                                : '',
                          ),
                        if (card.ticket_status == "CANCEL")
                          InfoContentView(
                            title: S.of(context).note,
                            content: card.note_reason ?? "",
                          ),
                      ]),
                ),
                // vpad(24),
                // if (card.card_status == "ACTIVE")
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: [
                //       if (card.ticket_status == "APPROVED")
                //         PrimaryButton(
                //           width: 150,
                //           text: S.of(context).missing_report,
                //           buttonType: ButtonType.secondary,
                //           textColor: primaryColorBase,
                //           secondaryBackgroundColor: primaryColor5,
                //           onTap: () {},
                //         ),
                //       if (card.ticket_status == "APPROVED")
                //         PrimaryButton(
                //           width: 150,
                //           text: S.of(context).lock_card,
                //           buttonType: ButtonType.secondary,
                //           textColor: redColorBase,
                //           secondaryBackgroundColor: redColor5,
                //           onTap: () {
                //             lockCard();
                //           },
                //         )
                //     ],
                //   ),
                vpad(kBottomNavigationBarHeight),
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
