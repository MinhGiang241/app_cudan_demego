import 'package:app_cudan/screens/booking_services/prv/month_booking_service_prv.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_dropdown.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:app_cudan/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../../models/booking_service.dart';
import '../../models/transportation_card.dart';
import '../../services/prf_data.dart';
import '../../utils/utils.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/primary_icon.dart';

class MonthBookingScreen extends StatelessWidget {
  MonthBookingScreen({super.key});
  static const routeName = '/month-booking';
  final formatCurrency = NumberFormat.simpleCurrency(locale: "vi");

  String genShelfLifeString(ShelfLife? s) {
    switch (s?.type_time) {
      case 'N':
        return '${s?.use_time} ${S.current.year}${PrfData.shared.getLanguage() == 1 && (s?.use_time ?? 0) >= 2 ? "s" : ""} ';
      case 'TH':
        return '${s?.use_time} ${S.current.month}${PrfData.shared.getLanguage() == 1 && (s?.use_time ?? 0) >= 2 ? "s" : ""} ';
      case 'NG':
        return '${s?.use_time} ${S.current.date}${PrfData.shared.getLanguage() == 1 && (s?.use_time ?? 0) >= 2 ? "s" : ""} ';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map?;

    return ChangeNotifierProvider(
      create: (context) => MonthBookingServicePrv(
        type: arg?['type'] as String,
        service: arg?['service'] as BookingService,
      ),
      builder: (context, builder) {
        var service = context.read<MonthBookingServicePrv>().service;
        var shelflifeList =
            context.watch<MonthBookingServicePrv>().shelflifeList;
        var option = context.watch<MonthBookingServicePrv>().timeOption;
        var areas = context.watch<MonthBookingServicePrv>().areas;
        return PrimaryScreen(
          appBar: PrimaryAppbar(
            title: S.of(context).monthly_register_service,
          ),
          body: Form(
            onChanged: context.watch<MonthBookingServicePrv>().autoValid
                ? () => context.read<MonthBookingServicePrv>().validate(context)
                : null,
            autovalidateMode: context.watch<MonthBookingServicePrv>().autoValid
                ? AutovalidateMode.onUserInteraction
                : null,
            key: context.watch<MonthBookingServicePrv>().formKey,
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    vpad(12),
                    PrimaryDropDown(
                      validateString:
                          context.watch<MonthBookingServicePrv>().areaValidate,
                      validator: Utils.emptyValidatorDropdown,
                      labelStyle: txtBold(12),
                      onChange: (v) => context
                          .read<MonthBookingServicePrv>()
                          .onChangeArea(v),
                      hint: S.of(context).select_zone,
                      selectList: areas
                          .asMap()
                          .entries
                          .map(
                            (i) => DropdownMenuItem(
                              child: Text(
                                '${i.value.name}',
                              ),
                              value: i.key,
                            ),
                          )
                          .toList(),
                      label: S.of(context).select_zone,
                      isRequired: true,
                    ),
                    vpad(10),
                    Divider(
                      color: Colors.black,
                    ),
                    vpad(10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        S.of(context).time_slot,
                        style: txtBold(12),
                      ),
                    ),
                    vpad(8),
                    ...service.list_hours_of_operation_per_day!
                        .asMap()
                        .entries
                        .map(
                          (e) => RadioListTile<int>(
                            title: Text(
                              '${e.value.time_start} - ${e.value.time_end}',
                              style: txtBodySmallRegular(
                                  color: grayScaleColorBase),
                            ),
                            value: e.key,
                            groupValue: option,
                            onChanged: (v) => context
                                .read<MonthBookingServicePrv>()
                                .selectTime(v),
                          ),
                        ),
                    vpad(16),
                    PrimaryDropDown(
                      validator: Utils.emptyValidatorDropdown,
                      validateString: context
                          .watch<MonthBookingServicePrv>()
                          .shelfLifeValidate,
                      labelStyle: txtBold(12),
                      hint: S.of(context).select_shelfife,
                      selectList: shelflifeList
                          .asMap()
                          .entries
                          .map(
                            (i) => DropdownMenuItem(
                              child: Text(
                                genShelfLifeString(i.value.shelfLife),
                              ),
                              value: i.key,
                            ),
                          )
                          .toList(),
                      label: S.of(context).select_shelfife,
                      isRequired: true,
                      onChange: (v) => context
                          .read<MonthBookingServicePrv>()
                          .onChangeShelfLife(context, v),
                    ),
                    if (service.service_charge == 'charge') vpad(16),
                    if (service.service_charge == 'charge')
                      PrimaryTextField(
                        controller: context
                            .watch<MonthBookingServicePrv>()
                            .feeController,
                        labelStyle: txtBold(12),
                        hint: S.of(context).register_fee,
                        label: S.of(context).register_fee,
                        isRequired: true,
                        enable: false,
                        background: grayScaleColor4,
                      ),
                    vpad(16),
                    PrimaryTextField(
                      validator: Utils.emptyValidator,
                      validateString:
                          context.watch<MonthBookingServicePrv>().startValidate,
                      labelStyle: txtBold(12),
                      controller: context
                          .watch<MonthBookingServicePrv>()
                          .startDateController,
                      label: S.of(context).begin_use_date,
                      isReadOnly: true,
                      hint: 'dd/mm/yyyy',
                      isRequired: true,
                      suffixIcon: PrimaryIcon(icons: PrimaryIcons.calendar),
                      onTap: () => context
                          .read<MonthBookingServicePrv>()
                          .pickStartDate(context),
                    ),
                    vpad(16),
                    PrimaryTextField(
                      labelStyle: txtBold(12),
                      controller: context
                          .watch<MonthBookingServicePrv>()
                          .endDateController,
                      label: S.of(context).end_use_date,
                      isReadOnly: true,
                      enable: false,
                      hint: 'dd/mm/yyyy',
                      isRequired: true,
                      background: grayScaleColor4,
                      suffixIcon: PrimaryIcon(icons: PrimaryIcons.calendar),
                    ),
                    vpad(20),
                    PrimaryButton(
                      width: double.infinity,
                      onTap: () => context
                          .read<MonthBookingServicePrv>()
                          .onNext(context),
                      text: S.of(context).next,
                      buttonSize: ButtonSize.small,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    vpad(40),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
