import 'package:app_cudan/generated/l10n.dart';
import 'package:app_cudan/models/info_content_view.dart';
import 'package:app_cudan/models/transportation_card.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/utils/utils.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_button.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../models/area.dart';
import '../../models/booking_service.dart';
import 'prv/confirm_booking_service_prv.dart';

class ConfirmBookingService extends StatefulWidget {
  const ConfirmBookingService({super.key});
  static const routeName = "/confirm-booking";

  @override
  State<ConfirmBookingService> createState() => _ConfirmBookingServiceState();
}

/**
* Mode 
* 0 : Prepare submit
* 1 : Alrready summitted
* 2 : Alrready Canceled
**/

class _ConfirmBookingServiceState extends State<ConfirmBookingService> {
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map?;

    return ChangeNotifierProvider(
      create: (context) => ConfirmBookingServicePrv(
        service: arg?['service'] as BookingService,
        time_start: arg?['time-start'] as String,
        time_end: arg?['time-end'] as String,
        num: arg?['num'] as int,
        area: arg?['area'] as Area,
        dateString: arg?['date'] as String,
        mode: arg?['mode'] as int,
        type: arg?['type'] as String,
        configGuest: arg?['guest-cfg'] as Map<String, dynamic>?,
        configResident: arg?['resident-cfg'] as Map<String, dynamic>?,
        shelfLife: arg?['fee_month'] as FeeByMonth?,
        end_date: arg?['end_date'] as String?,
        price: arg?['price'] as double?,
      ),
      builder: (context, builder) {
        var service = context.read<ConfirmBookingServicePrv>().service;
        var time_start = context.read<ConfirmBookingServicePrv>().time_start;
        var time_end = context.read<ConfirmBookingServicePrv>().time_end;
        var area = context.read<ConfirmBookingServicePrv>().area;
        var dateString = context.read<ConfirmBookingServicePrv>().dateString;
        var num = context.read<ConfirmBookingServicePrv>().num;
        var mode = context.watch<ConfirmBookingServicePrv>().mode;
        var loading = context.watch<ConfirmBookingServicePrv>().loading;
        List<InfoContentView> listInfo = [
          InfoContentView(
            title: S.of(context).util_type,
            content: service.name ?? '',
          ),
          InfoContentView(
            title: S.of(context).zone,
            content: area.name ?? '',
          ),
          InfoContentView(
            title: S.of(context).resident_ticket_amount,
            content: '${num}',
          ),
          InfoContentView(
            title: S.of(context).booking_time,
            content: context
                    .watch<ConfirmBookingServicePrv>()
                    .bookingRegistration
                    ?.time_slot ??
                '${Utils.dateFormat(dateString, 0)} ${time_start} - ${time_end}',
          ),
        ];
        var resident = context.read<ResidentInfoPrv>().userInfo;
        var apartment = context.read<ResidentInfoPrv>().selectedApartment;
        List<InfoContentView> listInfoUser = [
          InfoContentView(
            title: S.of(context).registing_persion,
            content: resident?.info_name,
          ),
          InfoContentView(
            title: S.of(context).apartment_code,
            content:
                "${apartment?.apartment?.name}-${apartment?.floor?.name}-${apartment?.building?.name}",
          ),
        ];
        return PrimaryScreen(
          appBar: PrimaryAppbar(
            title: mode == 0
                ? S.of(context).confirm_register
                : S.of(context).booking_detail,
          ),
          body: ListView(
            children: [
              vpad(12),
              mode != 2
                  ? Text(
                      service.name ?? '',
                      style: txtBold(14),
                    )
                  : Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: redColor2,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.cancel, color: Colors.white),
                          Text(
                            S.of(context).cancelled,
                            style: txtRegular(14, Colors.white),
                          ),
                        ],
                      ),
                    ),
              // PrimaryButton(
              //         buttonType: ButtonType.red,
              //         borderRadius: BorderRadius.circular(12),
              //         buttonSize: ButtonSize.medium,
              //         text: S.of(context).cancelled,
              //         icon: Icon(Icons.cancel),
              //       ),
              Divider(
                color: Colors.black,
              ),
              vpad(10),
              Text(
                S.of(context).util_info,
                style: txtBold(14),
              ),
              vpad(10),
              ...listInfo.map(
                (v) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          v.title,
                          style: txtSemiBold(12, grayScaleColor3),
                        ),
                      ),
                      hpad(10),
                      Expanded(
                        flex: 1,
                        child: Text(v.content ?? '', style: txtRegular(12)),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              Text(
                S.of(context).reg_info,
                style: txtBold(14),
              ),
              vpad(10),
              ...listInfoUser.map(
                (v) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          v.title,
                          style: txtSemiBold(12, grayScaleColor3),
                        ),
                      ),
                      hpad(10),
                      Expanded(
                        flex: 1,
                        child: Text(v.content ?? '', style: txtRegular(12)),
                      ),
                    ],
                  ),
                ),
              ),
              vpad(20),
              Container(
                decoration: BoxDecoration(
                  color: grayScaleColor4,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        S.of(context).policy,
                        style: txtRegular(12, primaryColorBase),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        service.note ?? '',
                      ),
                    ),
                    vpad(10),
                  ],
                ),
              ), // PrimaryInfoWidget(listInfoView: listInfoView),
              vpad(20),
              Row(
                children: [
                  Checkbox(
                    value:
                        context.watch<ConfirmBookingServicePrv>().confirm_use,
                    onChanged: (v) {
                      context
                          .read<ConfirmBookingServicePrv>()
                          .toggleConfirmUse();
                    },
                  ),
                  Flexible(
                    child: RichText(
                      text: TextSpan(
                        style: txtBodyMediumBold(
                          color: grayScaleColorBase,
                        ),
                        children: [
                          TextSpan(text: S.of(context).po_1),
                          TextSpan(
                            text: " ${S.of(context).po_2} ",
                            style: txtBodyMediumBold(color: primaryColor6),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                if (service.terms_of_service?[0].id != null) {
                                  await Utils.downloadFile(
                                    url: service.terms_of_service?[0].id,
                                    show: true,
                                    name: service.terms_of_service?[0].name,
                                  );
                                }
                              },
                          ),
                          TextSpan(text: S.of(context).and),
                          TextSpan(
                            text: " ${S.of(context).po_3} ",
                            style: txtBodyMediumBold(color: primaryColor6),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                if (service.rules?[0].id != null) {
                                  await Utils.downloadFile(
                                    url: service.rules?[0].id,
                                    show: true,
                                    name: service.rules?[0].name,
                                  );
                                }
                              },
                          ),
                          TextSpan(
                            text: S.of(context).po_4,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              vpad(16),
              if (mode == 0)
                PrimaryButton(
                  isLoading: loading,
                  onTap: () {
                    context
                        .read<ConfirmBookingServicePrv>()
                        .saveRegisterService(context);
                  },
                  text: S.of(context).confirm,
                  buttonSize: ButtonSize.small,
                  borderRadius: BorderRadius.circular(20),
                ),
              if (mode == 1)
                PrimaryButton(
                  isLoading: loading,
                  onTap: () {
                    context.read<ConfirmBookingServicePrv>().setMode(2);
                  },
                  text: S.of(context).cancel,
                  buttonType: ButtonType.red,
                  buttonSize: ButtonSize.small,
                  borderRadius: BorderRadius.circular(20),
                ),
              if (mode == 2)
                PrimaryButton(
                  isLoading: loading,
                  onTap: () {
                    context.read<ConfirmBookingServicePrv>().setMode(0);
                  },
                  text: S.of(context).re_booking,
                  buttonSize: ButtonSize.small,
                  borderRadius: BorderRadius.circular(20),
                ),
              vpad(40),
            ],
          ),
        );
      },
    );
  }
}
