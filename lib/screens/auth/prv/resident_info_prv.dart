import 'package:app_cudan/services/api_auth.dart';
import 'package:app_cudan/services/api_tower.dart';
import 'package:flutter/material.dart';

import '../../../models/resident_info.dart';
import '../../../models/response_resident_own.dart';
import '../../../services/prf_data.dart';

class ResidentInfoPrv extends ChangeNotifier {
  bool isLoading = false;
  ResponseResidentInfo? userInfo;
  List<ResponseResidentOwn> listOwn = [];
  List<ResponseResidentOwn> listOwnAll = [];
  ResponseResidentOwn? selectedApartment;
  String? residentId;

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
    PrfData.shared.setApartments(select.value.apartmentId ?? "");
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
