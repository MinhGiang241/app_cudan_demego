import 'package:app_cudan/models/transportation_card.dart';
import 'package:app_cudan/screens/services/parking_card/transport_card_list_screen.dart';
import 'package:app_cudan/services/api_transportation.dart';
import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../../../models/response_parking_card_model.dart';
import '../../../../utils/utils.dart';

class ParkingCardProvider extends ChangeNotifier {
  //parkingcard
  ResponseParkingCardsList? parkingCardsList;

  List<TransportationCard> transportationCardList = [];

  bool isLoading = true;

  ParkingCardProvider();

  getTrasportCardList(BuildContext context, String? residentId) async {
    transportationCardList.clear();

    await APITrans.getTransportCardList(
      residentId!,
    ).then((v) {
      v.forEach((e) {
        transportationCardList.add(TransportationCard.fromJson(e));
      });
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });

    isLoading = false;
    // notifyListeners();
  }

  //card
  extendCard(BuildContext context) {}
  missingReport(BuildContext context) {}
  lockCard(BuildContext context, TransportationCard card) async {
    Utils.showConfirmMessage(
        title: S.of(context).lock_card,
        content: S.of(context).confirm_lock_card(card.code ?? ""),
        context: context,
        onConfirm: () async {
          APITrans.lockTransportationCard(card.id ?? "").then((v) {
            Navigator.pop(context);
            Utils.showSuccessMessage(
                context: context,
                e: S.of(context).success_lock_card,
                onClose: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context,
                      TransportationCardListScreen.routeName,
                      (route) => route.isFirst,
                      arguments: 0);
                });
          }).catchError((e) {
            Navigator.pop(context);
            Utils.showErrorMessage(context, e);
          });
        });
  }

//letter
  cancelLetter(BuildContext context, TransportationCard card) async {
    Utils.showConfirmMessage(
      context: context,
      title: S.of(context).cancel_request,
      content: S.of(context).confirm_cancel_request(card.code ?? ""),
      onConfirm: () async {
        card.ticket_status = "CANCEL";
        card.reasons = "NGUOIDUNGHUY";
        await APITrans.saveTransportationCard(card.toJson()).then(
          (v) {
            Navigator.pop(context);
            Utils.showSuccessMessage(
              context: context,
              e: S.of(context).success_can_req,
              onClose: () {
                Navigator.pushNamedAndRemoveUntil(
                    context,
                    TransportationCardListScreen.routeName,
                    (route) => route.isFirst,
                    arguments: 1);
              },
            );
          },
        ).catchError((e) {
          Navigator.pop(context);
          Utils.showErrorMessage(context, e);
        });
      },
    );
  }

  sendRequest(
    BuildContext context,
    TransportationCard card,
  ) async {
    Utils.showConfirmMessage(
        title: S.of(context).send_request,
        content: S.of(context).confirm_send_request(card.code ?? ""),
        context: context,
        onConfirm: () async {
          await APITrans.sendToApproveTransportationCard(card.id ?? "")
              .then((v) {
            Navigator.pop(context);
            Utils.showSuccessMessage(
                context: context,
                e: S.of(context).success_send_req,
                onClose: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context,
                      TransportationCardListScreen.routeName,
                      (route) => route.isFirst,
                      arguments: 1);
                });
          }).catchError((e) {
            Navigator.pop(context);
            Utils.showErrorMessage(context, e);
          });
        });
  }

  editLetter(BuildContext context) {}
  deleteLetter(
    BuildContext context,
    TransportationCard card,
  ) {
    Utils.showConfirmMessage(
        title: S.of(context).delete_letter,
        content: S.of(context).confirm_delete_letter(card.code ?? ''),
        context: context,
        onConfirm: () async {
          await APITrans.removeTransportationCard(card.id ?? "").then((v) {
            Navigator.pop(context);
            Utils.showSuccessMessage(
                context: context,
                e: S.of(context).success_remove,
                onClose: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context,
                      TransportationCardListScreen.routeName,
                      (route) => route.isFirst,
                      arguments: 1);
                });
          }).catchError((e) {
            Navigator.pop(context);
            Utils.showErrorMessage(context, e);
          });
        });
  }

//old

  Future retry() async {
    parkingCardsList = null;
    notifyListeners();
  }
}
