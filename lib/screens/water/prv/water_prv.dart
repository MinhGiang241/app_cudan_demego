import 'package:app_cudan/models/waterFee.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/indicator.dart';
import '../../../models/receipt.dart';
import '../../../services/api_electricity.dart';
import '../../../utils/utils.dart';
import '../../auth/prv/resident_info_prv.dart';

class WaterPrv extends ChangeNotifier {
  var year = DateTime.now().year;
  var month = DateTime.now().month;
  List<Indicator> listIndicatorCurrentYear = [];
  List<Indicator> listIndicatorLastYear = [];
  Indicator? indicatorLastMonth;
  Indicator? indicatorCurrentMonth;
  List<Receipt> listReceipt = [];
  WaterFee? waterFee;

  onChooseMonthYear(DateTime v) {
    year = v.year;
    notifyListeners();
  }

  onChooseMonthBill(DateTime v) {
    month = v.month;
    notifyListeners();
  }

  Future getWatweFeeConfig() async {
    await APIElectricity.getWaterFee().then((value) {
      if (value != null && value.isNotEmpty) {
        waterFee = WaterFee.fromMap(value[0]);
      } else {
        waterFee = null;
      }
    });
  }

  Future getReceiptByYear(BuildContext context) async {
    var apartmentId = context.read<ResidentInfoPrv>().selectedApartment?.id;
    // var residentId = context.read<ResidentInfoPrv>().residentId;
    // APIPayment.getReceiptsList(residentId, apartmentId, 2023, 3, '')

    APIElectricity.getReceiptByYear(apartmentId, year, false).then((v) {
      listReceipt.clear();
      for (var i in v) {
        listReceipt.add(Receipt.fromJson(i));
      }
      notifyListeners();
    }).catchError((e) {
      Utils.showErrorMessage(context, e.toString());
    });
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

  Future getWaterFeeConfig() async {
    await APIElectricity.getWaterFee().then((value) {
      if (value != null && value.isNotEmpty) {
        waterFee = WaterFee.fromMap(value[0]);
      } else {
        waterFee = null;
      }
    });
  }

  Future getDataBill(BuildContext context) async {
    try {
      var apartmentId = context.read<ResidentInfoPrv>().selectedApartment?.id;
      await getIndicatorMonth(apartmentId);
      await getWaterFeeConfig();
    } catch (e) {
      Utils.showErrorMessage(context, e.toString());
    }
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
