import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../../constants/api_constant.dart';
import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/info_content_view.dart';
import '../../../models/resident_card.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_info_widget.dart';
import '../../../widgets/primary_screen.dart';
import '../../../widgets/timeline_view.dart';
import '../../auth/prv/resident_info_prv.dart';

class ResidentCardDetails extends StatefulWidget {
  const ResidentCardDetails({super.key});
  static const routeName = '/residence-card/details';

  @override
  State<ResidentCardDetails> createState() => _ResidentCardDetailsState();
}

class _ResidentCardDetailsState extends State<ResidentCardDetails>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as ResidentCard;
    return PrimaryScreen(
        appBar: PrimaryAppbar(
          title: S.of(context).res_card_details,
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
                              ? context.read<ResidentInfoPrv>().userInfo!.email!
                              : '',
                          contentStyle: txtBold(14)),
                      InfoContentView(
                        title:
                            // ignore: unnecessary_string_interpolations
                            S.of(context).phone_num,
                        content: context
                                    .read<ResidentInfoPrv>()
                                    .userInfo!
                                    .phone_required !=
                                null
                            ? context
                                .read<ResidentInfoPrv>()
                                .userInfo!
                                .phone_required!
                            : '',
                      ),
                      InfoContentView(
                          title: S.of(context).expired,
                          content:
                              Utils.dateFormat('2022-10-28T03:35:33.057+0000')),
                      if (arg.identity_image_front != null ||
                          arg.identity_image_back != null ||
                          arg.other_image != null)
                        InfoContentView(title: S.of(context).photos, images: [
                          if (arg.identity_image_front != null)
                            "${ApiConstants.uploadURL}?load=${arg.identity_image_front}",
                          if (arg.identity_image_back != null)
                            "${ApiConstants.uploadURL}?load=${arg.identity_image_back}",
                          if (arg.other_image != null)
                            "${ApiConstants.uploadURL}?load=${arg.other_image}",
                          // if (arg.other_image != null)
                          //   ...arg.other_image!.map(
                          //     (e) => "${ApiConstants.uploadURL}?load=${e.id}",
                          //   )
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
                          content: arg.cancel_reason != null
                              ? arg.cancel_reason!.name ?? ""
                              : '',
                        ),
                      if (arg.ticket_status == "CANCEL")
                        InfoContentView(
                          title: S.of(context).note,
                          content: arg.note_reason,
                        ),
                    ],
                  ),
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
