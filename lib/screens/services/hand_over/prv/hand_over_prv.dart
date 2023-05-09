import 'package:app_cudan/services/api_hand_over.dart';
import 'package:flutter/material.dart';

import '../../../../models/hand_over.dart';
import '../../../../utils/utils.dart';

class HandOverPrv extends ChangeNotifier {
  List<HandOver> listHandOver = [];
  getHandOverHisByResidentId(BuildContext context, String residentId) async {
    await APIHandOver.getHandOverList(residentId).then((v) {
      listHandOver.clear();
      for (var i in v) {
        listHandOver.add(HandOver.fromJson(i));
      }
      print(listHandOver);
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }
}
