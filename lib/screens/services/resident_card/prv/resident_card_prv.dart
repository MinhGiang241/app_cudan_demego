import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../../../models/resident_card.dart';
import '../../../../models/response_thecudan_list.dart';
import '../../../../services/api_resident_card.dart';
import '../../../../services/api_tower.dart';
import '../../../../utils/utils.dart';
import '../resident_card_screen.dart';

class ResidentCardPrv extends ChangeNotifier {
  ResidentCardPrv();
  final List<ResidentCard> resCardList = [];

  getResidentCardByResidentId(BuildContext context, String id) async {
    resCardList.clear();

    await APIResCard.getResidentCardById(id).then((v) {
      v.forEach((e) {
        resCardList.add(ResidentCard.fromJson(e));
      });
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }

  extend(BuildContext context) {}
  missingReport(BuildContext context) {}
  lockCard(BuildContext context, ResidentCard card) {
    Utils.showConfirmMessage(
        context: context,
        title: S.of(context).lock_card,
        content: S.of(context).confirm_lock_card(card.code ?? ""),
        onConfirm: () async {
          card.card_status = "INACTIVE";
          APIResCard.saveResidentCard(card.toJson()).then((v) {
            Navigator.pop(context);
            Utils.showSuccessMessage(
                context: context,
                e: S.of(context).success_lock_card,
                onClose: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context,
                      ResidentCardListScreen.routeName,
                      (route) => route.isFirst);
                });
          }).catchError((e) {
            Navigator.pop(context);
            Utils.showErrorMessage(context, e);
          });
        });
  }

  deleteLetter(
    BuildContext context,
    ResidentCard card,
  ) async {
    Utils.showConfirmMessage(
        context: context,
        title: S.of(context).delete_letter,
        content: S.of(context).confirm_delete_letter(card.code ?? ""),
        onConfirm: () async {
          Navigator.pop(context);
          await APIResCard.removeResidentCard(card.id ?? "").then((v) {
            Utils.showSuccessMessage(
                context: context,
                e: S.of(context).success_remove,
                onClose: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context,
                      ResidentCardListScreen.routeName,
                      (route) => route.isFirst,
                      arguments: 1);
                });
          }).catchError((e) {
            Utils.showErrorMessage(context, e);
          });
        });
  }

  editLetter(BuildContext context) {}
  sendRequest(BuildContext context, ResidentCard data) {
    data.ticket_status = 'WAIT';
    Utils.showConfirmMessage(
        title: S.of(context).send_request,
        content: S.of(context).confirm_send_request(data.code ?? ''),
        context: context,
        onConfirm: () {
          Navigator.pop(context);
          // APIResCard.saveResidentCard(data.toJson())
          APIResCard.changeStatus(data.toJson()).then((v) {
            Utils.showSuccessMessage(
                context: context,
                e: S.of(context).success_send_req,
                onClose: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context,
                      ResidentCardListScreen.routeName,
                      (route) => route.isFirst,
                      arguments: 1);
                });
          }).catchError((e) {
            Utils.showErrorMessage(context, e);
          });
        });
  }

  cancelLetter(BuildContext context, ResidentCard card) {
    Utils.showConfirmMessage(
        context: context,
        title: S.of(context).cancel_request,
        content: S.of(context).confirm_cancel_request(card.code ?? ""),
        onConfirm: () {
          card.ticket_status = 'CANCEL';
          card.reasons = 'NGUOIDUNGHUY';
          Navigator.pop(context);
          // APIResCard.saveResidentCard(card.toJson())
          APIResCard.changeStatus(card.toJson()).then((v) {
            Navigator.pop(context);
            Utils.showSuccessMessage(
                context: context,
                e: S.of(context).success_can_req,
                onClose: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context,
                      ResidentCardListScreen.routeName,
                      (route) => route.isFirst,
                      arguments: 1);
                });
          }).catchError((e) {
            Navigator.pop(context);
            Utils.showErrorMessage(context, e);
          });
        });
  }

  Future<void> retry() async {}
}
