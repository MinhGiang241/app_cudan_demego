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
        ModalRoute.of(context)!.settings.arguments as TransportationCard;
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
                            title: S.of(context).full_name,
                            content: context
                                        .read<ResidentInfoPrv>()
                                        .userInfo!
                                        .info_name !=
                                    null
                                ? context
                                    .read<ResidentInfoPrv>()
                                    .userInfo!
                                    .info_name!
                                    .toUpperCase()
                                : '',
                            contentStyle: txtBold(16, primaryColor1)),
                        InfoContentView(
                            title: S.of(context).email,
                            content: context
                                        .read<ResidentInfoPrv>()
                                        .userInfo!
                                        .email !=
                                    null
                                ? context
                                    .read<ResidentInfoPrv>()
                                    .userInfo!
                                    .email!
                                : '',
                            contentStyle: txtBold(14)),
                        InfoContentView(
                          title:
                              // ignore: unnecessary_string_interpolations
                              S.of(context).phone_num,
                          content: context
                                      .read<ResidentInfoPrv>()
                                      .userInfo!
                                      .phone !=
                                  null
                              ? context.read<ResidentInfoPrv>().userInfo!.phone!
                              : '',
                        ),
                        InfoContentView(
                            title: S.of(context).expired,
                            content: Utils.dateFormat(
                                '2022-10-28T03:35:33.057+0000')),
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
                          title: S.of(context).trans_type,
                          content: arg.vehicleType!.name ?? "",
                        ),
                        InfoContentView(
                          title: S.of(context).licene_plate,
                          content: arg.number_plate,
                        ),
                        InfoContentView(
                          title: S.of(context).reg_num,
                          content: arg.registration_number,
                        ),
                        if (arg.registration_image_front != null ||
                            arg.registration_image_back != null)
                          InfoContentView(title: S.of(context).photos, images: [
                            if (arg.registration_image_front != null)
                              "${ApiConstants.uploadURL}?load=${arg.registration_image_front}",
                            if (arg.registration_image_back != null)
                              "${ApiConstants.uploadURL}?load=${arg.registration_image_back}",
                            if (arg.other_image != null)
                              ...arg.other_image!.map(
                                (e) => "${ApiConstants.uploadURL}?load=${e.id}",
                              )
                          ]),
                        InfoContentView(
                            title: S.of(context).card_num,
                            content: arg.code!.toUpperCase(),
                            contentStyle: txtBold(16, purpleColorBase)),
                        InfoContentView(
                            title: S.of(context).letter_status,
                            content: genStatus(arg.ticket_status ?? ''),
                            contentStyle:
                                genContentStyle(arg.ticket_status ?? "")),
                        InfoContentView(
                          title: S.of(context).card_status,
                          content: genStatus(arg.card_status ?? ''),
                          contentStyle: genContentStyle(arg.card_status ?? ""),
                        ),
                        if (arg.ticket_status == "CANCEL")
                          InfoContentView(
                            title: S.of(context).reject_reason,
                            content: "Chưa khớp thông tin",
                          ),
                        if (arg.ticket_status == "CANCEL")
                          InfoContentView(
                            title: S.of(context).note,
                            content: "Thông tin CMND không trùng khớp",
                          ),
                      ]),
                ),
                vpad(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (arg.ticket_status == "APPROVED")
                      PrimaryButton(
                        width: 150,
                        text: S.of(context).missing_report,
                        buttonType: ButtonType.secondary,
                        textColor: primaryColorBase,
                        secondaryBackgroundColor: primaryColor5,
                        onTap: () {},
                      ),
                    if (arg.ticket_status == "APPROVED")
                      PrimaryButton(
                        width: 150,
                        text: S.of(context).lock_card,
                        buttonType: ButtonType.secondary,
                        textColor: redColorBase,
                        secondaryBackgroundColor: redColor5,
                        onTap: () {},
                      )
                  ],
                ),
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
