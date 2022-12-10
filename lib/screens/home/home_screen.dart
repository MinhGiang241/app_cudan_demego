import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../generated/l10n.dart';

import '../../services/prf_data.dart';
import '../../widgets/primary_card.dart';

import '../../widgets/primary_loading.dart';
import '../account/account_screen.dart';

import '../auth/prv/auth_prv.dart';
import '../auth/prv/resident_info_prv.dart';
import 'prv/home_prv.dart';
import 'widgets/bill_home.dart';

import 'widgets/convinent_service_home.dart';
import 'widgets/event_home.dart';

import 'widgets/feedback_home.dart';
import 'widgets/header_home.dart';
import 'widgets/header_title.dart';

import 'widgets/new_home.dart';
import 'widgets/project_info_home.dart';
import 'widgets/services_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  // static const TextStyle optionStyle =
  //     TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  // static const List<Widget> _widgetOptions = <Widget>[
  //   Text(
  //     'Index 0: Home',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     'Index 1: Business',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     'Index 2: School',
  //     style: optionStyle,
  //   ),
  // ];

  void _onItemTapped(int index) {
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
        var auth = context.watch<AuthPrv>().authStatus;
        var res = context.watch<ResidentInfoPrv>().residentId;
        var l = context.watch<ResidentInfoPrv>().listOwn;
        print(auth);
        print(res);
        print(l);
        final isLoading = context.watch<HomePrv>().isLoading;
        return Stack(alignment: Alignment.center, children: [
          Scaffold(
            body: _navigationTab(context),
            bottomNavigationBar: _bottomNavigationBar,
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.white,
              child: Icon(Icons.phone_sharp,
                  size: 40,
                  color: primaryColorBase,
                  shadows: [
                    Shadow(
                        offset: const Offset(-2, 2),
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 10.0),
                  ]),
            ),
          ),
          if (isLoading)
            const Center(
              child: PrimaryCard(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: PrimaryLoading(),
                ),
              ),
            )
        ]);

        // _navigationTab(context);
      },
    );
  }

  Widget _navigationTab(BuildContext context) {
    final isLoading = context.watch<HomePrv>().isLoading;
    switch (_selectedIndex) {
      case 0:
        return RepaintBoundary(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                vpad(16 + MediaQuery.of(context).padding.top),
                const HeaderTitle(),
                vpad(30),
                const HeaderHome(),
                vpad(30),
                const ProjectInfoHome(),
                vpad(30),
                const BillsHome(),
                vpad(30),
                const ServicesHome(),
                vpad(30),
                const ConvinientServiceHome(),
                vpad(30),
                const FeedbackHome(),
                vpad(30),
                const EventsHome(),
                vpad(24),
                const NewsHome(),
                vpad(kBottomNavigationBarHeight + 50)
              ],
            ),
          ),
        );
      case 3:
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

  Widget get _bottomNavigationBar {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10)
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
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
              BottomNavigationBarItem(
                icon: const Icon(Icons.article),
                label: S.of(context).forum,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.chat_bubble),
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
      ),
    );
  }
}
