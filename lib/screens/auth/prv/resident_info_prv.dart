import 'package:app_cudan/services/api_auth.dart';
import 'package:app_cudan/services/api_tower.dart';
import 'package:flutter/material.dart';

import '../../../models/resident_info.dart';
import '../../../models/response_resident_own.dart';

class ResidentInfoPrv extends ChangeNotifier {
  bool isLoading = false;
  ResponseResidentInfo? userInfo;
  List<ResponseResidentOwn> listOwn = [];
  ResponseResidentOwn? selectedApartment;
  String? residentId;

  addListOwn(i) {
    listOwn.add(ResponseResidentOwn.fromJson(i));
    notifyListeners();
  }

  clearData() {
    userInfo = null;
    listOwn.clear();
    selectedApartment = null;
    residentId = null;
  }

  clearListOwn() {
    // selectedApartment = null;
    // residentId = null;
    // userInfo = null;
    listOwn.clear();
    notifyListeners();
  }

  setUserInfo(value) {
    userInfo = ResponseResidentInfo.fromJson(value);
    residentId = userInfo != null ? userInfo!.id : null;
    // print(residentId);
    // notifyListeners();
  }

  selectApartment(ResponseResidentOwn select) {
    selectedApartment = select;
    notifyListeners();
  }
}
