import 'package:app_cudan/models/manage_card.dart';
import 'package:app_cudan/screens/services/transport_card/transport_details_screen.dart';
import 'package:app_cudan/widgets/primary_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/info_content_view.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_card.dart';
import '../../../widgets/primary_icon.dart';
import '../../../widgets/primary_info_widget.dart';
import '../../../widgets/primary_screen.dart';
import '../../auth/prv/resident_info_prv.dart';
import '../resident_card/resident_card_screen.dart';
import 'add_new_transport_card.dart';
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
    var isRes = arg['res'] ?? false;
    var isResident = context.read<ResidentInfoPrv>().selectedApartment != null;

    return ChangeNotifierProvider(
      create: (_) => ManageCardDetailsPrv(cancel),
      builder: (context, snapshot) => PrimaryScreen(
        appBar: PrimaryAppbar(
          leading: BackButton(
            onPressed: () {
              if (isRes) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  ResidentCardListScreen.routeName,
                  (route) => route.isFirst,
                  arguments: 0,
                );
              } else {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  TransportCardScreen.routeName,
                  (route) => route.isFirst,
                  arguments: 0,
                );
              }
            },
          ),
          title: isRes
              ? S.of(context).res_card_details
              : S.of(context).trans_card_details,
          // tabController: tabController,
          isTabScrollabel: false,
          // tabs: [
          //   Tab(text: S.of(context).details),
          //   Tab(text: S.of(context).history),
          // ],
        ),
        body:
            // TabBarView(
            //   controller: tabController,
            //   children: [
            FutureBuilder(
          future: context
              .read<ManageCardDetailsPrv>()
              .getManageCardById(context, card.id),
          builder: (context, snapshot) {
            var listTranspost =
                context.watch<ManageCardDetailsPrv>().listTranspost;
            var loadedCard = context.watch<ManageCardDetailsPrv>().card;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: PrimaryLoading(),
              );
            }
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
                        content: loadedCard.as?.serial,
                        contentStyle: txtBold(16, purpleColorBase),
                      ),
                      InfoContentView(
                        isHorizontal: true,
                        title: S.of(context).full_name,
                        content: loadedCard.t?.re?.info_name ??
                            context
                                .read<ResidentInfoPrv>()
                                .userInfo
                                ?.info_name ??
                            context
                                .read<ResidentInfoPrv>()
                                .userInfo
                                ?.account
                                ?.fullName ??
                            "",
                        contentStyle: txtBold(14),
                      ),
                      // if (loadedCard.card_type != 'CUSTOMER')
                      //   InfoContentView(
                      //     isHorizontal: true,
                      //     title: S.of(context).address,
                      //     content:
                      //         ("${context.read<ResidentInfoPrv>().selectedApartment?.apartment?.name ?? ""} - ${context.read<ResidentInfoPrv>().selectedApartment?.floor?.name ?? ""} - ${context.read<ResidentInfoPrv>().selectedApartment?.building?.name ?? ""}"),
                      //   ),
                      InfoContentView(
                        isHorizontal: true,
                        title: S.of(context).address,
                        content: isResident
                            ? "${loadedCard.a?.name ?? ""}-${loadedCard.a?.f?.name ?? ""}-${loadedCard.a?.b?.name ?? ""}"
                            : (loadedCard.address ?? loadedCard.t?.address),
                      ),
                      // if (isRes)
                      //   InfoContentView(
                      //     isHorizontal: true,
                      //     title: S.of(context).cmnd,
                      //     content: isRes
                      //         ? loadedCard.res_card?.residentId
                      //         : loadedCard.t?.identity,
                      //   ),
                      if (isRes)
                        InfoContentView(
                          isHorizontal: true,
                          title: S.of(context).phone_num,
                          content: loadedCard.phone_number ??
                              loadedCard.re?.phone_required ??
                              loadedCard.t?.re?.phone_required ??
                              loadedCard.t?.re?.phone,
                        ),
                      if (loadedCard.t?.code != null)
                        InfoContentView(
                          isHorizontal: true,
                          title: S.of(context).reg_letter_num,
                          content: loadedCard.t?.code ?? '',
                          contentStyle: txtBold(16, purpleColorBase),
                        ),
                      if (loadedCard.registration_date != null)
                        InfoContentView(
                          isHorizontal: true,
                          title: S.of(context).reg_date,
                          content: Utils.dateFormat(
                            loadedCard.registration_date ?? "",
                            1,
                          ),
                        ),
                      InfoContentView(
                        isHorizontal: true,
                        title: S.of(context).card_status,
                        content: loadedCard.s?.name ?? "",
                        contentStyle: genContentStyle(loadedCard.status ?? ""),
                      ),
                      // if (loadedCard.r != null)
                      //   InfoContentView(
                      //     isHorizontal: true,
                      //     title: S.of(context).lock_reason,
                      //     content: loadedCard.r?.name ?? "",
                      //   ),
                      if (loadedCard.reasons != null)
                        InfoContentView(
                          isHorizontal: true,
                          title: S.of(context).reason_lock,
                          content: genStatus(loadedCard.reasons ?? ""),
                        ),
                      if (loadedCard.note_reason != null)
                        InfoContentView(
                          isHorizontal: true,
                          title: S.of(context).note,
                          content: loadedCard.note_reason,
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
                ...(listTranspost).asMap().entries.map((e) {
                  // ignore: unused_local_variable
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
                                    e.value.v?.code,
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
                                        '${S.of(context).transport}: ${e.value.v?.name}',
                                        style: txtLinkSmall(),
                                      ),
                                      vpad(2),
                                      if (e.value.v?.code != "BICYCLE")
                                        Text(
                                          '${S.of(context).licene_plate}: ${e.value.number_plate ?? ""}',
                                          style: txtBodyXSmallRegular(),
                                        ),
                                      if (e.value.v?.code != "BICYCLE") vpad(2),
                                      if (e.value.v?.code != "BICYCLE")
                                        Text(
                                          "${S.of(context).reg_num}: ${e.value.registration_number ?? ""}",
                                          style: txtBodyXSmallRegular(),
                                        ),
                                      if (e.value.v?.code != "BICYCLE") vpad(2),
                                      if (e.value.v?.code != "BICYCLE")
                                        Text(
                                          "${S.of(context).num_seat}: ${e.value.seats ?? ""}",
                                          style: txtBodyXSmallRegular(),
                                        ),
                                      // vpad(2),
                                      // Text(
                                      //   "${S.of(context).used_expired_date}: ${e.value.sh?.use_time} ${e.value.sh?.type_time}",
                                      //   style: txtBodyXSmallRegular(),
                                      // ),
                                      vpad(2),
                                      Text(
                                        "${S.of(context).expired_date}: ${Utils.dateFormat(e.value.expire_date ?? "", 1)}",
                                        style: txtBodyXSmallRegular(),
                                      ),
                                      vpad(2),
                                      Text(
                                        "${S.of(context).trans_status}: ${e.value.s?.name ?? ""}",
                                        style: txtBodyXSmallRegular(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            vpad(5),
                            if (loadedCard.status == "ACTIVED" ||
                                (loadedCard.status == "LOCK" &&
                                    loadedCard.reasons == "KHOAHETHAN"))
                              Row(
                                children: [
                                  // PrimaryButton(
                                  //   isLoading: false,
                                  //   buttonSize: ButtonSize.xsmall,
                                  //   buttonType: ButtonType.secondary,
                                  //   secondaryBackgroundColor: yellowColor4,
                                  //   textColor: yellowColorBase,
                                  //   text: S.of(context).extend,
                                  //   onTap: () {
                                  //     if (!(loadedCard.status == "ACTIVED" ||
                                  //         (loadedCard.status == "LOCK" &&
                                  //             loadedCard.reasons ==
                                  //                 "KHOAHETHAN"))) {
                                  //       Utils.showErrorMessage(
                                  //         context,
                                  //         S
                                  //             .of(context)
                                  //             .not_extend_inactive_card,
                                  //       );
                                  //     } else {
                                  //       Navigator.pushNamed(
                                  //         context,
                                  //         ExtendCardScreen.routeName,
                                  //         arguments: {
                                  //           "card": loadedCard,
                                  //           "index": e.key,
                                  //           "cancel": cancel,
                                  //           "item": e.value,
                                  //         },
                                  //       );
                                  //     }
                                  //   },
                                  // ),
                                  // hpad(10),
                                  // PrimaryButton(
                                  //   isLoading: false,
                                  //   buttonSize: ButtonSize.xsmall,
                                  //   buttonType: ButtonType.secondary,
                                  //   secondaryBackgroundColor: redColor4,
                                  //   textColor: redColorBase,
                                  //   text: S.of(context).cancel,
                                  //   onTap: () {
                                  //     context
                                  //         .read<ManageCardDetailsPrv>()
                                  //         .cancelTranport(
                                  //           context,
                                  //           e.key,
                                  //           e.value.id,
                                  //         );
                                  //     setState(() {});
                                  //   },
                                  // ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                if (card.card_type != 'CUSTOMER') vpad(16),
                if (card.card_type != 'CUSTOMER' && !isRes)
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
                      ),
                    ],
                  ),
                // if (!(card.status == "DESTROY" &&
                //             card.r?.code == 'NGUOIDUNGKHOA') &&
                //         card.status != "LOST"
                //     )
                //   vpad(30),
                // if (!(card.status == "DESTROY" &&
                //             card.r?.code == 'NGUOIDUNGKHOA') &&
                //         card.status != "LOST"
                //     // &&  (card.status != "LOCK" && card.status != "KHOAVIPHAM")
                //     )
                //   PrimaryButton(
                //     isLoading: false,
                //     buttonSize: ButtonSize.medium,
                //     buttonType: ButtonType.red,
                //     text: S.of(context).cancel_card,
                //     onTap: () {
                //       cancel(context, loadedCard);
                //     },
                //   ),
                vpad(40),
              ],
            );
          },
        ),
        //     FutureBuilder(
        //       future:
        //           context.read<ManageCardDetailsPrv>().getHistoryCard(card.id),
        //       builder: (context, snapshot) {
        //         return ListView(
        //           children: [
        //             vpad(24),
        //             Padding(
        //               padding: const EdgeInsets.symmetric(horizontal: 12),
        //               child: TimeLineView(
        //                 content: context
        //                     .watch<ManageCardDetailsPrv>()
        //                     .historyList
        //                     .map(
        //                       (i) => TimelineModel(
        //                         date: i.perform_date,
        //                         title: i.content,
        //                         subTitle: i.action,
        //                         color: i.status != null
        //                             ? genStatusColor(i.status ?? "")
        //                             : null,
        //                       ),
        //                     )
        //                     .toList(),
        //               ),
        //             )
        //           ],
        //         );
        //       },
        //     )
        //   ],
        // ),
      ),
    );
  }
}
