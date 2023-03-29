import 'package:app_cudan/models/electric_fee.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/indicator.dart';
import '../../../services/api_electricity.dart';
import '../../../utils/utils.dart';

class ElectricityPrv extends ChangeNotifier {
  int year = DateTime.now().year;
  int month = DateTime.now().month;
  List<Indicator> listIndicatorCurrentYear = [];
  List<Indicator> listIndicatorLastYear = [];
  ElectricFee? electricFee;
  Indicator? indicatorLastMonth;
  Indicator? indicatorCurrentMonth;

  onChooseMonthYear(DateTime v) {
    year = v.year;
    notifyListeners();
  }

  onChooseMonthBill(DateTime v) {
    month = v.month;
    notifyListeners();
  }

  Future getReceiptByYear(BuildContext context) async {
    var apartmentId = context.read<ResidentInfoPrv>().selectedApartment?.id;
    APIElectricity.getReceiptByYear(apartmentId, year, true)
        .then((v) {})
        .catchError((e) {
      Utils.showErrorMessage(context, e.toString());
    });
  }

  Future getDataBill(BuildContext context) async {
    try {
      var apartmentId = context.read<ResidentInfoPrv>().selectedApartment?.id;
      await getIndicatorMonth(apartmentId);
      await getElectricFeeConfig();
    } catch (e) {
      Utils.showErrorMessage(context, e.toString());
    }
  }

  Future getIndicatorMonth(String? apartmentId) async {
    await APIElectricity.getMonthElectricIndicator(apartmentId, year, month)
        .then((v) {
      indicatorLastMonth =
          v['current'] != null ? Indicator.fromMap(v['last']) : null;
      indicatorCurrentMonth =
          v['current'] != null ? Indicator.fromMap(v['current']) : null;
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

  Future getIndicatorByYear(BuildContext context) async {
    var apartmentId =
        context.read<ResidentInfoPrv>().selectedApartment?.apartmentId;
    await APIElectricity.getIndicatorByYear(apartmentId, year).then((v) {
      listIndicatorCurrentYear.clear();
      for (var i in v['current']) {
        listIndicatorCurrentYear.add(Indicator.fromMap(i));
      }
      for (var i in v['last']) {
        listIndicatorLastYear.add(Indicator.fromMap(i));
      }
    });
  }
}
