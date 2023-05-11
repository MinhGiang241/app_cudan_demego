import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/services/api_hand_over.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/hand_over.dart';
import '../../../../utils/utils.dart';

class HandOverPrv extends ChangeNotifier {
  List<HandOver> listHandOver = [];
  Future getHandOverHisByResidentId(
    BuildContext context,
  ) async {
    var residentId = context.read<ResidentInfoPrv>().residentId;
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
