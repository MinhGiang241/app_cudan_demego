import 'package:app_cudan/models/electric_fee.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/screens/electricity/electricity_screen.dart';
import 'package:app_cudan/services/api_payment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/indicator.dart';
import '../../../models/receipt.dart';
import '../../../services/api_electricity.dart';
import '../../../utils/utils.dart';

class ElectricityPrv extends ChangeNotifier {
  ElectricityPrv({this.year, this.month}) {
    year ??= DateTime(
      DateTime.now().year,
      DateTime.now().month, // - 1,
      DateTime.now().day,
    ).year;

    month ??= DateTime(
      DateTime.now().year,
      DateTime.now().month, // - 1,
      DateTime.now().day,
    ).month;
  }
  int? year;
  int? month;
  List<Indicator> listIndicatorCurrentYear = [];
  List<Indicator> listIndicatorLastYear = [];
  ElectricFee? electricFee;
  Indicator? indicatorLastMonth;
  Indicator? indicatorCurrentMonth;
  List<Receipt> listReceipt = [];
  Receipt? receiptMonth;

  onChooseMonthYear(DateTime v) {
    year = v.year;
    notifyListeners();
  }

  onChooseMonthBill(DateTime v) {
    month = v.month;
    notifyListeners();
  }

  Future getReceiptByYear(BuildContext context) async {
    var apartment = context.read<ResidentInfoPrv>().selectedApartment;
    var apartmentId = apartment?.apartmentId;
    // var residentId = context.read<ResidentInfoPrv>().residentId;
    // APIPayment.getReceiptsList(residentId, apartmentId, 2023, 3, '')

    // if (apartment?.type == 'RENT' || apartment?.type == "BUY") {
    //   return;
    // }
    APIElectricity.getReceiptByYear(apartmentId, year!, true).then((v) {
      listReceipt.clear();
      for (var i in v) {
        listReceipt.add(Receipt.fromJson(i));
      }
      notifyListeners();
    }).catchError((e) {
      Utils.showErrorMessage(context, e.toString());
    });
  }

  Future getDataBill(BuildContext context) async {
    try {
      var apartmentId =
          context.read<ResidentInfoPrv>().selectedApartment?.apartmentId;
      await getReceiptMonth(apartmentId);
      // await getElectricFeeConfig();
    } catch (e) {
      Utils.showErrorMessage(context, e.toString());
    }
  }

  Future getReceiptMonth(String? apartmentId) async {
    receiptMonth = null;

    await APIElectricity.getMonthReceiptMonth(apartmentId, year!, month!, true)
        .then((v) {
      if (v != null) {
        receiptMonth = Receipt.fromJson(v);
      }
    });
  }

  Future getElectricFeeConfig() async {
    await APIElectricity.getElectricFee().then((value) {
      if (value != null && value.isNotEmpty) {
        electricFee = ElectricFee.fromMap(value[0]);
      } else {
        electricFee = null;
      }
    });
  }

  navigate(BuildContext ctx) {
    Navigator.of(ctx).pushNamedAndRemoveUntil(
      ElectricityScreen.routeName,
      (route) => route.isFirst,
      arguments: {'init': 2, 'year': year, "month": month},
    );
  }

  Future getIndicatorByYear(BuildContext context) async {
    var apartmentId =
        context.read<ResidentInfoPrv>().selectedApartment?.apartmentId;
    await APIElectricity.getIndicatorByYear(apartmentId, year!).then((v) {
      listIndicatorCurrentYear.clear();
      listIndicatorLastYear.clear();
      for (var i in v['current']) {
        listIndicatorCurrentYear.add(Indicator.fromMap(i));
      }
      for (var i in v['last']) {
        listIndicatorLastYear.add(Indicator.fromMap(i));
      }
    });
    notifyListeners();
  }
}
