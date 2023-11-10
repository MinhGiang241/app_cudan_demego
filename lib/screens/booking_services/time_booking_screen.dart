import 'package:app_cudan/constants/constants.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_card.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:app_cudan/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';

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
  TextEditingController controller = TextEditingController();
  int _selectedOption = 0;
  int num = 0;
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map?;
    var service = arg?['service'] as BoookingService;

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
                            '${e.value.time_start}- ${e.value.time_end}',
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
                  vpad(60),
                ],
              ),
            ),
            Positioned(
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
                        onTap: () {},
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
}
