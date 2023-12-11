import 'package:app_cudan/screens/booking_services/month_booking_screen.dart';
import 'package:app_cudan/widgets/primary_card.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../../models/booking_service.dart';
import 'time_booking_screen.dart';

class SelectBookingServiceScreen extends StatelessWidget {
  const SelectBookingServiceScreen({super.key});
  static const routeName = '/select-booking';

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map?;
    var service = arg?['service'] as BookingService;
    return PrimaryScreen(
      appBar: AppBar(
        elevation: 0,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          vpad(20),
          Text(
            service.name ?? '',
            style: txtDisplayXSmall(),
            textAlign: TextAlign.center,
          ),
          vpad(30),
          if (service.registration_type == 'turn' ||
              service.registration_type == 'all')
            PrimaryCard(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TimeBookingScreen.routeName,
                  arguments: {
                    'service': service,
                    'type': 'turn',
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  S.of(context).time_ticket,
                  style: txtRegular(14),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          if (service.registration_type == 'month' ||
              service.registration_type == 'all')
            vpad(30),
          if (service.registration_type == 'month' ||
              service.registration_type == 'all')
            PrimaryCard(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MonthBookingScreen.routeName,
                  arguments: {
                    'service': service,
                    'type': 'month',
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  S.of(context).month_ticket,
                  style: txtRegular(14),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
