import 'package:app_cudan/services/api_delivery.dart';
import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../../../models/delivery.dart';
import '../../../../utils/utils.dart';
import '../delivery_list_screen.dart';

class DeliveryListPrv extends ChangeNotifier {
  List<Delivery> listItems = [];

  cancelRequetsAprrove(BuildContext context, Delivery data) {
    Utils.showConfirmMessage(
        context: context,
        title: S.of(context).cancel_request,
        content: S.of(context).confirm_cancel_request(data.code ?? ""),
        onConfirm: () {
          data.status = 'CANCEL';
          data.reasons = 'NGUOIDUNGHUY';
          // APIDelivery.saveNewDelivery(data.toJson())
          APIDelivery.changeStatus(data.toJson()).then((v) {
            Navigator.pop(context);
            Utils.showSuccessMessage(
                context: context,
                e: S.of(context).success_can_req,
                onClose: () {
                  Navigator.pushNamedAndRemoveUntil(context,
                      DeliveryListScreen.routeName, (route) => route.isFirst);
                });
          }).catchError((e) {
            Navigator.pop(context);
            Utils.showErrorMessage(context, e);
          });
        });
  }

  sendToApprove(BuildContext context, Delivery data) {
    if (data.item_added_list == null || data.item_added_list!.isEmpty) {
      Utils.showErrorMessage(context, S.of(context).item_list_not_empty);
      return;
    } else {
      data.status = 'WAIT';

      Utils.showConfirmMessage(
          title: S.of(context).send_request,
          content: S.of(context).confirm_send_request(data.code ?? ""),
          context: context,
          onConfirm: () {
            // APIDelivery.saveNewDelivery(data.toJson())
            APIDelivery.changeStatus(data.toJson()).then((v) {
              Navigator.pop(context);
              Utils.showSuccessMessage(
                  context: context,
                  e: S.of(context).success_send_req,
                  onClose: () {
                    Navigator.pushNamedAndRemoveUntil(context,
                        DeliveryListScreen.routeName, (route) => route.isFirst);
                  });
            }).catchError((e) {
              Navigator.pop(context);
              Utils.showErrorMessage(context, e);
            });
          });
    }
  }

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

  deleteLetter(BuildContext context, Delivery e) {
    Utils.showConfirmMessage(
        title: S.of(context).delete_letter,
        content: S.of(context).confirm_delete_letter(e.code ?? ''),
        context: context,
        onConfirm: () async {
          await APIDelivery.deleteDelivery(e.id ?? '').then((v) {
            Navigator.pop(context);
            Utils.showSuccessMessage(
                context: context,
                e: S.of(context).success_remove,
                onClose: () {
                  Navigator.pushNamedAndRemoveUntil(context,
                      DeliveryListScreen.routeName, ((route) => route.isFirst));
                });
          }).catchError((e) {
            Navigator.pop(context);
            Utils.showErrorMessage(context, e);
          });
        });
  }
}
