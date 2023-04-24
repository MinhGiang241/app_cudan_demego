import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../models/letter_history.dart';
import '../../../../models/manage_card.dart';
import '../../../../models/resident_card.dart';
import '../../../../models/response_thecudan_list.dart';
import '../../../../services/api_history.dart';
import '../../../../services/api_resident_card.dart';
import '../../../../services/api_tower.dart';
import '../../../../services/api_transport.dart';
import '../../../../utils/utils.dart';
import '../resident_card_screen.dart';

class ResidentCardPrv extends ChangeNotifier {
  ResidentCardPrv();
  final List<ResidentCard> resCardList = [];
  final List<ManageCard> manageCardList = [];

  getData(BuildContext context) async {
    try {
      var residentId = context.read<ResidentInfoPrv>().residentId;
      var apartmentId =
          context.read<ResidentInfoPrv>().selectedApartment?.apartmentId;
      await getResidentCardByResidentId(residentId, apartmentId);
      await getManageCardList(residentId, apartmentId);

      notifyListeners();
    } catch (e) {
      Utils.showErrorMessage(context, e.toString());
    }
  }

  getResidentCardByResidentId(residentId, apartmentId) async {
    resCardList.clear();

    await APIResCard.getResidentCardById(residentId, apartmentId).then((v) {
      v.forEach((e) {
        resCardList.add(ResidentCard.fromMap(e));
      });
      notifyListeners();
    });
  }

  getManageCardList(residentId, apartmentId) async {
    APIResCard.getManageCardList(residentId, apartmentId).then((v) {
      manageCardList.clear();
      for (var i in v) {
        manageCardList.add(ManageCard.fromMap(i));
      }
      notifyListeners();
      print(manageCardList);
    });
  }

  extend(BuildContext context) {}
  missingReport(BuildContext context, ManageCard card) async {
    card.status = "LOST";
    card.reasons = 'BAOMAT';
    Utils.showConfirmMessage(
      title: S.of(context).report_missing_card_res,
      content: S.of(context).confirm_missing_report_res(card.serial_lot ?? ""),
      context: context,
      child: Column(
        children: [
          vpad(12),
          Text(
            S.of(context).when_missing,
            style: txtRegular(12, redColorBase),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      onConfirm: () async {
        Navigator.pop(context);
        await APITransport.saveManageCard(card.toMap()).then((v) {
          var his = CardHistory(
            status: "LOST",
            action: "Báo mất",
            content: "Người dùng báo mất thẻ",
            manageCardId: card.id,
            perform_date: DateTime.now()
                .subtract(const Duration(hours: 7))
                .toIso8601String(),
          );
          APIHistory.saveHistoryCard(his.toMap());
          Utils.showSuccessMessage(
            context: context,
            e: S.of(context).success_report_missing,
            onClose: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                ResidentCardListScreen.routeName,
                (route) => route.isFirst,
                arguments: 0,
              );
            },
          );
        }).catchError((e) {
          Utils.showErrorMessage(context, e);
        });
      },
    );
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
                arguments: 1,
              );
            },
          );
        }).catchError((e) {
          Utils.showErrorMessage(context, e);
        });
      },
    );
  }

  Future cancelResCard(BuildContext context, ManageCard card) async {
    card.status = "LOCK";
    card.reasons = 'NGUOIDUNGKHOA';
    Utils.showConfirmMessage(
      title: S.of(context).can_trans_res,
      content: S.of(context).confirm_can_trans_card_res,
      context: context,
      onConfirm: () async {
        Navigator.pop(context);
        await APITransport.saveManageCard(card.toMap()).then((v) {
          var his = CardHistory(
            status: "LOCK",
            action: "Khóa thẻ",
            content: "Người dùng khóa thẻ",
            manageCardId: card.id,
            perform_date: DateTime.now()
                .subtract(const Duration(hours: 7))
                .toIso8601String(),
          );
          APIHistory.saveHistoryCard(his.toMap());
          Utils.showSuccessMessage(
            context: context,
            e: S.of(context).success_can_res_card,
            onClose: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                ResidentCardListScreen.routeName,
                (route) => route.isFirst,
                arguments: 0,
              );
            },
          );
        }).catchError((e) {
          Utils.showErrorMessage(context, e);
        });
      },
    );
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
        APIResCard.changeStatus(data.toMap()).then((v) {
          Utils.showSuccessMessage(
            context: context,
            e: S.of(context).success_send_req,
            onClose: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                ResidentCardListScreen.routeName,
                (route) => route.isFirst,
                arguments: 1,
              );
            },
          );
        }).catchError((e) {
          Utils.showErrorMessage(context, e);
        });
      },
    );
  }

  cancelLetter(BuildContext context, ResidentCard card) {
    Utils.showConfirmMessage(
      context: context,
      title: S.of(context).cancel_request,
      content: S.of(context).confirm_cancel_request(card.code ?? ""),
      onConfirm: () {
        card.ticket_status = 'CANCEL';
        card.reasons = 'NGUOIDUNGHUY';

        // APIResCard.saveResidentCard(card.toJson())
        APIResCard.changeStatus(card.toMap()).then((v) {
          Navigator.pop(context);
          Utils.showSuccessMessage(
            context: context,
            e: S.of(context).success_can_req,
            onClose: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                ResidentCardListScreen.routeName,
                (route) => route.isFirst,
                arguments: 1,
              );
            },
          );
        }).catchError((e) {
          Navigator.pop(context);
          Utils.showErrorMessage(context, e);
        });
      },
    );
  }

  Future<void> retry() async {}
}
