import 'package:app_cudan/models/receipt.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/services/api_payment.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/utils.dart';

class PaymentListPrv extends ChangeNotifier {
  PaymentListPrv({this.year, this.month}) {
    year ??= DateTime.now().year;
    month ??= DateTime.now().month;
  }
  int? year;
  int? month;
  List<Receipt> listPay = [];
  List<Receipt> listUnpay = [];
  onChooseMonthYear(DateTime v) {
    year = v.year;
    month = v.month;
    notifyListeners();
  }

  onSelect(int index) {
    // if(
    //   listUnpay[index].isSelected = true
    // ){

    // }
    for (var i in listUnpay) {
      i.isSelected = false;
    }
    listUnpay[index].isSelected = !listUnpay[index].isSelected;
    notifyListeners();
  }

  getReceiptsList(BuildContext context) async {
    var apartmentId =
        context.read<ResidentInfoPrv>().selectedApartment?.apartmentId;
    var residentId = context.read<ResidentInfoPrv>().residentId;
    var account = context.read<ResidentInfoPrv>().userInfo!.account;
    APIPayment.getReceiptsList(
      residentId ?? account?.userName,
      apartmentId,
      year!,
      month!,
      account?.phone ?? "",
    ).then((v) {
      listPay.clear();
      listUnpay.clear();
      for (var i in v) {
        if (i['payment_status'] == "UNPAID" || i['payment_status'] == "OWE") {
          listUnpay.add(Receipt.fromJson(i));
        } else {
          listPay.add(Receipt.fromJson(i));
        }
      }
      listPay.sort((a, b) {
        var aDate = DateTime.parse(a.date ?? "");
        var bDate = DateTime.parse(b.date ?? "");
        var aSameDate = DateTime(aDate.year, aDate.month, aDate.day);
        var bSameDate = DateTime(bDate.year, bDate.month, bDate.day);
        var compare = bSameDate.compareTo(aSameDate);
        if (compare == 0) {
          return b.createdTime!.compareTo(a.createdTime ?? "");
        }
        return compare;
      });
      notifyListeners();
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }
}
