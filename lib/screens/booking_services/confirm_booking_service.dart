import 'package:app_cudan/generated/l10n.dart';
import 'package:app_cudan/models/info_content_view.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/utils/utils.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_button.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../models/area.dart';
import '../../models/booking_service.dart';
import 'booking_services_screen.dart';
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
  String genTicketTypeString(String type) {
    switch (type.trim()) {
      case "price_child":
        return S.current.child_ticket_num;
      case "price_adult":
        return S.current.adult_ticket_num;
      case "price_child_weekend":
        return S.current.weekend_child_ticket_num;
      case "price_adult_weekend":
        return S.current.weekend_aldult_ticket_num;
      default:
        return '';
    }
  }

  final formatCurrency = NumberFormat.simpleCurrency(locale: "vi");

  countFeeMonth(List<BookingInfo>? bookinfo) {
    if (bookinfo != null) {
      var b = bookinfo.fold(0.0, (pre, el) {
        var a = (el.num_adult ?? 0.0) * (el.price_adult ?? 0.0) +
            (el.num_child ?? 0.0) * (el.price_child ?? 0.0) +
            (el.num_adult_weekend ?? 0.0) * (el.price_adult_weekend ?? 0.0) +
            (el.num_child_weekend ?? 0.0) * (el.price_child_weekend ?? 0);
        return a;
      });
      return b;
    }
  }

  // countFeeMonthMode0() {
  //   F
  //   return 0;
  // }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map?;

    return ChangeNotifierProvider(
      create: (context) => ConfirmBookingServicePrv(
        oldContext: context,
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
        bookingRegistration: arg?['register'] as RegisterBookingService?,
        guestAddress: arg?["guest-address"] as String?,
      ),
      builder: (context, builder) {
        var isResident =
            context.read<ResidentInfoPrv>().selectedApartment != null;
        //&& context.read<ResidentInfoPrv>().residentId != null;
        var service = context.read<ConfirmBookingServicePrv>().service;
        var time_start = context.read<ConfirmBookingServicePrv>().time_start;
        var time_end = context.read<ConfirmBookingServicePrv>().time_end;
        var area = context.read<ConfirmBookingServicePrv>().area;
        var dateString = context.read<ConfirmBookingServicePrv>().dateString;
        var sh = context.read<ConfirmBookingServicePrv>().shelfLife;
        var num = context.read<ConfirmBookingServicePrv>().num;
        var address = context.read<ConfirmBookingServicePrv>().guestAddress;
        var mode = context.watch<ConfirmBookingServicePrv>().mode;
        var loading = context.watch<ConfirmBookingServicePrv>().loading;
        var reg = context.watch<ConfirmBookingServicePrv>().bookingRegistration;
        var guestFee = context.watch<ConfirmBookingServicePrv>().guestFee;
        var residentFee = context.watch<ConfirmBookingServicePrv>().residentFee;
        var configGuest = context.watch<ConfirmBookingServicePrv>().configGuest;
        var configResident =
            context.watch<ConfirmBookingServicePrv>().configResident;
        var numReg, numGuest;
        if (reg?.registration_type == 'month') {
          if (reg?.object == 'resident') {
            numReg = reg?.total_num_ticket ?? 1;
          }

          if (reg?.object != 'resident') {
            numGuest = reg?.total_num_ticket ?? 1;
          }
        } else {
          var numRegIndex =
              reg?.booking_info?.indexWhere((c) => c.object == 'resident');
          var numGuestIndex =
              reg?.booking_info?.indexWhere((c) => c.object == 'guest');
          if (numRegIndex != null && numRegIndex != -1) {
            numReg = service.ticket_type == 'ageclassified'
                ? (reg?.booking_info?[numRegIndex].num_adult)
                : (reg?.booking_info?[numRegIndex].num);
          }
          if (numGuestIndex != null && numGuestIndex != -1) {
            // service.service_charge =='nocharge'
            numGuest = (service.ticket_type == 'ageclassified')
                ? (reg?.booking_info?[numGuestIndex].num_adult)
                : (reg?.booking_info?[numGuestIndex].num);
          }
        }

        List<InfoContentView> listInfo = [
          InfoContentView(
            title: S.of(context).util_type,
            content: service.name ?? '',
          ),
          InfoContentView(
            title: S.of(context).zone,
            content: area.name ?? '',
          ),
          if (numReg != null &&
              service.service_charge == "nocharge" &&
              reg?.registration_type == "turn")
            InfoContentView(
              title: S.of(context).resident_ticket_amount,
              content: '${numReg}',
            ),
          if (numGuest != null &&
              service.service_charge == "nocharge" &&
              reg?.registration_type == "turn")
            InfoContentView(
              title: S.of(context).guest_ticket_amount,
              content: '${numGuest}',
            ),
          if (reg?.registration_type == 'turn')
            InfoContentView(
              title: S.of(context).booking_time,
              content:
                  '${Utils.dateFormat(reg?.use_date ?? dateString, 1)} ${reg?.time_slot ?? "${time_start} - ${time_end}"}',
            ),
          if (reg?.registration_type == 'month')
            InfoContentView(
              title: S.of(context).expired_reg,
              content: mode == 0
                  ? "${sh?.shelfLife?.use_time} ${genShelifeString(sh?.shelfLife?.type_time)}"
                  : "${reg?.sh?.use_time} ${genShelifeString(reg?.sh?.type_time)}",
            ),
          if (reg?.registration_type == 'month')
            InfoContentView(
              title: S.of(context).time_slot,
              content: '${reg?.time_slot ?? "${time_start} - ${time_end}"}',
            ),
          if (reg?.registration_type == 'month')
            InfoContentView(
              title: S.of(context).begin_use_date,
              content: Utils.dateFormat(reg?.use_date ?? '', 1),
            ),
          if (reg?.registration_type == 'month')
            InfoContentView(
              title: S.of(context).end_use_date,
              content: Utils.dateFormat(reg?.end_date ?? '', 1),
            ),
          if (reg?.registration_type == 'month')
            InfoContentView(
              title: S.of(context).reg_fee,
              content: mode == 0
                  ? service.service_charge == 'nocharge'
                      ? formatCurrency.format(0)
                      : formatCurrency.format(
                          isResident
                              ? (sh?.price_resident ?? 0)
                              : (sh?.price_guest ?? 0),
                        )
                  : formatCurrency.format(reg?.total_price ?? 0),
            ),
          // if (mode != 0 && reg != null)
          //   InfoContentView(
          //     title: S.of(context).reg_code,
          //     content: reg.code,
          //   ),
        ];
        var resident = context.read<ResidentInfoPrv>().userInfo;
        var apartment = context.read<ResidentInfoPrv>().selectedApartment;
        List<InfoContentView> listInfoUser = [
          InfoContentView(
            title: S.of(context).registing_persion,
            content: resident?.info_name,
          ),
          if (reg?.object == 'resident')
            InfoContentView(
              title: S.of(context).apartment_code,
              content: (mode != 0)
                  ? "${reg?.ap?.name}-${reg?.ap?.f?.name}-${reg?.ap?.b?.name}"
                  : "${apartment?.apartment?.name}-${apartment?.floor?.name}-${apartment?.building?.name}",
            ),
          if (reg?.object == 'guest')
            InfoContentView(
              title: S.of(context).address,
              content: mode == 0 ? address : reg?.address,
            ),
          InfoContentView(
            title: S.of(context).phone_num,
            content: reg?.phone_number ?? '',
          ),
          if (mode != 0 && reg != null)
            InfoContentView(
              title: S.of(context).reg_code,
              content: reg.code,
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
              // if (!((mode == 1 && reg?.status == "USED") ||
              //     (mode == 2 && reg?.status == "CANCEL")))
              if (mode == 0)
                Text(
                  service.name ?? '',
                  style: txtBold(14),
                ),
              if (mode == 2 && reg?.status == "CANCEL")
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: redColor4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.cancel_outlined, color: redColorBase),
                      hpad(10),
                      Text(
                        S.of(context).cancelled,
                        style: txtRegular(14, redColorBase),
                      ),
                    ],
                  ),
                ),
              if (mode == 1)
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: genBookingStatusColor(reg?.status).withOpacity(.4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        genBookingStatus(reg?.status),
                        style: txtRegular(
                          14,
                          genBookingStatusColor(reg?.status),
                        ),
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

              if (configResident != null)
                Divider(
                  color: Colors.black,
                ),
              if (configResident != null) vpad(10),
              if (configResident != null)
                Text(
                  S.of(context).resident_ticket,
                  style: txtBold(12, primaryColorBase),
                ),
              if (configResident != null) vpad(6),
              if (configResident != null)
                ...configResident.entries
                    .where(
                      (element) => element.value != 0 && element.value != null,
                    )
                    .map(
                      (s) => Padding(
                        padding: EdgeInsets.only(bottom: 6),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    genTicketTypeString(s.key),
                                    style: txtSemiBold(12, grayScaleColor3),
                                  ),
                                ),
                                hpad(10),
                                Expanded(
                                  flex: 1,
                                  child:
                                      Text('${s.value}', style: txtRegular(12)),
                                ),
                                // Expanded(child: Text('${s.value}',),),
                              ],
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "${S.of(context).ticket_price} : ${formatCurrency.format(residentFee?.toMap()[s.key])}",
                                style: txtRegular(11),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

              if (configGuest != null)
                Divider(
                  color: Colors.black,
                ),
              if (configGuest != null) vpad(10),
              if (configGuest != null)
                Text(
                  S.of(context).guest_ticket,
                  style: txtBold(12, primaryColorBase),
                ),
              if (configGuest != null) vpad(6),
              if (configGuest != null)
                ...configGuest.entries
                    .where(
                      (element) => element.value != 0 && element.value != null,
                    )
                    .map(
                      (s) => Padding(
                        padding: EdgeInsets.only(bottom: 6),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    genTicketTypeString(s.key),
                                    style: txtSemiBold(12, grayScaleColor3),
                                  ),
                                ),
                                hpad(10),
                                Expanded(
                                  flex: 1,
                                  child:
                                      Text('${s.value}', style: txtRegular(12)),
                                ),
                                // Expanded(child: Text('${s.value}',),),
                              ],
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "${S.of(context).ticket_price} : ${formatCurrency.format(guestFee?.toMap()[s.key])}",
                                style: txtRegular(11),
                              ),
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
                    vpad(12),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Text(
                    //     '',
                    //     //  S.of(context).policy,
                    //     style: txtRegular(12, primaryColorBase),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        service.note ?? '',
                      ),
                    ),
                    vpad(10),
                  ],
                ),
              ),

              // PrimaryInfoWidget(listInfoView: listInfoView),
              vpad(20),
              Row(
                children: [
                  Checkbox(
                    activeColor: mode == 0 ? primaryColorBase : grayScaleColor3,
                    value: mode != 0
                        ? reg?.agree_to_terms_of_service
                        : context.watch<ConfirmBookingServicePrv>().confirm_use,
                    onChanged: (v) {
                      if (mode == 0) {
                        context
                            .read<ConfirmBookingServicePrv>()
                            .toggleConfirmUse();
                      }
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
                                    context: context,
                                    id: service.terms_of_service?[0].id,
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
                                    context: context,
                                    id: service.rules?[0].id,
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
              if (mode == 1 && (reg?.status == 'WAIT_USE'))
                PrimaryButton(
                  isLoading: loading,
                  onTap: () {
                    context
                        .read<ConfirmBookingServicePrv>()
                        .onCancelService(context);
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
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      BookingServicesScreen.routeName,
                      (route) => route.isFirst,
                    );
                  },
                  text: S.of(context).re_booking,
                  buttonSize: ButtonSize.small,
                  borderRadius: BorderRadius.circular(20),
                ),
              if (mode == 1 && reg?.status == 'USED')
                PrimaryButton(
                  buttonType: ButtonType.orange,
                  isLoading: loading,
                  onTap: () {
                    // Navigator.of(context).pushReplacementNamed(
                    //   SelectBookingServiceScreen.routeName,
                    //   arguments: {'service': service},
                    // );
                  },
                  text: S.of(context).judge,
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
