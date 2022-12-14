import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/screens/services/parking_card/register_parking_card.dart';
import 'package:app_cudan/screens/services/parking_card/tabs/trans_letter_list_tabs.dart';
import 'package:app_cudan/screens/services/service_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/info_content_view.dart';
import '../../../models/transportation_card.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_error_widget.dart';
import '../../../widgets/primary_loading.dart';
import '../../../widgets/primary_screen.dart';

import '../../home/home_screen.dart';
import 'providers/parking_card_provider.dart';
import 'tabs/trans_card_list_tabs.dart';

class TransportationCardListScreen extends StatefulWidget {
  const TransportationCardListScreen({Key? key, required this.ctx})
      : super(key: key);
  final BuildContext ctx;
  static const routeName = '/transportation-card';
  @override
  State<TransportationCardListScreen> createState() =>
      _ParkingCardListScreenState();
}

class _ParkingCardListScreenState extends State<TransportationCardListScreen>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);
  var initIndex = 0;
  @override
  void initState() {
    super.initState();
  }

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
      create: (context) => ParkingCardProvider(),
      builder: (context, state) {
        // final parkingCards =
        //     context.watch<ParkingCardProvider>().parkingCardsList;

        return PrimaryScreen(
          appBar: PrimaryAppbar(
            leading: BackButton(
                onPressed: () => Navigator.pushReplacementNamed(
                    context, ServiceScreen.routeName)),
            title: S.of(context).parking_card,
            tabController: tabController,
            isTabScrollabel: false,
            tabs: [
              Tab(text: S.of(context).card_status),
              Tab(text: S.of(context).letter_status),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            tooltip: S.of(context).add_trans_card,
            onPressed: () {
              Navigator.pushNamed(context, RegisterTransportationCard.routeName,
                  arguments: {"isEdit": false});
              // setState(() {});
            },
            backgroundColor: primaryColorBase,
            child: const Icon(
              Icons.add,
              size: 40,
            ),
          ),
          body: FutureBuilder(
              future: context.read<ParkingCardProvider>().getTrasportCardList(
                  context, context.read<ResidentInfoPrv>().residentId ?? ''),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: PrimaryLoading());
                } else if (snapshot.connectionState == ConnectionState.none) {
                  return PrimaryErrorWidget(
                      code: snapshot.hasError ? "err" : "1",
                      message: snapshot.data.toString(),
                      onRetry: () async {
                        // await context.read<ParkingCardProvider>().getTrasportCardList(
                        //     context,
                        //     context.read<ResidentInfoPrv>().residentId ?? '');
                        setState(() {
                          initIndex = initIndex;
                        });
                      });
                } else {
                  List<TransportationCard> transCardList = [];
                  List<TransportationCard> transCardLetter = [];

                  context
                      .read<ParkingCardProvider>()
                      .transportationCardList
                      .forEach((e) {
                    if (e.ticket_status == 'APPROVED') {
                      transCardList.add(e);
                    } else {
                      transCardLetter.add(e);
                    }
                  });
                  return TabBarView(
                    controller: tabController,
                    children: [
                      TransportationCardListTab(
                          onRefresh: _onRefresh,
                          extend: () => context
                              .read<ParkingCardProvider>()
                              .extendCard(context),
                          missingReport: () => context
                              .read<ParkingCardProvider>()
                              .missingReport(context),
                          lockCard: (TransportationCard card) => context
                              .read<ParkingCardProvider>()
                              .lockCard(context, card),
                          residentId:
                              context.read<ResidentInfoPrv>().residentId,
                          cardList: transCardList),
                      TransportationLetterListTab(
                          onRefresh: _onRefresh,
                          edit: () => context
                              .read<ParkingCardProvider>()
                              .editLetter(context),
                          sendRequest: (TransportationCard card) => context
                              .read<ParkingCardProvider>()
                              .sendRequest(context, card),
                          deleteLetter: (TransportationCard card) => context
                              .read<ParkingCardProvider>()
                              .deleteLetter(context, card),
                          cancelRegister: (TransportationCard card) => context
                              .read<ParkingCardProvider>()
                              .cancelLetter(context, card),
                          residentId:
                              context.read<ResidentInfoPrv>().residentId,
                          cardList: transCardLetter),
                    ],
                  );
                }
              }),
        );
      },
    );
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
