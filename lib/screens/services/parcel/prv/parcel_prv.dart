import 'package:flutter/material.dart';

import '../../../../models/response_parcel_list.dart';
import '../../../../services/api_tower.dart';

class ParcelPrv extends ChangeNotifier {
  ResponseParcelList? parcelList;
  final waitingList = <ParcelItems>[];
  var groupYear = {};
  ParcelPrv() {
    _initial();
  }

  Future _initial() async {
    await APITower.getParcelList().then((value) {
      parcelList = value;
      if (parcelList?.status == null) {
        final doneList = <ParcelItems>[];
        for (var element in parcelList!.items!) {
          if (element.privateBuuPham?.trangThai?.text == "DangCho") {
            waitingList.add(element);
          } else if (element.privateBuuPham?.trangThai?.text == "DaHoanThanh") {
            doneList.add(element);
          }
        }
        var groupMonth = {};
        if (doneList.isNotEmpty) {
          for (int i = 0; i < doneList.length; i++) {
            final dateTime = DateTime.parse(doneList[i].modifiedUtc ?? "");
            final date = DateTime(dateTime.year, dateTime.month);
            if (groupMonth['$date'] == null) {
              groupMonth['$date'] = <ParcelItems>[];
            }
            (groupMonth['$date'] as List<ParcelItems>).add(doneList[i]);
          }
          groupMonth.forEach((key, value) {
            final date = DateTime.parse(key);
            if (groupYear['${date.year}'] == null) {
              groupYear['${date.year}'] = [];
            }
            (groupYear['${date.year}'] as List).add({key: value});
          });
        }
      }

      notifyListeners();
    });
  }

  Future retry() async {
    parcelList = null;
    notifyListeners();
    _initial();
  }
}
