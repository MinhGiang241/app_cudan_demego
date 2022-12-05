import 'package:app_cudan/models/service_registration.dart';
import 'package:app_cudan/services/api_extra_service.dart';
import 'package:flutter/material.dart';

import '../../../../utils/utils.dart';

class ExtraServiceCardListPrv extends ChangeNotifier {
  List<ServiceRegistration> listCard = [];
  getRegisterExtraServiceList(
      BuildContext context, String residentId, String serviceId) async {
    await APIExtraService.getServiceRegistration(residentId, serviceId)
        .then((v) {
      listCard.clear();
      for (var i in v) {
        listCard.add(ServiceRegistration.fromJson(i));
      }
      notifyListeners();
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }

  cancelRequetsAprrove(BuildContext context, ServiceRegistration card) {}
  sendToApprove(BuildContext context, ServiceRegistration card) {}
  deleteLetter(BuildContext context, ServiceRegistration card) {}
}
