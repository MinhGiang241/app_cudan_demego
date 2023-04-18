import 'package:app_cudan/models/manage_card.dart';
import 'package:app_cudan/screens/services/transport_card/transport_details_screen.dart';
import 'package:app_cudan/services/api_transportation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/info_content_view.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_card.dart';
import '../../../widgets/primary_icon.dart';
import '../../../widgets/primary_info_widget.dart';
import '../../../widgets/primary_screen.dart';
import '../../../widgets/timeline_view.dart';
import 'add_new_transport_card.dart';
import 'extend_card_screen.dart';
import 'prv/manage_card_details_prv.dart';
import 'transport_card_screen.dart.dart';

class ManageCardDetailsScreen extends StatefulWidget {
  const ManageCardDetailsScreen({super.key});
  static const routeName = '/transport/details-card';

  @override
  State<ManageCardDetailsScreen> createState() =>
      _ManageCardDetailsScreenState();
}

class _ManageCardDetailsScreenState extends State<ManageCardDetailsScreen>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);
  @override
  Widget build(BuildContext context) {
    final arg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    var card = arg['card'] as ManageCard;
    var cancel = arg['cancel'] as Function;

    return ChangeNotifierProvider(
      create: (_) => ManageCardDetailsPrv(cancel),
      builder: (context, snapshot) => PrimaryScreen(
        appBar: PrimaryAppbar(
          leading: BackButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                TransportCardScreen.routeName,
                (route) => route.isFirst,
                arguments: 0,
              );
            },
          ),
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
            FutureBuilder(
              future: context
                  .read<ManageCardDetailsPrv>()
                  .getManageCardById(context, card.id),
              builder: (context, snapshot) {
                var loadedCard = context.watch<ManageCardDetailsPrv>().card;
                return ListView(
                  children: [
                    vpad(24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: PrimaryInfoWidget(
                        // label: S.of(context).resident_info,
                        listInfoView: [
                          InfoContentView(
                            isHorizontal: true,
                            title: S.of(context).card_num,
                            content: card.serial_lot,
                            contentStyle: txtBold(16, purpleColorBase),
                          ),
                          InfoContentView(
                            isHorizontal: true,
                            title: S.of(context).full_name,
                            content:
                                card.t?.name_resident ?? card.t?.name ?? "",
                            contentStyle: txtBold(14),
                          ),
                          InfoContentView(
                            isHorizontal: true,
                            title: S.of(context).address,
                            content: card.t?.address ?? "",
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
                            contentStyle: genContentStyle(card.status ?? ""),
                          ),
                          if (card.r != null)
                            InfoContentView(
                              isHorizontal: true,
                              title: S.of(context).lock_reason,
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
                    ...(loadedCard.t?.transports_list ?? [])
                        .asMap()
                        .entries
                        .map((e) {
                      var isExpired = e.value.expire_date == null
                          ? true
                          : DateTime.parse(e.value.expire_date ?? "")
                                  .compareTo(DateTime.now()) >
                              0;
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 8,
                          right: 8,
                          bottom: 12,
                        ),
                        child: PrimaryCard(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              TransportDetailsScreen.routeName,
                              arguments: {"item": e.value},
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 16,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    PrimaryIcon(
                                      icons: genTransIcon(
                                        e.value.vehicleType?.code,
                                      ),
                                      style: PrimaryIconStyle.gradient,
                                      gradients: PrimaryIconGradient.yellow,
                                      size: 32,
                                      padding: const EdgeInsets.all(12),
                                      color: Colors.white,
                                    ),
                                    hpad(16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${S.of(context).transport}: ${e.value.vehicleType?.name}',
                                            style: txtLinkSmall(),
                                          ),
                                          vpad(2),
                                          if (e.value.vehicleType?.code !=
                                              "BICYCLE")
                                            Text(
                                              '${S.of(context).licene_plate}: ${e.value.number_plate ?? ""}',
                                              style: txtBodyXSmallRegular(),
                                            ),
                                          if (e.value.vehicleType?.code !=
                                              "BICYCLE")
                                            vpad(2),
                                          if (e.value.vehicleType?.code !=
                                              "BICYCLE")
                                            Text(
                                              "${S.of(context).reg_num}: ${e.value.registration_number ?? ""}",
                                              style: txtBodyXSmallRegular(),
                                            ),
                                          if (e.value.vehicleType?.code !=
                                              "BICYCLE")
                                            vpad(2),
                                          Text(
                                            "${S.of(context).num_seat}: ${e.value.seats ?? ""}",
                                            style: txtBodyXSmallRegular(),
                                          ),
                                          vpad(2),
                                          Text(
                                            "${S.of(context).used_expired_date}: ${e.value.shelfLife?.use_time} ${e.value.shelfLife?.type_time}",
                                            style: txtBodyXSmallRegular(),
                                          ),
                                          Text(
                                            "${S.of(context).trans_status}: ${isExpired ? S.of(context).lock : S.of(context).active}",
                                            style: txtBodyXSmallRegular(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                vpad(5),
                                Row(
                                  children: [
                                    PrimaryButton(
                                      isLoading: false,
                                      buttonSize: ButtonSize.xsmall,
                                      buttonType: ButtonType.secondary,
                                      secondaryBackgroundColor: yellowColor4,
                                      textColor: yellowColorBase,
                                      text: S.of(context).extend,
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          ExtendCardScreen.routeName,
                                          arguments: {
                                            "card": loadedCard,
                                            "index": e.key,
                                            "cancel": cancel,
                                          },
                                        );
                                      },
                                    ),
                                    hpad(10),
                                    PrimaryButton(
                                      isLoading: false,
                                      buttonSize: ButtonSize.xsmall,
                                      buttonType: ButtonType.secondary,
                                      secondaryBackgroundColor: redColor4,
                                      textColor: redColorBase,
                                      text: S.of(context).cancel,
                                      onTap: () {
                                        context
                                            .read<ManageCardDetailsPrv>()
                                            .cancelTranport(context, e.key);
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                )
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
                    if (card.status != "LOCK" && card.status != "DESTROY")
                      vpad(30),
                    if (card.status != "LOCK" && card.status != "DESTROY")
                      PrimaryButton(
                        isLoading: false,
                        buttonSize: ButtonSize.medium,
                        buttonType: ButtonType.red,
                        text: S.of(context).cancel,
                        onTap: () {
                          cancel(context, card);
                        },
                      ),
                    vpad(40),
                  ],
                );
              },
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
      ),
    );
  }
}
