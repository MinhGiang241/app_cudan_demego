import 'package:app_cudan/constants/constants.dart';
import 'package:app_cudan/generated/l10n.dart';
import 'package:app_cudan/utils/utils.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:flutter/material.dart';

import '../../models/area.dart';
import '../../models/booking_service.dart';
import '../../services/api_booking_service.dart';
import '../../widgets/primary_empty_widget.dart';
import '../../widgets/primary_error_widget.dart';
import '../../widgets/primary_icon.dart';
import '../../widgets/primary_loading.dart';
import 'confirm_booking_service.dart';

class BookingLocationScreen extends StatefulWidget {
  const BookingLocationScreen({super.key});
  static const routeName = '/booking-location';

  @override
  State<BookingLocationScreen> createState() => _BookingLocationScreenState();
}

class _BookingLocationScreenState extends State<BookingLocationScreen> {
  List<Area> areas = [];

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map?;
    var service = arg?['service'] as BookingService;
    var type = arg?['type'] as String;
    var time_start = arg?['time_start'] as String;
    var time_end = arg?['time_end'] as String;
    var dateString = arg?['date'] as String;
    var num = arg?['num'] as int;
    var configGuest = arg?['guest-cfg'] as Map<String, dynamic>?;
    var configResident = arg?['resident-cfg'] as Map<String, dynamic>?;
    var guestAddress = arg?["guest-address"] as String?;

    // "guest-cfg": configGuest,
    // 'resident-cfg': configResident,

    return PrimaryScreen(
      appBar: PrimaryAppbar(title: S.of(context).zone),
      body: FutureBuilder(
        future: () async {
          var data = service.toMap();
          await APIBookingService.getAreaListBooking(
            time_start,
            time_end,
            data['list_of_service_areas'] ?? [],
          ).then((v) {
            if (v != null) {
              areas.clear();
              for (var i in v) {
                areas.add(Area.fromMap(i));
              }
            }
          }).catchError((e) {
            Utils.showErrorMessage(context, e);
          });
        }(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: PrimaryLoading(),
            );
          } else if (snapshot.hasError) {
            return PrimaryErrorWidget(
              code: snapshot.hasError ? "err" : "1",
              message: snapshot.data.toString(),
              onRetry: () async {
                setState(() {});
              },
            );
          } else if (areas.isEmpty) {
            return PrimaryEmptyWidget(
              emptyText: S.of(context).no_location,
              icons: PrimaryIcons.faders,
              action: () {},
            );
          }
          return ListView(
            children: [
              vpad(10),
              ...areas.map(
                (i) => Column(
                  children: [
                    InkWell(
                      onTap: () {
                        if (!((i.ticket_per_hour ?? 0) <= (i.sg ?? 0))) {
                          Navigator.pushNamed(
                            context,
                            ConfirmBookingService.routeName,
                            arguments: {
                              'service': service,
                              'type': type,
                              'time-start': time_start,
                              'time-end': time_end,
                              'area': i,
                              'date': dateString,
                              'num': num,
                              'mode': 0,
                              "guest-cfg": configGuest,
                              'resident-cfg': configResident,
                              'guest-address': guestAddress,
                            },
                          );
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Text(i.name ?? ''),
                            Spacer(),
                            if ((i.ticket_per_hour ?? 0) <= (i.sg ?? 0))
                              Text(
                                S.of(context).slot_limited,
                                style: txtRegular(14, redColorBase),
                              ),
                            Icon(Icons.navigate_next),
                          ],
                        ),
                      ),
                    ),
                    Divider(color: Colors.black),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
