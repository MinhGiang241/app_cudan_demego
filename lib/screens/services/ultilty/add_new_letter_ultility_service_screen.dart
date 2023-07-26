import 'package:app_cudan/screens/services/ultilty/prv/add_new_letter_ultility_prv.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/primary_screen.dart';
import 'pages/booking_time_page.dart';
import 'pages/select_location_page.dart';
import 'pages/service_information_page.dart';

class AddNewLetterUltilityScreen extends StatelessWidget {
  const AddNewLetterUltilityScreen({super.key});
  static const routeName = '/ultility-service/add-new';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddNewLetterUltilityPrv(),
      builder: (context, snapshot) => PrimaryScreen(
        appBar: PrimaryAppbar(
          title: "Đăng ký dịch vụ",
          leading: BackButton(
            onPressed: () {
              if (context.read<AddNewLetterUltilityPrv>().activeStep >= 1) {
                context.read<AddNewLetterUltilityPrv>().onBack(context);
              } else {
                Navigator.pop(context);
              }
            },
          ),
        ),
        body: SafeArea(
          child: PageView(
            onPageChanged: context.read<AddNewLetterUltilityPrv>().onPageChange,
            controller: context.watch<AddNewLetterUltilityPrv>().pageController,
            children: [
              BookingTimePage(),
              SelectLocationPage(),
              ServiceInformationPage(),
            ],
          ),
        ),
      ),
    );
  }
}
