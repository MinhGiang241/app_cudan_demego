import 'package:app_cudan/generated/l10n.dart';
import 'package:app_cudan/models/info_content_view.dart';
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
  var agree = false;
  var mode = 1;
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
      ),
      builder: (context, builder) {
        var service = context.read<ConfirmBookingServicePrv>().service;
        var time_start = context.read<ConfirmBookingServicePrv>().time_start;
        var time_end = context.read<ConfirmBookingServicePrv>().time_end;
        var area = context.read<ConfirmBookingServicePrv>().area;
        var dateString = context.read<ConfirmBookingServicePrv>().dateString;
        var num = context.read<ConfirmBookingServicePrv>().num;
        var mode = context.watch<ConfirmBookingServicePrv>().mode;
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
            content: '${area.sg ?? 0}',
          ),
          InfoContentView(
            title: S.of(context).booking_time,
            content:
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
              Text(
                service.name ?? '',
                style: txtBold(14),
              ),
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
                  children: [
                    Text(
                      S.of(context).policy,
                    ),
                  ],
                ),
              ), // PrimaryInfoWidget(listInfoView: listInfoView),
              vpad(20),
              Row(
                children: [
                  Checkbox(
                    value: agree,
                    onChanged: (v) {
                      setState(() {
                        agree = !agree;
                      });
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
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                          TextSpan(text: S.of(context).and),
                          TextSpan(
                            text: " ${S.of(context).po_3} ",
                            style: txtBodyMediumBold(color: primaryColor6),
                            recognizer: TapGestureRecognizer()..onTap = () {},
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
                  onTap: () {
                    context.read<ConfirmBookingServicePrv>().setMode(1);
                  },
                  text: S.of(context).confirm,
                  buttonSize: ButtonSize.small,
                  borderRadius: BorderRadius.circular(20),
                ),
              if (mode == 1)
                PrimaryButton(
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
