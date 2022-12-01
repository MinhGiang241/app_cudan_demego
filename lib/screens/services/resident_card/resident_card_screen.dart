import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/info_content_view.dart';
import '../../../models/resident_card.dart';
import '../../../models/response_thecudan_list.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_card.dart';
import '../../../widgets/primary_empty_widget.dart';
import '../../../widgets/primary_error_widget.dart';
import '../../../widgets/primary_icon.dart';
import '../../../widgets/primary_loading.dart';
import '../../../widgets/primary_screen.dart';
import '../../account/r_card/r_card_info.dart';
import '../../account/r_card/register_r_card.dart';
import '../../auth/prv/resident_info_prv.dart';
import '../service_screen.dart';
import 'prv/resident_card_prv.dart';
import 'register_resident_card.dart';
import 'tab/resident_card_tab.dart';
import 'tab/resident_letter_tab.dart';

class ResidentCardListScreen extends StatefulWidget {
  const ResidentCardListScreen({Key? key}) : super(key: key);
  static const routeName = '/residence-card';

  @override
  State<ResidentCardListScreen> createState() => _ResidentCardListScreenState();
}

class _ResidentCardListScreenState extends State<ResidentCardListScreen>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);
  var initIndex = 0;
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as int?;

    if (arg != null) {
      initIndex = arg;
    }
    tabController.index = initIndex;

    void _onRefresh() {
      setState(() {
        initIndex = tabController.index;
      });
    }

    return ChangeNotifierProvider(
        create: (context) => ResidentCardPrv(),
        builder: (context, state) {
          return PrimaryScreen(
              appBar: PrimaryAppbar(
                leading: BackButton(
                    onPressed: () => Navigator.pushReplacementNamed(
                        context, ServiceScreen.routeName)),
                title: S.of(context).res_card,
                tabController: tabController,
                isTabScrollabel: false,
                tabs: [
                  Tab(text: S.of(context).card_status),
                  Tab(text: S.of(context).letter_status),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                tooltip: S.of(context).register_res_card,
                onPressed: () {
                  Navigator.pushNamed(context, RegisterResidentCard.routeName,
                      arguments: {"isEdit": false});
                },
                backgroundColor: primaryColorBase,
                child: const Icon(
                  Icons.add,
                  size: 40,
                ),
              ),
              body: FutureBuilder(
                future: context
                    .read<ResidentCardPrv>()
                    .getResidentCardByResidentId(context,
                        context.read<ResidentInfoPrv>().residentId ?? ""),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: PrimaryLoading());
                  } else if (snapshot.connectionState == ConnectionState.none) {
                    return PrimaryErrorWidget(
                        code: snapshot.hasError ? "err" : "1",
                        message: snapshot.data.toString(),
                        onRetry: () async {
                          setState(() {});
                        });
                  } else {
                    List<ResidentCard> resCardList = [];
                    List<ResidentCard> resCardLetter = [];

                    context.read<ResidentCardPrv>().resCardList.forEach((e) {
                      if (e.ticket_status == 'APPROVED') {
                        resCardList.add(e);
                      } else {
                        resCardLetter.add(e);
                      }
                    });

                    return TabBarView(
                      controller: tabController,
                      children: [
                        ResidentCardTab(
                            onRefresh: _onRefresh,
                            extend: () =>
                                context.read<ResidentCardPrv>().extend(context),
                            missingReport: () => context
                                .read<ResidentCardPrv>()
                                .missingReport(context),
                            lockCard: (ResidentCard card) => context
                                .read<ResidentCardPrv>()
                                .lockCard(context, card),
                            residentId:
                                context.read<ResidentInfoPrv>().residentId,
                            cardList: resCardList),
                        ResidentLetterTab(
                            onRefresh: _onRefresh,
                            edit: () => context
                                .read<ResidentCardPrv>()
                                .editLetter(context),
                            sendRequest: (ResidentCard data) => context
                                .read<ResidentCardPrv>()
                                .sendRequest(context, data),
                            deleteLetter: (String id) => context
                                .read<ResidentCardPrv>()
                                .deleteLetter(context, id),
                            cancelRegister: (ResidentCard card) => context
                                .read<ResidentCardPrv>()
                                .cancelLetter(context, card),
                            residentId:
                                context.read<ResidentInfoPrv>().residentId,
                            cardList: resCardLetter
                            // ..sort(
                            //   (a, b) =>
                            //       (b.updatedTime!).compareTo(a.updatedTime!),
                            // )
                            // ..sort((a, b) =>
                            //     genOrder(a.ticket_status ?? "") -
                            //     genOrder(b.ticket_status ?? "")),
                            ),
                      ],
                    );
                  }
                },
              ));
        });
  }
}

class PrimaryRadio extends StatelessWidget {
  const PrimaryRadio({
    Key? key,
    required this.isSelected,
    required this.title,
    this.onTap,
  }) : super(key: key);
  final bool isSelected;
  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        width: isSelected ? 5 : 2,
                        color: isSelected ? primaryColorBase : primaryColor4))),
            hpad(16),
            Text(
              title,
              style: txtLinkXSmall(),
            )
          ],
        ),
      ),
    );
  }
}
