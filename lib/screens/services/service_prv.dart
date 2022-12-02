import 'package:app_cudan/services/api_extra_service.dart';
import 'package:flutter/material.dart';

import '../../models/extra_service.dart';
import '../../utils/utils.dart';

class ServicePrv extends ChangeNotifier {
  List<ExtraService> listExtraService = [];

  Future getExtraService(BuildContext context) async {
    await APIExtraService.getExtraServiceList().then((v) {}).catchError((e) {
      Utils.showSuccessMessage(context: context, e: e);
    });
  }
}
