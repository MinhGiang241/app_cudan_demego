import 'package:app_cudan/services/api_delivery.dart';
import 'package:flutter/material.dart';

import '../../../../models/delivery.dart';
import '../../../../utils/utils.dart';

class DeliveryListPrv extends ChangeNotifier {
  List<Delivery> listItems = [];
  getDeliveryList(BuildContext context, String id) async {
    await APIDelivery.getDeliveryListByResidentId(id).then(
      (value) {
        listItems.clear();
        if (value != null) {
          for (var i in value) {
            listItems.add(Delivery.fromJson(i));
          }
        }
      },
    ).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }
}
