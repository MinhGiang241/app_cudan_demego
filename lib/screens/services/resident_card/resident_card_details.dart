// ignore_for_file: unused_local_variable, unused_import

import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/info_content_view.dart';
import '../../../models/letter_history.dart';
import '../../../models/manage_card.dart';
import '../../../services/api_service.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_info_widget.dart';
import '../../../widgets/primary_screen.dart';

class ResidentCardDetails extends StatefulWidget {
  const ResidentCardDetails({super.key});
  static const routeName = '/residence-card/details';

  @override
  State<ResidentCardDetails> createState() => _ResidentCardDetailsState();
}

class _ResidentCardDetailsState extends State<ResidentCardDetails>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);
  List<CardHistory> historyList = [];
  @override
  Widget build(BuildContext context) {
    final arg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var card = arg['card'] as ManageCard;
    var cancel = arg['lockCard'];
    return PrimaryScreen(
      appBar: PrimaryAppbar(
        title: S.of(context).res_card_details,
        // tabController: tabController,
        // isTabScrollabel: false,
        // tabs: [
        //   Tab(text: S.of(context).details),
        //   Tab(text: S.of(context).history),
        // ],
      ),
      body:
          //  TabBarView(
          //   controller: tabController,
          //   children: [
          ListView(
        children: [
          vpad(24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: PrimaryInfoWidget(
              listInfoView: [
                InfoContentView(
                  isHorizontal: true,
                  title: S.of(context).card_num,
                  content: card.as?.serial,
                  contentStyle: txtBold(16, purpleColorBase),
                ),
                InfoContentView(
                  isHorizontal: true,
                  title: S.of(context).full_name,
                  content: card.re?.info_name ?? '',
                  contentStyle: txtBold(16),
                ),
                InfoContentView(
                  isHorizontal: true,
                  title: S.of(context).address,
                  content:
                      '${card.a?.name ?? ""} - ${card.a?.f?.name ?? ''} - ${card.a?.b?.name ?? ''}',
                  contentStyle: txtBold(14),
                ),
                InfoContentView(
                  isHorizontal: true,
                  title: S.of(context).phone_num,
                  content: card.re?.phone_required ?? card.re?.phone,
                ),
                InfoContentView(
                  isHorizontal: true,
                  title: S.of(context).reg_letter_num,
                  content: card.res_card?.code ?? '',
                  contentStyle: txtBold(16, purpleColorBase),
                ),
                InfoContentView(
                  isHorizontal: true,
                  title: S.of(context).reg_date,
                  content: Utils.dateFormat(
                    card.res_card?.createdTime ?? "",
                    1,
                  ),
                ),
                InfoContentView(
                  isHorizontal: true,
                  title: S.of(context).card_status,
                  content: card.s?.name ?? '',
                  contentStyle: genContentStyle(card.status ?? ""),
                ),
                if (card.r != null)
                  InfoContentView(
                    isHorizontal: true,
                    title: S.of(context).lock_reason,
                    content: card.r?.name != null ? card.r?.name ?? "" : '',
                  ),
                if (card.note_reason != null)
                  InfoContentView(
                    isHorizontal: true,
                    title: S.of(context).note,
                    content: card.note_reason ?? "",
                  ),
                if (card.identity_image != null &&
                    card.identity_image!.isNotEmpty)
                  InfoContentView(
                    title: S.of(context).cmnd_photos,
                    images: [
                      ...card.identity_image!.map(
                        (e) =>
                            "${ApiService.shared.uploadURL}?load=${e.id}&regcode=${ApiService.shared.regCode}",
                      ),
                    ],
                  ),
                if (card.resident_image != null &&
                    card.resident_image!.isNotEmpty)
                  InfoContentView(
                    title: S.of(context).res_photo,
                    images: [
                      ...card.resident_image!.map(
                        (e) =>
                            "${ApiService.shared.uploadURL}?load=${e.id}&regcode=${ApiService.shared.regCode}",
                      ),
                    ],
                  ),
                if (card.other_image != null && card.other_image!.isNotEmpty)
                  InfoContentView(
                    title: S.of(context).related_photo,
                    images: [
                      ...card.other_image!.map(
                        (e) =>
                            "${ApiService.shared.uploadURL}?load=${e.id}&regcode=${ApiService.shared.regCode}",
                      ),
                    ],
                  ),
              ],
            ),
          ),
          // if (!(card.status == "DESTROY" && card.r?.code == 'NGUOIDUNGKHOA') &&
          //         card.status != "LOST"
          //     )
          //   vpad(24),
          // if (!(card.status == "DESTROY" && card.r?.code == 'NGUOIDUNGKHOA') &&
          //         card.status != "LOST"
          //     )
          //   PrimaryButton(
          //     width: double.infinity,
          //     text: S.of(context).cancel_card,
          //     buttonType: ButtonType.red,
          //     onTap: () {
          //       cancel(context, card);
          //     },
          //   ),
          vpad(kBottomNavigationBarHeight),
        ],
      ),
    );
  }
}
