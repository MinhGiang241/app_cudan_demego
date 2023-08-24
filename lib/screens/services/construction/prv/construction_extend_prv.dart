import 'package:flutter/material.dart';

import '../../../../utils/utils.dart';

class ConstructionExtendPrv extends ChangeNotifier {
  DateTime? startDate;
  DateTime? endDate;
  bool autoValidate = false;
  final TextEditingController regDateController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController consFeeController = TextEditingController();
  final TextEditingController consDateController = TextEditingController();
  final TextEditingController offDateController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  String? validateSurface;
  String? validateFile;
  String? validateRegDate;
  String? validateStartDate;
  String? validateEndDate;
  String? validateWorkFee;
  String? validateConsDate;
  String? validateOffDate;
  String? validateReason;

  String? surfaceValue;
  String? fileValue;

  bool loading = false;

  final formKey = GlobalKey<FormState>();

  onSubmit(BuildContext context) {
    if (formKey.currentState!.validate()) {
      try {
        clearValidateString();
        loading = true;
        notifyListeners();
      } catch (e) {
        loading = false;
        notifyListeners();
        Utils.showErrorMessage(context, e.toString());
      }
    } else {
      loading = false;
      notifyListeners();
      genValidateString();
    }
  }

  onSelectSurfce(v) {
    surfaceValue = v;
    notifyListeners();
  }

  onSelectFile(v) {
    fileValue = v;
    notifyListeners();
  }

  validate() {
    if (formKey.currentState!.validate()) {
      clearValidateString();
    } else {
      genValidateString();
    }
  }

  genValidateString() {
    notifyListeners();
  }

  clearValidateString() {
    validateSurface = null;
    validateFile = null;
    validateRegDate = null;
    validateStartDate = null;
    validateEndDate = null;
    validateWorkFee = null;
    validateConsDate = null;
    validateOffDate = null;
    validateReason = null;
    notifyListeners();
  }

  pickStartDate(BuildContext context) async {
    await Utils.showDatePickers(
      context,
      initDate: startDate ?? DateTime.now(),
      startDate: DateTime(DateTime.now().year - 10, 1, 1),
      endDate: DateTime(DateTime.now().year + 10, 1, 1),
    ).then((v) {
      if (v != null) {
        startDate = v;
        startDateController.text = Utils.dateFormat(v.toIso8601String(), 0);

        notifyListeners();
      }
    });
  }

  pickEndDate(BuildContext context) async {
    await Utils.showDatePickers(
      context,
      initDate: endDate ?? DateTime.now(),
      startDate: DateTime(DateTime.now().year - 10, 1, 1),
      endDate: DateTime(DateTime.now().year + 10, 1, 1),
    ).then((v) {
      if (v != null) {
        endDate = v;
        endDateController.text = Utils.dateFormat(v.toIso8601String(), 0);

        notifyListeners();
      }
    });
  }
}
