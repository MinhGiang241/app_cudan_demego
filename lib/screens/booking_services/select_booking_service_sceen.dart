import 'package:app_cudan/screens/booking_services/month_booking_screen.dart';
import 'package:app_cudan/widgets/primary_card.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../../models/booking_service.dart';
import '../../widgets/primary_image_netword.dart';
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
          vpad(20),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: grayScaleColor4,
              borderRadius: BorderRadius.circular(12),
            ),
            child: HtmlWidget(
              '''${service.note}''',
              onTapUrl: (url) {
                launchUrl(Uri.parse(url));
                return false;
              },
              textStyle: txtBodyMediumRegular(),
              onTapImage: (ImageMetadata data) {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        PhotoViewer(
                      heroTag: 'hero',
                      link: data.sources.first.url,
                      listLink: [
                        data.sources.first.url,
                      ],
                      initIndex: 0,
                    ),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
