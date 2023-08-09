import 'package:flutter/material.dart';

import '../../../../models/extra_service.dart';
import '../../../../services/api_extra_service.dart';
import '../../../../utils/utils.dart';

class UtilityServiceListPrv extends ChangeNotifier {
  List<ExtraService> listExtraService = [];

  Future getExtraService(BuildContext context) async {
    await APIExtraService.getExtraServiceList().then((v) {
      listExtraService.clear();

      for (var i in v) {
        listExtraService.add(ExtraService.fromJson(i));
      }
      listExtraService.sort((a, b) => a.createdTime!.compareTo(b.createdTime!));

      notifyListeners();
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }
}
