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

  selectApartment(ResponseResidentOwn select) {
    selectedApartment = select;
    notifyListeners();
  }
}
