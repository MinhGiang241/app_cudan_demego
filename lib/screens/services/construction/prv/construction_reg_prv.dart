// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:app_cudan/models/receipt.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/services/api_construction.dart';
import 'package:app_cudan/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/regex_text.dart';
import '../../../../generated/l10n.dart';
import '../../../../models/construction.dart';
import '../../../../models/fiexed_date_service.dart';
import '../../../../services/api_auth.dart';
import '../../../payment/widget/payment_item.dart';
import '../construction_list_screen.dart';

class ConstructionRegPrv extends ChangeNotifier {
  ConstructionRegPrv({this.existedConReg}) {
    if (existedConReg != null) {
      isAgree = existedConReg!.confirm ?? true;
      existedCurrentDrawings = existedConReg!.current_draw ?? [];
      existedRenewDrawings = existedConReg!.renovation_draw ?? [];
      selectedApartment = existedConReg!.apartmentId;
      selectedConstype = existedConReg!.constructionTypeId;
      surfaceController.text = existedConReg!.apartmentId ?? '';
      consTypeController.text = existedConReg!.constructionTypeId ?? '';
      regDateController.text =
          Utils.dateFormat(existedConReg!.create_date ?? "", 1);
      startTimeController.text =
          Utils.dateFormat(existedConReg!.time_start ?? "", 1);
      endTimeController.text =
          Utils.dateFormat(existedConReg!.time_end ?? "", 1);
      consFeeController.text =
          formatCurrency.format(existedConReg!.construction_cost ?? 0);
      depositController.text =
          formatCurrency.format(existedConReg!.deposit_fee ?? 0);
      workDayController.text = existedConReg!.working_day.toString();
      offDayController.text = existedConReg!.off_day.toString();
      describeController.text = existedConReg!.description ?? "";
      consUnitController.text = existedConReg!.construction_unit ?? "";
      addressController.text = existedConReg!.construction_add ?? "";
      deputyController.text = existedConReg!.deputy ?? "";
      phoneController.text = existedConReg!.deputy_phone ?? "";
      identityController.text = existedConReg!.deputy_identity ?? "";
      workerNumController.text = existedConReg!.worker_num.toString();
      emailController.text = existedConReg!.construction_email ?? "";
      regDate = DateTime.tryParse(existedConReg!.create_date ?? "") != null
          ? DateTime.parse(existedConReg!.create_date!)
              .add(const Duration(hours: 7))
          : null;
      startTime = DateTime.tryParse(existedConReg!.time_start ?? "") != null
          ? DateTime.parse(existedConReg!.time_start!)
              .add(const Duration(hours: 7))
          : null;
      endTime = DateTime.tryParse(existedConReg!.time_end ?? "") != null
          ? DateTime.parse(existedConReg!.time_end!)
              .add(const Duration(hours: 7))
          : null;
      isPaidFee = existedConReg!.isContructionCost ?? false;
      isPaidDeposit = existedConReg!.isDepositFee ?? false;
      fee = existedConReg!.construction_cost ?? 0;
      depositFee = existedConReg!.deposit_fee ?? 0;
      workday = existedConReg!.working_day ?? 0;
      offday = existedConReg!.off_day ?? 0;
    } else {
      initNew = false;
      regDate = DateTime.now();
      regDateController.text = Utils.dateFormat(regDate!.toIso8601String(), 0);
    }
  }

  bool initNew = true;
  bool autoValidStep1 = false;
  bool autoValidStep2 = false;
  FixedDateService? fixedDateService;
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  ConstructionRegistration? existedConReg = ConstructionRegistration();
  DayOff? dayoff;
  bool isDisableRightCroll = true;
  int activeStep = 0;
  List<ConstructionType> listConstructionType = [];
  final PageController controller = PageController();

  List<ConstructionFile> existedCurrentDrawings = [];
  List<ConstructionFile> existedRenewDrawings = [];

  List<File> currentDrawings = [];
  List<File> renewDrawings = [];

  List<ConstructionFile> uploadedCurrentDrawings = [];
  List<ConstructionFile> uploadedRenewDrawings = [];

  String? selectedApartment;
  String? selectedConstype;

  final TextEditingController surfaceController = TextEditingController();
  final TextEditingController consTypeController = TextEditingController();
  final TextEditingController regDateController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  final TextEditingController consFeeController = TextEditingController();
  final TextEditingController depositController = TextEditingController();
  final TextEditingController workDayController = TextEditingController();
  final TextEditingController offDayController = TextEditingController();
  final TextEditingController describeController = TextEditingController();

  final TextEditingController consUnitController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController deputyController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController identityController = TextEditingController();
  final TextEditingController workerNumController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  String? validateSurface;
  String? validateConsType;
  String? validateRegDate;
  String? validateStartTime;
  String? validateEndTime;
  String? validateDescribe;
  String? validateEmail;

  String? validateConsUnit;
  String? validateAddress;
  String? validateDeputy;
  String? validatePhone;
  String? validateIdentity;
  String? validateWorkerNum;

  DateTime? regDate;
  DateTime? startTime;
  DateTime? endTime;

  bool isPaidFee = false;
  bool isPaidDeposit = false;
  bool isAgree = true;

  bool isStep1Loading = false;
  bool isStep2Loading = false;
  bool isAddNewLoading = false;
  bool isSendApproveLoading = false;

  double? fee = 0;
  double? depositFee = 0;
  int? workday;
  int? offday;

  validate1(BuildContext context) {
    if (formKey1.currentState!.validate()) {
      clearValidStringStep1();
    } else {
      genValidStep1();
    }

    notifyListeners();
  }

  validate2(BuildContext context) {
    if (formKey2.currentState!.validate()) {
      clearValidStringStep2();
    } else {
      genValidStep2();
    }

    notifyListeners();
  }

  onSendSubmit(BuildContext context, bool isRequest) async {
    if (isRequest) {
      isSendApproveLoading = true;
    } else {
      isAddNewLoading = true;
    }
    notifyListeners();
    try {
      var resident = context.read<ResidentInfoPrv>().userInfo;
      var residentId = context.read<ResidentInfoPrv>().residentId;
      var apartment = context.read<ResidentInfoPrv>().listOwn.firstWhere((e) {
        return e.apartment!.id == selectedApartment;
      });
      var consType = listConstructionType.firstWhere((e) {
        return e.id == selectedConstype;
      });
      var listError = [];
      if (existedCurrentDrawings.isEmpty && currentDrawings.isEmpty) {
        listError.add(S.of(context).existed_drawing_not_empty);
      }
      if (existedRenewDrawings.isEmpty && renewDrawings.isEmpty) {
        listError.add(S.of(context).renew_drawing_not_empty);
      }
      // if (formKey1.currentState!.validate() &&
      //     formKey2.currentState!.validate()) {
      //   listError.add(S.of(context).invalid_data);
      // }
      if (!isAgree) {
        listError.add(S.of(context).cons_agree);
      }
      if (listError.isNotEmpty) {
        throw (listError.join(',  '));
      }
      await uploadCurrentDrawing(context).then((v) {
        return uploadRenewDrawing(context);
      }).then((v) {
        if (!initNew) {
          regDate = DateTime.now();
        }
        ConstructionRegistration conReg = ConstructionRegistration(
          id: existedConReg != null ? existedConReg!.id : null,
          code: existedConReg != null ? existedConReg!.code : null,
          apartmentId: selectedApartment != null ? apartment.apartmentId : null,
          confirm: isAgree,
          isMobile: true,
          isContructionCost: isPaidFee,
          isDepositFee: isPaidDeposit,
          construction_cost: fee,
          constructionTypeId: selectedConstype,
          construction_unit: consUnitController.text.trim(),
          deputy: deputyController.text.trim(),
          deputy_phone: phoneController.text.trim(),
          construction_add: addressController.text.trim(),
          construction_email: emailController.text.trim(),
          create_date: (regDate)!.toIso8601String(),
          description: describeController.text.trim(),
          deposit_fee: depositFee,
          deputy_identity: identityController.text.trim(),
          off_day: offday,
          residentId: context.read<ResidentInfoPrv>().residentId,
          current_draw: existedCurrentDrawings + uploadedCurrentDrawings,
          renovation_draw: existedRenewDrawings + uploadedRenewDrawings,
          resident_code: resident!.code,
          resident_identity: resident.identity_card,
          status: isRequest
              ? (apartment.type == "BUY" || apartment.type == "RENT")
                  ? "WAIT_PAY"
                  : "WAIT_OWNER"
              : "NEW",
          working_day: workday,
          worker_num: int.tryParse(workerNumController.text.trim()) != null
              ? int.parse(workerNumController.text.trim())
              : null,
          resident_name: resident.info_name,
          resident_phone: resident.phone_required,
          time_start:
              (startTime!.add(const Duration(hours: 7))).toIso8601String(),
          time_end: (endTime!.add(const Duration(hours: 7))).toIso8601String(),
          //   // resident_relationship: apartment.type,
          construction_type_name: consType.name ?? "",
        );
        ConstructionHistory? conHis;
        if (existedConReg != null) {
          conHis = ConstructionHistory(
            constructionregistrationId:
                existedConReg != null ? existedConReg!.id : null,
            date: DateTime.now().toIso8601String(),
            residentId: residentId,
            person: resident.info_name,
            status: isRequest
                ? (apartment.type == "BUY" || apartment.type == "RENT")
                    ? "WAIT_PAY"
                    : "WAIT_OWNER"
                : "NEW",
          );
          // return APIConstruction.saveNewConstructionRegistration();
        }
        List<Map<String, dynamic>> listReceipt = [];

        if (!isPaidFee && isRequest) {
          Receipt? receiptFee = Receipt(
              payment: fixedDateService!.cut_service_date ?? 0,
              residentId: residentId,
              phone: resident.phone_required,
              refSchema: "ConstructionRegistration",
              discount_money: fee,
              type: "ContructionCost",
              payment_status: "UNPAID",
              amount_due: fee,
              apartmentId: apartment.apartmentId,
              check: true,
              content: "Thanh toán phí thi công ",
              reason: "Thanh toán phí thi công",
              customer_type: "RESIDENT",
              full_name: resident.info_name,
              receipts_status: "NEW",
              expiration_date: DateTime.now()
                  .add(Duration(
                      days: fixedDateService != null
                          ? fixedDateService!.cut_service_date ?? 0
                          : 0))
                  .toIso8601String(),
              date: DateTime.now().toIso8601String());
          listReceipt.add(receiptFee.toJson());
        }

        if (!isPaidDeposit && isRequest) {
          Receipt? receiptDeposiy = Receipt(
            payment: fixedDateService!.cut_service_date ?? 0,
            residentId: residentId,
            phone: resident.phone_required,
            discount_money: depositFee,
            refSchema: "ConstructionRegistration",
            type: "DepositFee",
            payment_status: "UNPAID",
            amount_due: depositFee,
            apartmentId: apartment.apartmentId,
            check: true,
            reason: "Thanh toán phí đặt cọc thi công",
            content: "Thanh toán phí đặt cọc thi công",
            customer_type: "RESIDENT",
            full_name: resident.info_name,
            receipts_status: "NEW",
            expiration_date: DateTime.now()
                .add(Duration(days: fixedDateService!.cut_service_date ?? 0))
                .subtract(const Duration(hours: 7))
                .toIso8601String(),
            date: DateTime.now()
                .subtract(const Duration(hours: 7))
                .toIso8601String(),
          );
          listReceipt.add(receiptDeposiy.toJson());
        }
        var dataHis = conHis?.toJson();
        var dataReg = conReg.toJson();
        return APIConstruction.saveNewConstructionRegistration(
            dataReg, dataHis, listReceipt);
      })
          // .then((v) {
          //   if (existedConReg != null) {
          //     ConstructionHistory conHis = ConstructionHistory(
          //       constructionregistrationId:
          //           existedConReg != null ? existedConReg!.id : v["_id"],
          //       date: DateTime.now()
          //           .subtract(const Duration(hours: 7))
          //           .toIso8601String(),
          //       residentId: resident!.id,
          //       person: resident.info_name,
          //       status: isRequest ? "WAIT_TECHNICAL" : "NEW",
          //     );
          //     return APIConstruction.saveConstructionHistory(conHis.toJson());
          //   }
          //   return Future.delayed(Duration.zero);
          // })
          .then((v) {
        Utils.showSuccessMessage(
            context: context,
            e: isRequest
                ? S.of(context).success_send_req
                : existedConReg != null && existedConReg!.id != null
                    ? S.of(context).success_edit
                    : S.of(context).success_cr_new,
            onClose: () {
              Navigator.pushNamedAndRemoveUntil(context,
                  ConstructionListScreen.routeName, (route) => route.isFirst);
            });
        isSendApproveLoading = false;
        isAddNewLoading = false;
        validateSurface = null;
        validateConsType = null;
        validateRegDate = null;
        validateStartTime = null;
        validateEndTime = null;
        validateDescribe = null;
        validateConsUnit = null;
        validateAddress = null;
        validateDeputy = null;
        validatePhone = null;
        validateIdentity = null;
        validateWorkerNum = null;
        validateEmail = null;
        notifyListeners();
      }).catchError((e) {
        isAddNewLoading = false;
        isSendApproveLoading = false;
        validateSurface = null;
        validateConsType = null;
        validateRegDate = null;
        validateStartTime = null;
        validateEndTime = null;
        validateDescribe = null;
        validateConsUnit = null;
        validateAddress = null;
        validateDeputy = null;
        validatePhone = null;
        validateIdentity = null;
        validateWorkerNum = null;
        validateEmail = null;
        notifyListeners();
        Utils.showErrorMessage(context, e.toString());
      });

      // if (endTime!.compareTo(startTime!) < 0) {
      //   listError.add(S.of(context).end_date_after_start_date);
      // }
    } catch (e) {
      isAddNewLoading = false;
      isSendApproveLoading = false;
      validateSurface = null;
      validateConsType = null;
      validateRegDate = null;
      validateStartTime = null;
      validateEndTime = null;
      validateDescribe = null;
      validateConsUnit = null;
      validateAddress = null;
      validateDeputy = null;
      validatePhone = null;
      validateIdentity = null;
      validateWorkerNum = null;
      validateEmail = null;

      notifyListeners();
      Utils.showErrorMessage(context, e.toString());
    }
  }

  Future uploadCurrentDrawing(BuildContext context) async {
    await APIAuth.uploadSingleFile(files: currentDrawings, context: context)
        .then((v) {
      if (v.isNotEmpty) {
        for (var e in v) {
          uploadedCurrentDrawings.add(
            ConstructionFile(id: e.data, name: e.name),
          );
        }
      }
    }).catchError((e) {
      throw (e);
    });
  }

  Future uploadRenewDrawing(BuildContext context) async {
    await APIAuth.uploadSingleFile(files: renewDrawings, context: context)
        .then((v) {
      if (v.isNotEmpty) {
        for (var e in v) {
          uploadedRenewDrawings.add(
            ConstructionFile(id: e.data, name: e.name),
          );
        }
      }
    }).catchError((e) {
      throw (e);
    });
  }

  onSelectCurentDrawing(BuildContext context) async {
    await Utils.selectFile(context, false).then((value) {
      if (value != null) {
        final list = value.map<File>((e) => File(e!.path)).toList();
        currentDrawings.addAll(list);
        notifyListeners();
      }
    });
  }

  onRemoveCurentDrawing(int index) {
    currentDrawings.removeAt(index);
    notifyListeners();
  }

  onRemoveExistedCurentDrawing(int index) {
    existedCurrentDrawings.removeAt(index);
    notifyListeners();
  }

  onSelectRenewDrawing(BuildContext context) async {
    await Utils.selectFile(context, false).then((value) {
      if (value != null) {
        final list = value.map<File>((e) => File(e!.path)).toList();
        renewDrawings.addAll(list);
        notifyListeners();
      }
    });
  }

  onRemoveRenewDrawing(int index) {
    renewDrawings.removeAt(index);
    notifyListeners();
  }

  onRemoveExistedRenewDrawing(int index) {
    existedRenewDrawings.removeAt(index);
    notifyListeners();
  }

  onChangeApartment(value) {
    selectedApartment = value;
    surfaceController.text = value;
    validateSurface = null;
    notifyListeners();
  }

  onChangeConsType(value) {
    consTypeController.text = value;
    selectedConstype = value;
    validateConsType = null;
    calculateFee();

    // var type = listConstructionType
    //     .firstWhere((element) => element.code == selectedConstype);
    // consFeeController.text = formatCurrency.format(type.c!.cost);
    // depositController.text = formatCurrency.format(type.c!.depositFee);
    notifyListeners();
  }

  calculateFee() {
    if (consTypeController.text.isNotEmpty && workday != null) {
      var type = listConstructionType
          .firstWhere((element) => element.id == consTypeController.text);
      if (type.c!.chargeFormCost == "PAYINFULL") {
        fee = type.c!.cost;
      } else {
        fee = type.c!.cost! * workday!;
      }
      if (type.c!.chargeFormDeposit == "PAYINFULL") {
        depositController.text = formatCurrency.format(type.c!.depositFee);
      } else {
        depositController.text =
            formatCurrency.format(type.c!.depositFee! * workday!);
      }
      consFeeController.text = formatCurrency.format(fee);
      depositFee = type.c!.depositFee;
    }
    notifyListeners();
  }

  onStep1Next(BuildContext context) {
    FocusScope.of(context).unfocus();
    autoValidStep1 = true;
    if (formKey1.currentState!.validate()) {
      isDisableRightCroll = false;
      notifyListeners();
      clearValidStringStep1();
      controller
          .animateToPage(++activeStep,
              duration: const Duration(milliseconds: 250),
              curve: Curves.bounceInOut)
          .then((_) {
        isDisableRightCroll = true;
        notifyListeners();
      });
    } else {
      genValidStep1();
    }
    notifyListeners();
  }

  clearValidStringStep1() {
    validateSurface = null;
    validateConsType = null;
    validateRegDate = null;
    validateStartTime = null;
    validateEndTime = null;
    validateDescribe = null;
    notifyListeners();
  }

  genValidStep1() {
    var now = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 24);
    if (surfaceController.text.trim().isEmpty) {
      validateSurface = S.current.not_blank;
    } else {
      validateSurface = null;
    }
    if (consTypeController.text.trim().isEmpty) {
      validateConsType = S.current.not_blank;
    } else {
      validateConsType = null;
    }
    if (regDateController.text.trim().isEmpty) {
      validateRegDate = S.current.not_blank;
    } else {
      validateRegDate = null;
    }
    if (startTimeController.text.trim().isEmpty) {
      validateStartTime = S.current.not_blank;
    } else if (startTime!.compareTo(now) < 0) {
      validateStartTime = S.current.start_date_after_now_equal;
    } else if (startTime != null &&
        endTime != null &&
        endTime!.compareTo(startTime!) < 0) {
      validateStartTime = S.current.end_date_after_start_date;
    } else {
      validateStartTime = null;
    }
    if (endTimeController.text.trim().isEmpty) {
      validateEndTime = S.current.not_blank;
    } else if (startTime != null &&
        endTime != null &&
        endTime!.compareTo(startTime!) < 0) {
      validateEndTime = S.current.end_date_after_start_date;
    } else {
      validateEndTime = null;
    }
    if (describeController.text.trim().isEmpty) {
      validateDescribe = S.current.not_blank;
    } else {
      validateDescribe = null;
    }
  }

  clearValidStringStep2() {
    validateConsUnit = null;
    validateAddress = null;
    validateDeputy = null;
    validatePhone = null;
    validateIdentity = null;
    validateWorkerNum = null;
    validateEmail = null;
    notifyListeners();
  }

  genValidStep2() {
    if (consUnitController.text.trim().isEmpty) {
      validateConsUnit = S.current.not_blank;
    } else {
      validateConsUnit = null;
    }
    if (addressController.text.trim().isEmpty) {
      validateAddress = S.current.not_blank;
    } else {
      validateAddress = null;
    }
    if (deputyController.text.trim().isEmpty) {
      validateDeputy = S.current.not_blank;
    } else {
      validateDeputy = null;
    }
    if (phoneController.text.trim().isEmpty) {
      validatePhone = S.current.not_blank;
    } else if (phoneController.text.trim().length < 10) {
      validatePhone = S.current.phone_less_10;
    } else {
      validatePhone = null;
    }
    if (identityController.text.trim().isEmpty) {
      validateIdentity = S.current.not_blank;
    } else {
      validateIdentity = null;
    }
    if (workerNumController.text.trim().isEmpty) {
      validateWorkerNum = S.current.not_blank;
    } else {
      validateWorkerNum = null;
    }
    if (emailController.text.trim().isNotEmpty &&
        !RegexText.isEmail(emailController.text.trim())) {
      validateEmail = S.current.not_email;
    } else {
      validateEmail = null;
    }
  }

  onStep2Next(BuildContext context) {
    FocusScope.of(context).unfocus();
    autoValidStep2 = true;
    if (formKey2.currentState!.validate()) {
      isDisableRightCroll = false;
      notifyListeners();
      clearValidStringStep2();
      controller.animateToPage(++activeStep,
          duration: const Duration(milliseconds: 250),
          curve: Curves.bounceInOut);
    } else {
      genValidStep2();
    }

    notifyListeners();
  }

  onSendRequest() {}

  toggleFee() {
    isPaidFee = !isPaidFee;
    notifyListeners();
  }

  toggleDeposit() {
    isPaidDeposit = !isPaidDeposit;
    notifyListeners();
  }

  toggleAgree() {
    isAgree = !isAgree;
    notifyListeners();
  }

  pickRegDate(BuildContext context) async {
    await Utils.showDatePickers(
      context,
      initDate: regDate ?? DateTime.now(),
      startDate: DateTime(DateTime.now().year - 10, 1, 1),
      endDate: DateTime(DateTime.now().year + 10, 1, 1),
    ).then((v) {
      if (v != null) {
        regDateController.text = Utils.dateFormat(v.toIso8601String(), 0);
        regDate = v;
      }
    });
  }

  pickStartTime(BuildContext context) async {
    await Utils.showDatePickers(
      context,
      initDate: startTime ?? DateTime.now(),
      startDate: DateTime(DateTime.now().year - 10, 1, 1),
      endDate: DateTime(DateTime.now().year + 10, 1, 1),
    ).then((v) {
      if (v != null) {
        startTime = v;
        startTimeController.text = Utils.dateFormat(v.toIso8601String(), 0);

        notifyListeners();
      }
    });
  }

  countDate() {
    if (startTime != null && endTime != null) {
      int d_1 = 0,
          d_2 = 0,
          d_3 = 0,
          d_4 = 0,
          d_5 = 0,
          d_6 = 0,
          d_0 = 0,
          diff = (startTime!.difference(endTime!).inDays).abs();
      DateTime temp = startTime!;

      for (int i = 0; i <= diff; i++) {
        if (temp.add(Duration(days: i)).weekday == DateTime.monday) {
          d_1++;
        } else if (temp.add(Duration(days: i)).weekday == DateTime.tuesday) {
          d_2++;
        } else if (temp.add(Duration(days: i)).weekday == DateTime.wednesday) {
          d_3++;
        } else if (temp.add(Duration(days: i)).weekday == DateTime.thursday) {
          d_4++;
        } else if (temp.add(Duration(days: i)).weekday == DateTime.friday) {
          d_5++;
        } else if (temp.add(Duration(days: i)).weekday == DateTime.saturday) {
          d_6++;
        } else if (temp.add(Duration(days: i)).weekday == DateTime.sunday) {
          d_0++;
        }
      }
      var dataOff = {
        "d_0": d_0,
        "d_1": d_1,
        "d_2": d_2,
        "d_3": d_3,
        "d_4": d_4,
        "d_5": d_5,
        "d_6": d_6,
      };
      // print("$d_1 $d_2 $d_3 $d_4 $d_5 $d_6 $d_0");

      int day = 0;

      dayoff!.toJson().forEach((key, value) {
        if (value == true) {
          day += dataOff[key] ?? 0;
        }
      });
      offDayController.text = day.toString();
      workday = diff + 1 - day;
      workDayController.text = (diff + 1 - day).toString();
      offday = day;
    }
    notifyListeners();
  }

  pickEndTime(BuildContext context) async {
    await Utils.showDatePickers(
      context,
      initDate: endTime ?? DateTime.now(),
      startDate: DateTime(DateTime.now().year - 10, 1, 1),
      endDate: DateTime(DateTime.now().year + 10, 1, 1),
    ).then((v) {
      if (v != null) {
        endTime = v;
        endTimeController.text = Utils.dateFormat(v.toIso8601String(), 0);

        notifyListeners();
      }
    });
  }

  getConstructionTypeList(BuildContext context) async {
    await APIConstruction.getConstructionTypeList().then((v) {
      listConstructionType.clear();
      for (var i in v) {
        listConstructionType.add(ConstructionType.fromJson(i));
      }

      return APIConstruction.getDayOff();
    }).then((v) {
      if (v != null) {
        dayoff = DayOff.fromJson(v[0]);
      }
      getFixedDate();
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
    // notifyListeners();
  }

  getFixedDate() async {
    return await APIConstruction.getFixedDateService().then((v) {
      fixedDateService = FixedDateService.fromMap(v[0]);
    });
  }

  onPageChanged(v) {
    activeStep = v;
    notifyListeners();
  }
}
