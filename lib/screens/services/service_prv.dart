import 'package:app_cudan/services/api_extra_service.dart';
import 'package:flutter/material.dart';

import '../../models/extra_service.dart';

class ServicePrv extends ChangeNotifier {
  List<ExtraService> listExtraService = [];

  Future getExtraService() async {
    await APIExtraService.getExtraServiceList().then((v) {}).catchError((e) {});
  }
}
