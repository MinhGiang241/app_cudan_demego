import 'package:app_cudan/models/transportation_card.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/screens/services/parking_card/transport_card_list_screen.dart';
import 'package:app_cudan/services/api_transportation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../models/response_parking_card_model.dart';
import '../../../../services/api_tower.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/primary_button.dart';
import '../../../../widgets/primary_dialog.dart';
import '../../../services/gym_card/gym_card_list_screen.dart';

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
  lockCard(BuildContext context, String id) async {
    Utils.showConfirmMessage(
        title: S.of(context).lock_card,
        content: S.of(context).confirm_lock_trans_card,
        context: context,
        onConfirm: () async {
          APITrans.lockTransportationCard(id).then((v) {
            Utils.showSuccessMessage(
                context: context,
                e: S.of(context).success_lock_card,
                onClose: () {
                  Navigator.pushReplacementNamed(
                      context, TransportationCardListScreen.routeName);
                });
          }).catchError((e) {});
        });
  }

//letter
  cancelLetter(BuildContext context) {}
  sendRequest(BuildContext context, String id) async {
    Utils.showConfirmMessage(
        title: S.of(context).send_request,
        content: S.of(context).confirm_send_request,
        context: context,
        onConfirm: () async {
          await APITrans.sendToApproveTransportationCard(id).then((v) {
            Utils.showSuccessMessage(
                context: context,
                e: S.of(context).success_send_req_trans,
                onClose: () {
                  Navigator.pushReplacementNamed(
                      context, TransportationCardListScreen.routeName);
                });
          }).catchError((e) {
            Navigator.pop(context);
            Utils.showErrorMessage(context, e);
          });
        });
  }

  editLetter(BuildContext context) {}
  deleteLetter(BuildContext context, String id) {
    Utils.showConfirmMessage(
        title: S.of(context).delete_letter,
        content: S
            .of(context)
            .confirm_delete_service(S.of(context).trans_letter.toLowerCase()),
        context: context,
        onConfirm: () async {
          await APITrans.removeTransportationCard(id).then((v) {
            Utils.showSuccessMessage(
                context: context,
                e: S
                    .of(context)
                    .success_remove(S.of(context).trans_letter.toLowerCase()),
                onClose: () {
                  Navigator.pushReplacementNamed(
                      context, TransportationCardListScreen.routeName);
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
