import 'dart:convert';

import 'package:app_cudan/services/api_tower.dart';
import 'package:flutter/material.dart';

import '../../../models/resident_info.dart';
import '../../../models/response_resident_own.dart';
import '../../../models/user_account_HO.dart';
import '../../../services/prf_data.dart';

class ResidentInfoPrv extends ChangeNotifier {
  bool isLoading = false;
  ResponseResidentInfo? userInfo;
  List<ResponseResidentOwn> listOwn = [];
  List<ResponseResidentOwn> listOwnAll = [];
  ResponseResidentOwn? selectedApartment;
  String? residentId;

  setListOwn(BuildContext context) async {
    await APITower.getUserOwnInfo(
      residentId ?? '',
    ).then((v) async {
      var a = residentId;
      print(a);
      listOwn.clear();
      listOwnAll.clear();
      v.forEach((i) {
        listOwnAll.add(ResponseResidentOwn.fromJson(i));
        if (i['status'] == 'ACTIVE' &&
            (i['type'] == 'BUY' ||
                i['type'] == 'RENT' ||
                i['type'] == 'DEPENDENT_HOST' ||
                i['type'] == 'DEPENDENT_RENT')) {
          listOwn.add(ResponseResidentOwn.fromJson(i));
        }
      });
      String? aprtId = await PrfData.shared.getApartments();
      // ignore: unused_local_variable
      var index = selectApartmentFromHive(aprtId);
    });
  }

  setUserInfoFromHO(UserAccountHO userHO) {
    userInfo = userHO.resident ?? ResponseResidentInfo();
    userInfo?.account = userHO.user;
    residentId = userHO.resident?.id;

    print(userInfo);
  }

  addListOwn(i) {
    listOwn.add(ResponseResidentOwn.fromJson(i));
    notifyListeners();
  }

  addListOwnAll(i) {
    listOwnAll.add(ResponseResidentOwn.fromJson(i));
    notifyListeners();
  }

  setEmail(String email) {
    userInfo?.account?.email = email;
    notifyListeners();
  }

  clearData() {
    userInfo = null;
    listOwn.clear();
    listOwnAll.clear();
    selectedApartment = null;
    residentId = null;
  }

  clearListOwn() {
    listOwn.clear();
    notifyListeners();
  }

  clearListOwnAll() {
    listOwnAll.clear();
    notifyListeners();
  }

  setUserInfo(value) {
    userInfo = ResponseResidentInfo.fromJson(value);
    residentId = userInfo != null ? userInfo!.id : null;
    // print(residentId);
    // notifyListeners();
  }

  selectApartment(MapEntry<int, ResponseResidentOwn> select) async {
    selectedApartment = select.value;
    PrfData.shared.setApartments(json.encode(select.value.toJson()));
    notifyListeners();
  }

  selectApartmentFromHive(String? id) {
    if (id == null) {
      return -1;
    }
    var aPartIndex = listOwn.indexWhere((element) => element.apartmentId == id);

    if (aPartIndex != -1) {
      selectedApartment = listOwn[aPartIndex];
    }

    notifyListeners();
    return aPartIndex;
  }
}
