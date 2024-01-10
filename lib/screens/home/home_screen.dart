import 'dart:async';

import 'package:alert_banner/types/enums.dart';
import 'package:alert_banner/widgets/alert.dart';
import 'package:app_cudan/screens/chat/new_chat/bloc/new_chat_bloc.dart';
import 'package:app_cudan/screens/chat/new_chat/new_chat_screen.dart';
import 'package:badges/badges.dart' as B;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:upgrader/upgrader.dart';
import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../../widgets/primary_card.dart';
import '../../widgets/primary_loading.dart';
import '../account/account_screen.dart';
import '../auth/prv/resident_info_prv.dart';
import '../notification/prv/undread_noti.dart';
import 'home_service.dart';
import 'prv/home_prv.dart';
import 'widgets/event_home.dart';
import 'widgets/header_home.dart';
import 'widgets/header_title.dart';
import 'widgets/new_home.dart';
import 'widgets/project_info_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// final ChatMessageBloc bloc = ChatMessageBloc();

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  void _onItemTapped(int index) async {
    if (index == 1 && _selectedIndex != index) {
      context.read<NewChatBloc>().resetCount();
      //context.read<ChatMessageBloc>().add(BackChatMessageInit());
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ApiService.shared.getExistClient().then((value) {
    //   log(value!.credentials.accessToken);
    // });

    return ChangeNotifierProvider<HomePrv>(
      create: (context) => HomePrv(context),
      builder: (context, snapshot) {
        final isLoading = context.watch<HomePrv>().isLoading;
        // var messageCount = context.watch<HomePrv>().messageCount;

        return UpgradeAlert(
          child: FutureBuilder(
            future: () {}(),
            builder: (context, snap) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Scaffold(
                    body: _navigationTab(context),
                    bottomNavigationBar:
                        _bottomNavigationBar(context, _selectedIndex),
                    // context.watch<ChatMessageBloc>().state.stateChat ==
                    //         StateChatEnum.START
                    //     ? null
                    // context.watch<NewChatBloc>().state.isInit
                    //     ? _bottomNavigationBar(messageCount)
                    //     : null,
                  ),
                  if (isLoading)
                    const Center(
                      child: PrimaryCard(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: PrimaryLoading(),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        );

        // _navigationTab(context);
      },
    );
  }

  Widget _navigationTab(BuildContext context) {
    // var isResident = context.read<ResidentInfoPrv>().residentId != null &&
    //     context.read<ResidentInfoPrv>().selectedApartment != null;
    switch (_selectedIndex) {
      case 0:
        UnreadNotification.getUnReadNotification();
        return RepaintBoundary(
          child:
              //  UpgradeAlert(
              //   child:
              Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              controller: refreshController,
              onRefresh: () async {
                await context.read<HomePrv>().initial();
                UnreadNotification.getUnReadNotification();
                refreshController.refreshCompleted();
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      vpad(16 + MediaQuery.of(context).padding.top),
                      HeaderTitle(
                        onMenuTab: _onItemTapped,
                      ),
                      vpad(30),
                      const HeaderHome(),
                      vpad(30),
                      const HomeServices(),
                      vpad(30),
                      // // const BillsHome(),
                      // // vpad(30),
                      // // const ServicesHome(),
                      // // vpad(30),
                      // // const UtilityService(),
                      // // vpad(30),
                      // // // const ConvinientServiceHome(),
                      // // // vpad(30),
                      // // if (isResident) const FeedbackHome(),
                      // // if (isResident) vpad(30),
                      if (context.watch<HomePrv>().event != null)
                        const EventsHome(),
                      if (context.watch<HomePrv>().event != null) vpad(30),
                      const ProjectInfoHome(),
                      vpad(24),
                      if (context.read<ResidentInfoPrv>().residentId != null)
                        const NewsHome(),
                      vpad(kBottomNavigationBarHeight + 50),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // ),
        );
      case 1:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.read<HomePrv>().clearMessageBadge();
        });
        return NewChatScreen(); //ChatScreen();
      case 2:
        return const AccountScreen();

      default:
        return const Center(
          child: PrimaryCard(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: PrimaryLoading(),
            ),
          ),
        );
    }
  }

  Widget _bottomNavigationBar(BuildContext context, int index) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: StreamBuilder(
        stream: context.read<NewChatBloc>().messageController.stream,
        builder: (context, snapshot) {
          // context.read<NewChatBloc>().messageController.stream.
          print('alert');
          if (snapshot.hasData && snapshot.data != 0) {
            Future.delayed(Duration.zero).then((v) {
              showAlertBanner(
                // <-- The function!
                context,
                () => print("TAPPED"),
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
                          spreadRadius: 0,
                          blurRadius: 10,
                        ),
                      ],
                      color: greenColor10.withOpacity(0.7),
                    ),
                    child: Center(
                      child: Text(
                        S.of(context).has_message,
                        style: txtBold(14, Colors.white),
                      ),
                    ),
                  ),
                ), // <-- Put any widget here you want!
                alertBannerLocation: AlertBannerLocation.top,
                durationOfStayingOnScreen: Duration(
                  milliseconds: 400,
                ),
              );
            });
          }
          return ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors.white,
              ),
              child: BottomNavigationBar(
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.home),
                    label: S.of(context).home,
                  ),
                  // BottomNavigationBarItem(
                  //   icon: const Icon(Icons.article),
                  //   label: S.of(context).forum,
                  // ),
                  BottomNavigationBarItem(
                    icon: B.Badge(
                      badgeContent: Text(
                        snapshot.data.toString(),
                        style: txtBold(10, Colors.white),
                      ),
                      showBadge: snapshot.data != null && snapshot.data != 0,
                      child: const Icon(Icons.message),
                    ),
                    //  Icon(Icons.chat_bubble),
                    label: S.of(context).message,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.account_circle),
                    label: S.of(context).account,
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: primaryColorBase,
                unselectedItemColor: grayScaleColorBase.withOpacity(0.58),
                onTap: _onItemTapped,
                showSelectedLabels: true,
                showUnselectedLabels: true,
              ),
            ),
          );
        },
      ),
    );
  }
}
