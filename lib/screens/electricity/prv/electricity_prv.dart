import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/indicator.dart';
import '../../../services/api_electricity.dart';

class ElectricityPrv extends ChangeNotifier {
  int year = DateTime.now().year;
  int month = DateTime.now().month;
  List<Indicator> listIndicatorCurrentYear = [];
  List<Indicator> listIndicatorLastYear = [];

  onChooseMonthYear(DateTime v) {
    year = v.year;
    notifyListeners();
  }

  onChooseMonthBill(DateTime v) {
    month = v.month;
    notifyListeners();
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
