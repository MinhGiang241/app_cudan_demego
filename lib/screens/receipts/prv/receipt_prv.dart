import 'package:app_cudan/models/service_bill.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/services/api_payment.dart';
import 'package:app_cudan/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';

class ReceiptPrv extends ChangeNotifier {
  ReceiptPrv() {
    toDate = DateTime.now();
    fromDate = DateTime(toDate!.year, toDate!.month - 1, toDate!.day);
    fromController.text = Utils.dateFormat(fromDate!.toIso8601String(), 0);
    toController.text = Utils.dateFormat(toDate!.toIso8601String(), 0);
  }
  List<ServiceBillTransaction> list = [];
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  String? validateTo;
  String? validateFrom;
  DateTime? toDate;
  DateTime? fromDate;
  final formKey = GlobalKey<FormState>();
  bool loading = false;

  validate() {
    if (fromController.text.isEmpty) {
      validateFrom = S.current.not_blank;
    } else if (toDate!.compareTo(fromDate!) < 0) {
      validateFrom = S.current.end_date_after_start_date;
    } else {
      validateFrom = null;
    }
    if (toController.text.isEmpty) {
      validateTo = S.current.not_blank;
    } else if (toDate!.compareTo(fromDate!) < 0) {
      validateTo = S.current.end_date_after_start_date;
    } else {
      validateTo = null;
    }

    notifyListeners();
  }

  String? validateForm(String? v) {
    if (v!.isEmpty) {
      return '';
    } else if (toDate!.compareTo(fromDate!) < 0) {
      return '';
    }

    return null;
  }

  pickFromDate(BuildContext context) {
    Utils.showDatePickers(
      context,
      initDate: fromDate ?? DateTime.now(),
      startDate: DateTime(DateTime.now().year - 10, 1, 1),
      endDate: DateTime(DateTime.now().year + 10, 1, 1),
    ).then((v) {
      if (v != null) {
        fromDate = v;
        fromController.text = Utils.dateFormat(v.toIso8601String(), 0);
        notifyListeners();
        if (formKey.currentState!.validate()) {
          getReceiptsList(context);
        }
      } else {
        fromController.text = "";
      }
      notifyListeners();
    });
  }

  pickToDate(BuildContext context) {
    Utils.showDatePickers(
      context,
      initDate: toDate ?? DateTime.now(),
      startDate: DateTime(DateTime.now().year - 10, 1, 1),
      endDate: DateTime(DateTime.now().year + 10, 1, 1),
    ).then((v) {
      if (v != null) {
        toDate = v;
        toController.text = Utils.dateFormat(v.toIso8601String(), 0);
        notifyListeners();
        if (formKey.currentState!.validate()) {
          getReceiptsList(context);
        }
      } else {
        toController.text = "";
      }
      notifyListeners();
    });
  }

  getReceiptsList(BuildContext context) {
    if (fromDate != null && toDate != null) {
      var selectedApartment =
          context.read<ResidentInfoPrv>().selectedApartment?.apartmentId;
      APIPayment.getReceiptListFromTo(
        fromDate!.toUtc().toIso8601String(),
        toDate!.toUtc().toIso8601String(),
        selectedApartment,
      ).then((v) {
        if (v != null) {
          list.clear();
          for (var i in v) {
            list.add(ServiceBillTransaction.fromMap(i));
          }
          print(list);
          notifyListeners();
        }
      }).catchError((e) {
        Utils.showErrorMessage(context, e);
      });
    }
  }
}
