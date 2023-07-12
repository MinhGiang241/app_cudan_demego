import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../../constants/api_constant.dart';
import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/info_content_view.dart';
import '../../../models/letter_history.dart';
import '../../../models/resident_card.dart';
import '../../../models/timeline_model.dart';
import '../../../services/api_history.dart';
import '../../../services/api_service.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_info_widget.dart';
import '../../../widgets/primary_screen.dart';
import '../../../widgets/timeline_view.dart';
import '../../auth/prv/resident_info_prv.dart';
import 'register_resident_card.dart';

class ResidentLetterDetails extends StatefulWidget {
  const ResidentLetterDetails({super.key});
  static const routeName = '/residence/letter-details';

  @override
  State<ResidentLetterDetails> createState() => _ResidentLetterDetailsState();
}

class _ResidentLetterDetailsState extends State<ResidentLetterDetails>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);
  List<LetterHistory> historyList = [];
  @override
  Widget build(BuildContext context) {
    final arg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var card = arg['card'] as ResidentCard;
    Function lockCard = arg['cancel'] as Function;
    Function send = arg['send'] as Function;
    return PrimaryScreen(
      appBar: PrimaryAppbar(
        title: S.of(context).resident_letter_details,
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
                      content: card.resident?.info_name ?? '',
                      contentStyle: txtBold(16),
                    ),
                    InfoContentView(
                      isHorizontal: true,
                      title: S.of(context).address,
                      content:
                          '${card.apartment?.name ?? ""} - ${card.apartment?.f?.name ?? ''} - ${card.apartment?.b?.name}',
                      contentStyle: txtBold(14),
                    ),
                    InfoContentView(
                      isHorizontal: true,
                      title: S.of(context).phone_num,
                      content:
                          card.resident?.phone_required ?? card.resident?.phone,
                    ),
                    InfoContentView(
                      isHorizontal: true,
                      title: S.of(context).reg_date,
                      content: Utils.dateFormat(
                        card.createdTime ?? "",
                        1,
                      ),
                    ),
                    InfoContentView(
                      isHorizontal: true,
                      title: S.of(context).letter_status,
                      content: card.s?.name ?? '',
                      contentStyle: genContentStyle(card.ticket_status ?? ""),
                    ),
                    if (card.r != null)
                      InfoContentView(
                        isHorizontal: true,
                        title: S.of(context).reject_reason,
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
                                "${ApiService.shared.uploadURL}?load=${e.id}",
                          )
                        ],
                      ),
                    if (card.resident_image != null &&
                        card.resident_image!.isNotEmpty)
                      InfoContentView(
                        title: S.of(context).res_photo,
                        images: [
                          ...card.resident_image!.map(
                            (e) =>
                                "${ApiService.shared.uploadURL}?load=${e.id}",
                          )
                        ],
                      ),
                    if (card.other_image != null &&
                        card.other_image!.isNotEmpty)
                      InfoContentView(
                        title: S.of(context).related_photo,
                        images: [
                          ...card.other_image!.map(
                            (e) =>
                                "${ApiService.shared.uploadURL}?load=${e.id}",
                          )
                        ],
                      ),
                  ],
                ),
              ),
              vpad(24),
              if (card.ticket_status == "NEW")
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    PrimaryButton(
                      text: S.of(context).edit,
                      buttonType: ButtonType.orange,
                      buttonSize: ButtonSize.medium,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RegisterResidentCard.routeName,
                          arguments: {"isEdit": true, "data": card},
                        );
                      },
                    ),
                    PrimaryButton(
                      text: S.of(context).send_request,
                      buttonType: ButtonType.green,
                      buttonSize: ButtonSize.medium,
                      secondaryBackgroundColor: redColor5,
                      onTap: () {
                        send(context, card);
                      },
                    )
                  ],
                ),
              if (card.ticket_status == "WAIT")
                PrimaryButton(
                  text: S.of(context).cancel_request,
                  buttonType: ButtonType.red,
                  buttonSize: ButtonSize.medium,
                  onTap: () {
                    lockCard(context, card);
                  },
                ),
              vpad(kBottomNavigationBarHeight),
            ],
          ),
          FutureBuilder(
            future: () async {
              APIHistory.getHistoryLetter(card.id, 'residentcard').then((v) {
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
                                  ? genStatusColor(i.new_status ?? '')
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
