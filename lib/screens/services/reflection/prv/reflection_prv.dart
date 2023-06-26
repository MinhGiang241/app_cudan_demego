import 'package:app_cudan/models/reflection.dart';
import 'package:app_cudan/services/api_reflection.dart';
import 'package:flutter/material.dart';

import '../../../../utils/utils.dart';

class ReflectionPrv extends ChangeNotifier {
  int? year;
  int? month;
  var initIndex = 0;
  List<Reflection> listReflection = [];
  onChooseMonthYear(DateTime v) {
    year = v.year;
    month = v.month;
    notifyListeners();
  }

  getReflection(BuildContext context, String status, String residentId) async {
    await APIReflection.getReflection(status, year, month, residentId)
        .then((v) {
      listReflection.clear();
      for (var i in v) {
        listReflection.add(Reflection.fromJson(i));
      }
      print(listReflection);
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }
}
