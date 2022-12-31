import 'dart:io';

import 'package:app_cudan/services/api_construction.dart';
import 'package:app_cudan/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../models/construction.dart';
import '../../../payment/widget/payment_item.dart';

class ConstructionRegPrv extends ChangeNotifier {
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  int activeStep = 0;
  List<ConstructionType> listConstructionType = [];
  final PageController controller = PageController();

  List<ConstructionFile> existedCurrentDrawings = [];
  List<ConstructionFile> existedRenewDrawings = [];

  List<File> currentDrawings = [];
  List<File> renewDrawings = [];

  List<ConstructionFile> uploadedCurrentDrawings = [];
  List<ConstructionFile> uploadedrenewDrawings = [];

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

  String? validateSurface;
  String? validateConsType;
  String? validateRegDate;
  String? validateStartTime;
  String? validateEndTime;
  String? validateDescribe;

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
    notifyListeners();
  }

  onChangeConsType(value) {
    selectedConstype = value;
    var type = listConstructionType
        .firstWhere((element) => element.code == selectedConstype);
    consFeeController.text = formatCurrency.format(type.c!.cost);
    depositController.text = formatCurrency.format(type.c!.depositFee);
    notifyListeners();
  }

  onStep1Next() {
    controller.animateToPage(++activeStep,
        duration: const Duration(milliseconds: 250), curve: Curves.bounceInOut);

    notifyListeners();
  }

  onStep2Next() {
    controller.animateToPage(++activeStep,
        duration: const Duration(milliseconds: 250), curve: Curves.bounceInOut);
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

  pickRegDate(BuildContext context) {
    Utils.showDatePickers(
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

  pickStartTime(BuildContext context) {
    Utils.showDatePickers(
      context,
      initDate: startTime ?? DateTime.now(),
      startDate: DateTime(DateTime.now().year - 10, 1, 1),
      endDate: DateTime(DateTime.now().year + 10, 1, 1),
    ).then((v) {
      if (v != null) {
        startTimeController.text = Utils.dateFormat(v.toIso8601String(), 0);
        startTime = v;
      }
    });
  }

  pickEndTime(BuildContext context) {
    Utils.showDatePickers(
      context,
      initDate: endTime ?? DateTime.now(),
      startDate: DateTime(DateTime.now().year - 10, 1, 1),
      endDate: DateTime(DateTime.now().year + 10, 1, 1),
    ).then((v) {
      if (v != null) {
        endTimeController.text = Utils.dateFormat(v.toIso8601String(), 0);
        endTime = v;
      }
    });
  }

  getConstructionTypeList(BuildContext context) async {
    await APIConstruction.getConstructionTypeList().then((v) {
      listConstructionType.clear();
      for (var i in v) {
        listConstructionType.add(ConstructionType.fromJson(i));
      }
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
    // notifyListeners();
  }

  onPageChanged(v) {
    activeStep = v;
    notifyListeners();
  }
}
