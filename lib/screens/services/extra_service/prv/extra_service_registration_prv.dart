import 'package:app_cudan/models/service_registration.dart';
import 'package:app_cudan/models/transportation_card.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/services/api_extra_service.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../../../../models/extra_service.dart';
import '../../../../utils/utils.dart';
import '../extra_service_card_list.dart';

class ExtraServiceRegistrationPrv extends ChangeNotifier {
  ExtraServiceRegistrationPrv({
    required this.selectedApartmentId,
    required this.arisingServiceId,
    this.phoneNumber,
    this.residentId,
    this.id,
    this.note,
    this.expiredDateString,
    this.regDateString,
    this.maxDayPay,
    this.code,
    this.shelfLifeId,
    this.month,
    this.codeCycle,
    this.payList = const [],
    required this.service,
  }) {
    noteController.text = note ?? '';
    regDateController.text = Utils.dateFormat(regDateString ?? '', 1);
    regDate = DateTime.tryParse(regDateString ?? '') != null
        ? DateTime.parse(regDateString!).add(const Duration(hours: 7))
        : null;
    expiredDate = DateTime.tryParse(expiredDateString ?? '') != null
        ? DateTime.parse(expiredDateString!).add(const Duration(hours: 7))
        : null;

    expiredDateController.text =
        Utils.dateFormat(expiredDate?.toIso8601String() ?? '', 1);
    if (payList.isEmpty) {
      maxDayPay = 1;
    } else if (shelfLifeId != null && payList.isNotEmpty) {
      var s = payList.firstWhere((element) => element.id == shelfLifeId);
      codeCycle = s.code;
    }
  }
  List<Pay> payList;
  List<ShelfLife> shelfLifeList = [];
  final TextEditingController regDateController = TextEditingController();
  final TextEditingController expiredDateController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? note;
  String? regDateString;
  String? expiredDateString;
  int? month;
  int? maxDayPay;
  Pay? chosenCycle;
  DateTime? regDate;
  DateTime? expiredDate;
  bool isAddNewLoading = false;
  bool isSendApproveLoading = false;
  String selectedApartmentId;
  String? codeCycle;
  String? id;
  String? code;
  final String arisingServiceId;
  final String? phoneNumber;
  final ExtraService service;
  String? residentId;
  String? shelfLifeId;

  String? apartValidate;
  String? addressValidate;
  String? shelfValidate;
  String? maxDayValidate;
  String? regDateValidate;

  bool autoValid = false;

  validate(BuildContext context) {
    if (formKey.currentState!.validate()) {
    } else {
      genValidate();
    }

    notifyListeners();
  }

  clearValidate() {
    apartValidate = null;
    shelfValidate = null;
    maxDayValidate = null;
    regDateValidate = null;
    addressValidate = null;
    notifyListeners();
  }

  genValidate() {
    if (regDateController.text.trim().isEmpty) {
      regDateValidate = S.current.not_blank;
    } else {
      regDateValidate = null;
    }
    // ignore: unnecessary_null_comparison
    if (selectedApartmentId == null) {
      apartValidate = S.current.not_blank;
    } else {
      apartValidate = null;
    }
    if (addressController.text.trim().isEmpty) {
      addressValidate = S.current.not_blank;
    } else {
      addressValidate = null;
    }
    if (shelfLifeId == null) {
      shelfValidate = S.current.not_blank;
    } else {
      shelfValidate = null;
    }
    if (maxDayPay == null) {
      maxDayValidate = S.current.not_blank;
    } else {
      maxDayValidate = null;
    }
    notifyListeners();
  }

  onChangeMaxPayDate(BuildContext context, v) {
    maxDayPay = v;
    maxDayValidate = null;

    notifyListeners();
  }

  onChooseApartment(BuildContext context, v) {
    selectedApartmentId = v;
    apartValidate = null;
    notifyListeners();
  }

  onSendSummit(BuildContext context, bool isRequest) async {
    var userInfo = context.read<ResidentInfoPrv>().userInfo;
    var isRes = context.read<ResidentInfoPrv>().residentId != null &&
        context.read<ResidentInfoPrv>().selectedApartment != null;
    FocusScope.of(context).unfocus();
    autoValid = true;
    if (isRequest) {
      isSendApproveLoading = true;
    } else {
      isAddNewLoading = true;
    }
    notifyListeners();
    if (formKey.currentState!.validate()) {
      clearValidate();
      try {
        var now = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          0,
        );
        var listError = [];
        if (regDate == null) {
          listError.add(S.of(context).reg_day_not_empty);
        } else if (regDate!.compareTo(now) < 0) {
          listError.add(S.of(context).reg_date_not_after_now);
        }
        if (payList.isNotEmpty && month == null) {
          listError.add(S.of(context).payment_cycle_not_empty);
        }

        if (maxDayPay == null && payList.isNotEmpty) {
          listError.add(S.of(context).max_pay_day_not_empty);
        }
        if (listError.isNotEmpty) {
          throw (listError.join(',  '));
        }

        var expiredDateString =
            (expiredDate!.subtract(const Duration(hours: 7))).toIso8601String();

        var registerService = ServiceRegistration(
          people: isRes ? 'resident' : 'guest',
          residentId: residentId,
          isMobile: true,
          code: code,
          status: isRequest ? 'WAIT' : 'NEW',
          apartmentId: selectedApartmentId,
          arisingServiceId: arisingServiceId,
          registration_date: id != null
              ? (regDate!).toIso8601String()
              : (regDate!).toIso8601String(),
          expiration_date: expiredDateString,
          id: id,
          phoneNumber: (phoneNumber) ??
              (isRes
                  ? userInfo?.account?.phone
                  : userInfo?.account?.phone ?? userInfo?.account?.userName),
          maximum_day: maxDayPay,
          shelfLifeId: shelfLifeId,
          customer_address: isRes ? null : addressController.text.trim(),
          note: noteController.text.trim(),
          customer_name: !isRes
              ? userInfo?.account?.fullName ?? userInfo?.account?.userName
              : null,
        );

        await APIExtraService.saveRegistrationService(
          registerService.toJson(),
          id != null,
        ).then((e) {
          if (isRequest) {
            isSendApproveLoading = false;
          } else {
            isAddNewLoading = false;
          }
          notifyListeners();
          Utils.showSuccessMessage(
            context: context,
            e: isRequest
                ? S.of(context).success_send_req
                : id != null
                    ? S.of(context).success_edit
                    : S.of(context).success_cr_new,
            onClose: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                ExtraServiceCardListScreen.routeName,
                (route) => route.isFirst,
                arguments: {
                  'service': service,
                  'year': regDate!.year,
                  'month': regDate!.month
                },
              );
            },
          );
        }).catchError((e) {
          throw (e);
        });
      } catch (e) {
        Utils.showErrorMessage(context, e.toString());
        if (isRequest) {
          isSendApproveLoading = false;
        } else {
          isAddNewLoading = false;
        }
        notifyListeners();
      }
    } else {
      if (isRequest) {
        isSendApproveLoading = false;
      } else {
        isAddNewLoading = false;
      }
      genValidate();

      notifyListeners();
    }
  }

  onSelectPaymentCycle(context, v) {
    chosenCycle = payList.firstWhereOrNull((element) => element.id == v);
    if (chosenCycle != null) {
      codeCycle = chosenCycle!.code;
      shelfLifeId = chosenCycle!.id;
      month = chosenCycle!.use_time ?? 0;
      if (chosenCycle!.code == 'KHONGCO') {
        maxDayPay = 1;
      }
    }
    shelfValidate = null;
    if (regDateController.text.isNotEmpty && month != null) {
      switch (chosenCycle!.type_time) {
        case 'Ngày':
          expiredDate =
              DateTime(regDate!.year, regDate!.month, regDate!.day + month!);
          break;
        case 'Tháng':
          expiredDate =
              DateTime(regDate!.year, regDate!.month + month!, regDate!.day);
          break;
        case 'Năm':
          expiredDate =
              DateTime(regDate!.year + month!, regDate!.month, regDate!.day);
          break;
        default:
          expiredDate = DateTime(regDate!.year, regDate!.month, regDate!.day);
          break;
      }
      expiredDateController.text =
          Utils.dateFormat(expiredDate!.toIso8601String(), 0);
    } else {
      expiredDate = regDate;
    }

    notifyListeners();
  }

  onTapExpiredDate(BuildContext context) {
    if (month == null || regDateController.text.isEmpty) {
      Utils.showSnackBar(context, S.of(context).need_choose_cylce_regdate);
      // ScaffoldMessenger.of(context).hideCurrentSnackBar();
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     duration: const Duration(seconds: 1),
      //     backgroundColor: primaryColorBase,
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(12),
      //     ),
      //     content: Text(S.of(context).need_choose_cylce_regdate),
      //   ),
      // );
    }
  }

  pickRegDate(context) async {
    Utils.showDatePickers(
      context,
      initDate: regDate ?? DateTime.now(),
      startDate: DateTime(DateTime.now().year - 10, 1, 1),
      endDate: DateTime(DateTime.now().year + 10, 1, 1),
    )
        // showDatePicker(
        //   context: context,
        //   initialDate: DateTime.now(),
        //   firstDate: DateTime(DateTime.now().year - 10, 1, 1),
        //   lastDate: DateTime(DateTime.now().year + 10, 1, 1),
        // )
        .then((v) {
      if (v != null) {
        regDateController.text = Utils.dateFormat(v.toIso8601String(), 0);
        regDate = v;
        regDateValidate = null;
        if (month != null && payList.isNotEmpty) {
          //  if(chosenCycle!.type_time == "Ngày"){}else if(){}
          switch (chosenCycle!.type_time) {
            case 'Ngày':
              expiredDate = DateTime(
                regDate!.year,
                regDate!.month,
                regDate!.day + month!,
              );
              break;
            case 'Tháng':
              expiredDate = DateTime(
                regDate!.year,
                regDate!.month + month!,
                regDate!.day,
              );
              break;
            case 'Năm':
              expiredDate = DateTime(
                regDate!.year + month!,
                regDate!.month,
                regDate!.day,
              );
              break;
            default:
              expiredDate =
                  DateTime(regDate!.year, regDate!.month, regDate!.day);
              break;
          }

          expiredDateController.text =
              Utils.dateFormat(expiredDate!.toIso8601String(), 0);
        } else {
          expiredDate = regDate;
        }
      }
      notifyListeners();
    });
  }

  getPaymentCycle(BuildContext context) async {
    await APIExtraService.getPaymentCycle(arisingServiceId).then((v) {
      shelfLifeList.clear();
      for (var i in v) {
        shelfLifeList.add(ShelfLife.fromMap(i));
      }
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }
}
