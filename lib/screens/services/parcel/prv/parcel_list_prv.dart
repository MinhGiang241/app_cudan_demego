import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/services/api_parcel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/parcel.dart';
import '../../../../utils/utils.dart';

class ParcelListPrv extends ChangeNotifier {
  int year = DateTime.now().year;
  int month = DateTime.now().month;
  List<Parcel> listWaitParcel = [];
  List<Parcel> listReceiptedParcel = [];

  bool isInit = true;
  onChooseMonthYear(DateTime v) {
    year = v.year;
    month = v.month;
    isInit = false;
    notifyListeners();
  }

  getParcelList(BuildContext context) async {
    await APIParcel.getParcelList(
      year,
      month,
      context.read<ResidentInfoPrv>().userInfo?.phone_required ?? "",
      context.read<ResidentInfoPrv>().residentId,
      context.read<ResidentInfoPrv>().selectedApartment?.apartmentId,
      isInit,
    ).then((v) {
      listWaitParcel.clear();
      listReceiptedParcel.clear();
      for (var i in v) {
        if (i['status'] != "NO") {
          listReceiptedParcel.add(Parcel.fromJson(i));
        } else {
          listWaitParcel.add(Parcel.fromJson(i));
        }
      }
      listReceiptedParcel.sort((a, b) => b.time_out!.compareTo(a.time_get!));
      listWaitParcel.sort((a, b) => b.time_get!.compareTo(a.time_get!));
      notifyListeners();
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }
}
