import 'package:app_cudan/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../../../../models/construction.dart';
import '../../../../services/api_construction.dart';
import '../../../auth/prv/resident_info_prv.dart';
import '../../../payment/widget/payment_item.dart';
import '../construction_list_screen.dart';

class ConstructionStopPrv extends ChangeNotifier {
  ConstructionStopPrv({this.exitedStop}) {
    if (exitedStop != null) {
      surfaceValue = exitedStop!.apartmentId;
      getConstructionDocument(exitedStop!.apartmentId).then((v) {
        if (fileList.isNotEmpty) {
          fileValue = exitedStop!.code;
          notifyListeners();
        }
      });

      startDate = exitedStop?.temporarily_stopped != null &&
              exitedStop!.temporarily_stopped!.length >= 1 &&
              exitedStop!.temporarily_stopped?[0]?.length >= 1
          ? DateTime.tryParse(exitedStop!.temporarily_stopped?[0]?[0] ?? '') !=
                  null
              ? DateTime.parse(exitedStop!.temporarily_stopped?[0]?[0] ?? '')
              : null
          : null;
      endDate = exitedStop?.temporarily_stopped != null &&
              exitedStop!.temporarily_stopped!.length >= 1 &&
              exitedStop!.temporarily_stopped?[0]?.length >= 2
          ? DateTime.tryParse(exitedStop!.temporarily_stopped?[0]?[1] ?? '') !=
                  null
              ? DateTime.parse(exitedStop!.temporarily_stopped?[0]?[1] ?? '')
              : null
          : null;
      regDateController.text =
          Utils.dateFormat(exitedStop!.createdTime ?? '', 1);
      consFeeController.text =
          formatCurrency.format(exitedStop!.construction_cost);
      consDateController.text = exitedStop!.working_day.toString();
      offDateController.text = exitedStop!.off_day.toString();
      reasonController.text = exitedStop!.reason_description ?? '';
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
  final formKey = GlobalKey<FormState>();
  ConstructionTemporarilyStopped? exitedStop;
  bool autoValidate = false;
  String? surfaceValue;
  String? fileValue;
  var fileKey = UniqueKey();
  var regDateKey = UniqueKey();
  bool loading = false;
  DateTime? startDate;
  DateTime? endDate;

  List<ConstructionDocument> fileList = [];

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

        var newStop = ConstructionTemporarilyStopped(
          status: isOwner ? "WAIT_TECHNICAL" : "WAIT_OWNER",
          residentId: residentId,
          off_day: doc.off_day,
          working_day: doc.working_day,
          resident_code: resident?.code,
          apartmentId: surfaceValue,
          current_draw: doc.current_draw,
          confirm: doc.confirm,
          description: doc.description,
          resident_phone: resident?.phone_required,
          constructionDocumentId: doc.id,
          //cancel_reasonl: reasonController.text.trim(),
          reason_description: reasonController.text.trim(),
          renovation_draw: doc.renovation_draw,
          resident_identity:
              context.read<ResidentInfoPrv>().userInfo?.identity_card,
          constructionTypeId: doc.constructionTypeId,
          resident_name: resident?.info_name,

          construction_cost: doc.construction_cost,
          resident_relationship: doc.resident_relationship,

          isMobile: true,
          temporarily_stopped: [
            [startDate!.toIso8601String(), endDate!.toIso8601String()],
          ],
        );
        await APIConstruction.saveAndChangeConstructionStop(
          newStop.toMap(),
          isOwner ? "WAIT_TECHNICAL" : "WAIT_OWNER",
          reasonController.text.trim(),
          true,
        );
        Utils.showSuccessMessage(
          context: context,
          e: S.of(context).send_stop_success,
          onClose: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              ConstructionListScreen.routeName,
              (route) => route.isFirst,
              arguments: {'index': 2},
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
}
