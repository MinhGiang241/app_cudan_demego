import 'package:app_cudan/constants/constants.dart';
import 'package:app_cudan/models/service_registration.dart';
import 'package:app_cudan/services/api_extra_service.dart';
import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../../../models/extra_service.dart';
import '../../../../utils/utils.dart';
import '../extra_service_card_list.dart';

class ExtraServiceRegistrationPrv extends ChangeNotifier {
  ExtraServiceRegistrationPrv({
    required this.selectedApartmentId,
    required this.arisingServiceId,
    required this.phoneNumber,
    this.residentId,
    this.id,
    this.note,
    this.expiredDateString,
    this.regDateString,
    this.maxDayPay,
    this.codeCycle,
    required this.service,
  }) {
    noteController.text = note ?? '';
    regDateController.text = Utils.dateFormat(regDateString ?? '', 0);
    regDate = DateTime.tryParse(regDateString ?? "") != null
        ? DateTime.parse(regDateString!)
        : null;
    expiredDate = DateTime.tryParse(expiredDateString ?? "") != null
        ? DateTime.parse(expiredDateString!)
        : null;
    expiredDateController.text = Utils.dateFormat(expiredDateString ?? '', 0);
  }
  List<Pay> payList = [];
  final TextEditingController regDateController = TextEditingController();
  final TextEditingController expiredDateController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? note;
  String? regDateString;
  String? expiredDateString;
  int? month;
  int? maxDayPay;
  Pay? chosenCycle;
  String? codeCycle;
  DateTime? regDate;
  DateTime? expiredDate;
  bool isAddNewLoading = false;
  bool isSendApproveLoading = false;
  String selectedApartmentId;
  String? id;
  final String arisingServiceId;
  final String phoneNumber;
  final ExtraService service;
  String? residentId;

  onChangeMaxPayDate(BuildContext context, v) {
    maxDayPay = v;
    notifyListeners();
  }

  onChooseApartment(BuildContext context, v) {
    selectedApartmentId = v;
    notifyListeners();
  }

  onSendSummit(BuildContext context, bool isRequest) async {
    FocusScope.of(context).unfocus();

    if (isRequest) {
      isSendApproveLoading = true;
    } else {
      isAddNewLoading = true;
    }
    notifyListeners();
    if (formKey.currentState!.validate()) {
      try {
        var listError = [];
        if (regDate == null) {
          listError.add(S.of(context).reg_day_not_empty);
        }
        if (month == null) {
          listError.add(S.of(context).payment_cycle_not_empty);
        }
        if (listError.isNotEmpty) {
          throw (listError.join(',  '));
        }

        var registerService = ServiceRegistration(
            people: residentId != null ? "resident" : "quest",
            residentId: residentId,
            isMobile: true,
            status: isRequest ? "WAIT" : "NEW",
            apartmentId: selectedApartmentId,
            arisingServiceId: arisingServiceId,
            registration_date: regDate!.toIso8601String(),
            expiration_date: expiredDate!.toIso8601String(),
            id: id,
            paymentCycle: codeCycle,
            phoneNumber: phoneNumber,
            maximum_day: maxDayPay,
            note: noteController.text.trim());

        await APIExtraService.saveRegistrationService(registerService.toJson())
            .then((e) {
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
                  arguments: service);
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
      notifyListeners();
    }
  }

  onSelectPaymentCycle(context, v) {
    chosenCycle = payList.firstWhere((element) => element.code == v);
    if (chosenCycle != null) {
      codeCycle = chosenCycle!.code;
      month = chosenCycle!.month ?? 0;
    }
    if (regDateController.text.isNotEmpty && month != null) {
      expiredDate = DateTime(regDate!.year, regDate!.month + month!,
          regDate!.day - (month == 0 ? 0 : 1));
      expiredDateController.text =
          Utils.dateFormat(expiredDate!.toIso8601String(), 0);
    }

    notifyListeners();
  }

  onTapExpiredDate(BuildContext context) {
    if (month == null || regDateController.text.isEmpty) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 1),
          backgroundColor: primaryColorBase,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Text(S.of(context).need_choose_cylce_regdate)));
    }
  }

  pickRegDate(context) async {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 10, 1, 1),
      lastDate: DateTime(DateTime.now().year + 10, 1, 1),
    ).then((v) {
      if (v != null) {
        regDateController.text = Utils.dateFormat(v.toIso8601String(), 0);
        regDate = v;
        if (month != null) {
          expiredDate = DateTime(
              regDate!.year, regDate!.month + month!, regDate!.day - 1);

          expiredDateController.text =
              Utils.dateFormat(expiredDate!.toIso8601String(), 0);
        }
      }
      notifyListeners();
    });
  }

  getPaymentCycle(BuildContext context) async {
    await APIExtraService.getPaymentCycle().then((v) {
      payList.clear();
      for (var i in v) {
        payList.add(Pay.fromJson(i));
      }
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }
}
