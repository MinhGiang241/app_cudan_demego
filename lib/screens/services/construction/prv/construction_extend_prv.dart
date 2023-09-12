import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/services/api_construction.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../../../../models/construction.dart';
import '../../../../utils/utils.dart';
import '../../../payment/widget/payment_item.dart';
import '../construction_list_screen.dart';

class ConstructionExtendPrv extends ChangeNotifier {
  ConstructionExtendPrv({this.exitedExtend}) {
    if (exitedExtend != null) {
      surfaceValue = exitedExtend!.apartmentId;
      getConstructionDocument(exitedExtend!.apartmentId).then((v) {
        if (fileList.isNotEmpty) {
          fileValue = exitedExtend!.code;
          notifyListeners();
        }
      });

      startDate = DateTime.tryParse(exitedExtend!.time_start ?? '') != null
          ? DateTime.parse(exitedExtend!.time_start ?? '')
          : null;
      endDate = DateTime.tryParse(exitedExtend!.time_end ?? '') != null
          ? DateTime.parse(exitedExtend!.time_end ?? '')
          : null;
      regDateController.text =
          Utils.dateFormat(exitedExtend!.createdTime ?? '', 1);
      consFeeController.text =
          formatCurrency.format(exitedExtend!.construction_cost);
      consDateController.text = exitedExtend!.worker_num.toString();
      offDateController.text = exitedExtend!.off_day.toString();
      reasonController.text = exitedExtend!.reason_description ?? '';
      if (startDate != null) {
        startDateController.text =
            Utils.dateFormat(startDate!.toIso8601String(), 1);
      }
      if (endDate != null) {
        endDateController.text =
            Utils.dateFormat(endDate!.toIso8601String(), 1);
      }
    }
  }

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

  var regDateKey = UniqueKey();
  var fileKey = UniqueKey();

  String? surfaceValue;
  String? fileValue;

  bool loading = false;

  final formKey = GlobalKey<FormState>();
  ConstructionExtension? exitedExtend;
  List<ConstructionDocument> fileList = [];

  getConstructionDocument(String? apartmentId) async {
    await APIConstruction.getConstructionDocumentListByApartmentId(apartmentId)
        .then((v) {
      if (v != null) {
        fileList.clear();
        for (var i in v) {
          fileList.add(ConstructionDocument.fromJson(i));
        }
      }
      notifyListeners();
    }).catchError((e) {});
  }

  onSubmit(BuildContext context) async {
    loading = true;
    autoValidate = true;
    notifyListeners();
    if (formKey.currentState!.validate()) {
      try {
        clearValidateString();
        var residentId = context.read<ResidentInfoPrv>().residentId;
        var resident = context.read<ResidentInfoPrv>().userInfo;
        var docIndex = fileList.indexWhere((e) => e.code == fileValue);
        var doc = fileList[docIndex];
        var listOwn = context.read<ResidentInfoPrv>().listOwn;
        var apartmentIndex =
            listOwn.indexWhere((v) => v.apartmentId == surfaceValue);
        var apartment = listOwn[apartmentIndex];
        var isOwner = apartment.type == 'BUY';

        var newExtension = ConstructionExtension(
          status: isOwner ? "WAIT_TECHNICAL" : "WAIT_OWNER",
          deputy: doc.deputy,
          deputy_phone: doc.deputy_phone,
          residentId: residentId,
          worker_num: doc.worker_num,
          off_day: doc.off_day,
          deputy_identity: doc.deputy_identity,
          working_day: doc.working_day,
          deposit_fee: doc.deposit_fee,
          resident_code: resident?.code,
          apartmentId: surfaceValue,
          current_draw: doc.current_draw,
          confirm: doc.confirm,
          description: doc.description,
          resident_phone: resident?.phone_required,
          isDepositFee: doc.isDepositFee,
          constructionDocumentId: doc.id,
          extend_reason: reasonController.text.trim(),
          reason_description: reasonController.text.trim(),
          renovation_draw: doc.renovation_draw,
          resident_identity:
              context.read<ResidentInfoPrv>().userInfo?.identity_card,
          constructionTypeId: doc.constructionTypeId,
          resident_name: resident?.info_name,
          construction_email: doc.construction_email,
          isConstructionCost: doc.isContructionCost,
          construction_add: doc.construction_add,
          construction_cost: doc.construction_cost,
          construction_unit: doc.construction_unit,
          resident_relationship: doc.resident_relationship,
          extend_working_day:
              int.tryParse(consDateController.text.trim()) != null
                  ? int.parse(consDateController.text.trim())
                  : null,
          isMobile: true,
          time_start: startDate!.toUtc().toIso8601String(),
          time_end: endDate!.toUtc().toIso8601String(),
        );

        await APIConstruction.saveConstructionExtension(newExtension.toMap());

        Utils.showSuccessMessage(
          context: context,
          e: S.of(context).send_extension_success,
          onClose: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              ConstructionListScreen.routeName,
              (route) => route.isFirst,
              arguments: {'index': 1},
            );
          },
        );
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

  onSelectSurface(v) {
    fileKey = UniqueKey();
    if (v != null) {
      surfaceValue = v;
      validateSurface = null;
      getConstructionDocument(v);
    }
    notifyListeners();
  }

  onSelectFile(v) {
    regDateKey = UniqueKey();
    if (v != null) {
      fileValue = v;
      validateFile = null;
      var fileIndex = fileList.indexWhere((element) => element.code == v);
      var file = fileList[fileIndex];
      regDateController.text = Utils.dateFormat(file.createdTime ?? '', 1);
      consFeeController.text = formatCurrency.format(file.construction_cost);
    }
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
    if (surfaceValue == null) {
      validateSurface = S.current.not_blank;
    } else {
      validateSurface = null;
    }
    if (fileValue == null) {
      validateFile = S.current.not_blank;
    } else {
      validateSurface = null;
    }
    if (regDateController.text.trim().isEmpty) {
      validateRegDate = S.current.not_blank;
    } else {
      validateRegDate = null;
    }
    if (startDateController.text.trim().isEmpty) {
      validateStartDate = S.current.not_blank;
    } else {
      validateStartDate = null;
    }
    if (endDateController.text.trim().isEmpty) {
      validateEndDate = S.current.not_blank;
    } else {
      validateEndDate = null;
    }
    if (reasonController.text.trim().isEmpty) {
      validateReason = S.current.not_blank;
    } else {
      validateReason = null;
    }

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
