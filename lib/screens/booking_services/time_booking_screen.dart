import 'package:app_cudan/constants/constants.dart';
import 'package:app_cudan/screens/booking_services/booking_location_screen.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_card.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:app_cudan/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../generated/l10n.dart';
import '../../models/booking_service.dart';
import '../../utils/utils.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/primary_icon.dart';

class TimeBookingScreen extends StatefulWidget {
  const TimeBookingScreen({super.key});
  static const routeName = 'booking-time';

  @override
  State<TimeBookingScreen> createState() => _TimeBookingScreenState();
}

class _TimeBookingScreenState extends State<TimeBookingScreen> {
  final formatCurrency = NumberFormat.simpleCurrency(locale: "vi");
  TextEditingController controller = TextEditingController();
  int _selectedOption = 0;
  int num = 0;
  Map<String, dynamic>? configGuest;
  Map<String, dynamic>? configResident;
  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map?;
    var service = arg?['service'] as BookingService;
    var type = arg?['type'] as String;
    var guestIndex =
        service.list_of_fees_by_turn?.indexWhere((e) => e.object == "guest");
    var guestFee = (service.list_of_fees_by_turn != null &&
            guestIndex != null &&
            guestIndex != -1)
        ? service.list_of_fees_by_turn![guestIndex]
        : null;

    var residentIndex =
        service.list_of_fees_by_turn?.indexWhere((e) => e.object == "resident");
    var residentFee = (service.list_of_fees_by_turn != null &&
            residentIndex != null &&
            residentIndex != -1)
        ? service.list_of_fees_by_turn![residentIndex]
        : null;
    configGuest = (guestFee != null && service.service_charge != "nocharge")
        ? listConfigPriceCount(
            guestFee.toMap(),
            configGuest,
            service.ticket_type == "ageclassified",
          )
        : null;
    configResident =
        (residentFee != null && service.service_charge != "nocharge")
            ? listConfigPriceCount(
                residentFee.toMap(),
                configResident,
                service.ticket_type == "ageclassified",
              )
            : null;

    return PrimaryScreen(
      isPadding: false,
      appBar: PrimaryAppbar(
        title: S.of(context).select_date_time,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: ListView(
                children: [
                  vpad(12),
                  Text(
                    S.of(context).select_date,
                    style: txtBold(12),
                  ),
                  vpad(8),
                  PrimaryTextField(
                    controller: controller,
                    //label: S.of(context).select_date,
                    isReadOnly: true,
                    hint: 'dd/mm/yyyy',
                    isRequired: true,
                    suffixIcon: PrimaryIcon(icons: PrimaryIcons.calendar),
                    onTap: () {
                      Utils.showDatePickers(
                        context,
                        initDate: DateTime.now(),
                        startDate: DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                        ),
                        endDate: (service.isLimitedDaysRegistration == true &&
                                service.limited_days_registration_num != null)
                            ? DateTime(
                                DateTime.now()
                                    .add(
                                      Duration(
                                        days: service
                                            .limited_days_registration_num!,
                                      ),
                                    )
                                    .year,
                                DateTime.now()
                                    .add(
                                      Duration(
                                        days: service
                                            .limited_days_registration_num!,
                                      ),
                                    )
                                    .month,
                                DateTime.now()
                                    .add(
                                      Duration(
                                        days: service
                                            .limited_days_registration_num!,
                                      ),
                                    )
                                    .day,
                              )
                            : DateTime(DateTime.now().year + 10, 1, 1),
                      ).then((v) {
                        if (v != null) {
                          setState(() {
                            date = v;
                            controller.text =
                                Utils.dateFormat(v.toIso8601String(), 0);
                          });
                        } else {}
                      });
                    },
                  ),
                  vpad(10),
                  Divider(),
                  vpad(10),
                  Text(
                    S.of(context).select_time,
                    style: txtBold(12),
                  ),
                  vpad(8),
                  ...service.list_hours_of_operation_per_day!
                      .asMap()
                      .entries
                      .map(
                        (e) => RadioListTile<int>(
                          title: Text(
                            '${e.value.time_start} - ${e.value.time_end}',
                            style:
                                txtBodySmallRegular(color: grayScaleColorBase),
                          ),
                          value: e.key,
                          groupValue: _selectedOption,
                          onChanged: (value) {
                            setState(() {
                              _selectedOption = value!;
                            });
                          },
                        ),
                      ),
                  vpad(8),
                  if (residentFee != null &&
                      service.service_charge != "nocharge")
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).resident_ticket,
                            style: txtBold(12, primaryColorBase),
                          ),
                          Text(
                            S.of(context).max_num_ticket_per_day(3),
                            style: txtRegular(
                              12,
                            ),
                          ),
                          Divider(),
                          if (configResident != null &&
                              service.service_charge != "nocharge")
                            ...configResident!.entries.map<Widget>(
                              (e) => Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        genPriceName(e.key),
                                        style: txtRegular(12),
                                      ),
                                      Text(
                                        "${S.of(context).ticket_price}: ${formatCurrency.format(residentFee.toMap()[e.key] ?? 0).replaceAll("₫", "VND")}",
                                        style: txtRegular(10),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        configResident![e.key] += 1;
                                      });
                                    },
                                    icon: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          width: 1,
                                        ),
                                      ),
                                      child: Icon(Icons.add),
                                    ),
                                  ),
                                  Text(configResident![e.key].toString()),
                                  IconButton(
                                    onPressed: () {
                                      if (configResident![e.key] > 0) {
                                        setState(() {
                                          configResident![e.key] -= 1;
                                        });
                                      }
                                    },
                                    icon: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          width: 1,
                                        ),
                                      ),
                                      child: Icon(Icons.remove),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  vpad(10),
                  if (guestFee != null && service.service_charge != "nocharge")
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).guest_ticket,
                            style: txtBold(12, primaryColorBase),
                          ),
                          Divider(),
                          if (configGuest != null)
                            ...configGuest!.entries.map<Widget>(
                              (e) => Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        genPriceName(e.key),
                                        style: txtRegular(12),
                                      ),
                                      Text(
                                        "${S.of(context).ticket_price}: ${formatCurrency.format(guestFee.toMap()[e.key] ?? 0).replaceAll("₫", "VND")}",
                                        style: txtRegular(10),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        configGuest![e.key] += 1;
                                      });
                                    },
                                    icon: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          width: 1,
                                        ),
                                      ),
                                      child: Icon(Icons.add),
                                    ),
                                  ),
                                  Text(configGuest![e.key].toString()),
                                  IconButton(
                                    onPressed: () {
                                      if (configGuest![e.key] > 0) {
                                        setState(() {
                                          configGuest![e.key] -= 1;
                                        });
                                      }
                                    },
                                    icon: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          width: 1,
                                        ),
                                      ),
                                      child: Icon(Icons.remove),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  vpad(200),
                ],
              ),
            ),
            service.service_charge != "nocharge"
                ? Positioned(
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PrimaryButton(
                        onTap: () {
                          if (controller.text.isEmpty) {
                            Utils.showErrorMessage(
                              context,
                              S.of(context).not_yet_select_date,
                            );
                          } else {
                            print(configGuest);
                            print(configResident);
                            Navigator.pushNamed(
                              context,
                              BookingLocationScreen.routeName,
                              arguments: {
                                'service': service,
                                'type': type,
                                "time_start": service
                                    .list_hours_of_operation_per_day?[
                                        _selectedOption]
                                    .time_start,
                                "time_end": service
                                    .list_hours_of_operation_per_day?[
                                        _selectedOption]
                                    .time_end,
                                "date": date.toIso8601String(),
                                "num": num,
                                "guest-cfg": configGuest,
                                'resident-cfg': configResident,
                              },
                            );
                          }
                        },
                        width: dvWidth(context) - 16,
                        text: S.of(context).next,
                        buttonSize: ButtonSize.small,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  )
                : Positioned(
                    bottom: 0,
                    child: PrimaryCard(
                      width: dvWidth(context),
                      child: Column(
                        children: [
                          vpad(5),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              S.of(context).enter_amount_resident_ticket,
                              style: txtRegular(12),
                            ),
                          ),
                          vpad(5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    num += 1;
                                  });
                                },
                                icon: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      width: 1,
                                    ),
                                  ),
                                  child: Icon(Icons.add),
                                ),
                              ),
                              Text(num.toString()),
                              IconButton(
                                onPressed: () {
                                  if (num > 0) {
                                    setState(() {
                                      num -= 1;
                                    });
                                  }
                                },
                                icon: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      width: 1,
                                    ),
                                  ),
                                  child: Icon(Icons.remove),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: PrimaryButton(
                              onTap: () {
                                var hasFeeNotTicket = (configGuest?['price'] ==
                                            null ||
                                        configGuest?['price'] == 0) &&
                                    (configGuest?['price_child'] == null ||
                                        configGuest?['price_child'] == 0) &&
                                    (configGuest?['price_child_weekend'] ==
                                            null ||
                                        configGuest?['price_child_weekend'] ==
                                            0) &&
                                    (configGuest?['price_adult_weekend'] ==
                                            null ||
                                        configGuest?['price_adult_weekend'] ==
                                            0) &&
                                    (configGuest?['price_weekend'] ==
                                            null ||
                                        configGuest?['price_weekend'] == 0) &&
                                    (configResident?['price'] == 0) &&
                                    (configResident?['price_child'] ==
                                            null ||
                                        configResident?['price_child'] == 0) &&
                                    (configResident?['price_child_weekend'] ==
                                            null ||
                                        configResident?['price_child_weekend'] ==
                                            0) &&
                                    (configResident?['price_adult_weekend'] ==
                                            null ||
                                        configResident?['price_adult_weekend'] ==
                                            0) &&
                                    (configResident?['price_weekend'] == null ||
                                        configResident?['price_weekend'] == 0);
                                if (controller.text.isEmpty) {
                                  Utils.showErrorMessage(
                                    context,
                                    S.of(context).not_yet_select_date,
                                  );
                                } else if ((num == 0 &&
                                        service.service_charge == 'nocharge') ||
                                    (service.service_charge != 'nocharge') &&
                                        hasFeeNotTicket) {
                                  Utils.showErrorMessage(
                                    context,
                                    S.of(context).no_have_ticket,
                                  );
                                } else {
                                  Navigator.pushNamed(
                                    context,
                                    BookingLocationScreen.routeName,
                                    arguments: {
                                      'service': service,
                                      'type': type,
                                      "time_start": service
                                          .list_hours_of_operation_per_day?[
                                              _selectedOption]
                                          .time_start,
                                      "time_end": service
                                          .list_hours_of_operation_per_day?[
                                              _selectedOption]
                                          .time_end,
                                      "date": date.toIso8601String(),
                                      "num": num,
                                      "guest-cfg": configGuest,
                                      'resident-cfg': configResident,
                                    },
                                  );
                                }
                              },
                              width: double.infinity,
                              text: S.of(context).next,
                              buttonSize: ButtonSize.small,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          vpad(5),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> listConfigPriceCount(
    Map<String, dynamic> map,
    Map<String, dynamic>? d,
    bool ageClassified,
  ) {
    Map<String, dynamic> data = {};
    for (var i in map.keys) {
      if (!ageClassified) {
        if (i == 'price' || i == "price_weekend") {
          data[i] = d?[i] ?? 0;
        }
      } else {
        if ([
          'price_child',
          'price_adult',
          'price_child_weekend',
          'price_adult_weekend',
        ].contains(i)) {
          data[i] = d?[i] ?? 0;
        }
      }
    }
    return data;
  }

  String genPriceName(String? priceName) {
    switch (priceName) {
      case "price":
        return S.current.ticket_price;
      case "price_child":
        return S.current.child_ticket_num;
      case "price_adult":
        return S.current.adult_ticket_num;
      case "price_weekend":
        return S.current.weekend_ticket_num;
      case "price_child_weekend":
        return S.current.weekend_child_ticket_num;
      case "price_adult_weekend":
        return S.current.weekend_aldult_ticket_num;
      default:
        return S.current.ticket_price;
    }
  }
}
