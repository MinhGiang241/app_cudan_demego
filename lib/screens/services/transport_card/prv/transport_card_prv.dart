// ignore_for_file: unused_local_variable

import 'package:app_cudan/constants/constants.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/services/api_transport.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../../../../models/manage_card.dart';
import '../../../../models/transportation_card.dart';
import '../../../../utils/utils.dart';
import '../transport_card_screen.dart.dart';

class TransportCardPrv extends ChangeNotifier {
  List<TransportCard> letterList = [];
  List<ManageCard> cardList = [];

  Future cancelTransportCard(
    BuildContext context,
    ManageCard card,
  ) async {
    Utils.showConfirmMessage(
      title: S.of(context).can_trans,
      content: S.of(context).confirm_can_trans_card,
      context: context,
      onConfirm: () async {
        Navigator.pop(context);
        var submitCard = card.copyWith();
        submitCard.status = "DESTROY";
        submitCard.reasons = 'NGUOIDUNGKHOA';
        var d = submitCard.toMap();
        var acc = context.read<ResidentInfoPrv>().userInfo?.account?.phone;
        var accName =
            context.read<ResidentInfoPrv>().userInfo?.account?.fullName;
        var resName = context.read<ResidentInfoPrv>().userInfo?.info_name;
        var residentId = context.read<ResidentInfoPrv>().residentId;
        await APITransport.lockManageCard(d)
            // .then((v) {
            //   var his = CardHistory(
            //     status: "DESTROY",
            //     residentId: residentId,
            //     person: resName ?? accName ?? acc,
            //     name: resName ?? accName ?? acc,
            //     action: "Hủy thẻ",
            //     content: "Người dùng hủy thẻ",
            //     manageCardId: card.id,
            //     perform_date: DateTime.now()
            //         .subtract(const Duration(hours: 7))
            //         .toIso8601String(),
            //   );
            //   return APIHistory.saveHistoryCard(his.toMap());
            // })
            .then((v) {
          Utils.showSuccessMessage(
            context: context,
            e: S.of(context).success_can_trans_card,
            onClose: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                TransportCardScreen.routeName,
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

  Future getTransportCardList(BuildContext context) async {
    var residentId = context.read<ResidentInfoPrv>().residentId;
    var apartmentId =
        context.read<ResidentInfoPrv>().selectedApartment?.apartmentId;
    var userInfo = context.read<ResidentInfoPrv>().userInfo;
    await APITransport.getTransportCardList(
      residentId,
      apartmentId,
      userInfo?.account?.phone ?? userInfo?.account?.userName,
    ).then((v) {
      cardList.clear();
      for (var i in v) {
        cardList.add(ManageCard.fromMap(i));
      }
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }

  Future getTransportLetterList(BuildContext context) async {
    var residentId = context.read<ResidentInfoPrv>().residentId;
    var apartmentId =
        context.read<ResidentInfoPrv>().selectedApartment?.apartmentId;
    var userInfo = context.read<ResidentInfoPrv>().userInfo;
    await APITransport.getTransportLetterList(
      residentId,
      apartmentId,
      true,
      userInfo?.account?.phone ?? userInfo?.account?.userName,
    ).then((v) {
      letterList.clear();

      for (var i in v) {
        letterList.add(TransportCard.fromMap(i));
      }

      notifyListeners();
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }

  Future sendApprove(BuildContext context, TransportCard card) async {
    Utils.showConfirmMessage(
      title: S.of(context).send_request,
      content: S.of(context).confirm_send_request(card.code ?? ""),
      context: context,
      onConfirm: () async {
        Navigator.pop(context);
        await APITransport.sendToApproveTransportationCard(card.id ?? "")
            .then((v) {
          Utils.showSuccessMessage(
            context: context,
            e: S.of(context).success_send_req,
            onClose: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                TransportCardScreen.routeName,
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

  cancelLetter(BuildContext context, TransportCard card) async {
    Utils.showConfirmMessage(
      context: context,
      title: S.of(context).cancel_request,
      content: S.of(context).confirm_cancel_request(card.code ?? ""),
      onConfirm: () async {
        var submitCard = card.copyWith();
        submitCard.ticket_status = "CANCEL";
        submitCard.reasons = "NGUOIDUNGHUY";
        Navigator.pop(context);
        // await APITrans.saveTransportationCard(card.toJson())
        await APITransport.changeStatus(submitCard.toMap()).then(
          (v) {
            Utils.showSuccessMessage(
              context: context,
              e: S.of(context).success_can_req,
              onClose: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  TransportCardScreen.routeName,
                  (route) => route.isFirst,
                  arguments: 1,
                );
              },
            );
          },
        ).catchError((e) {
          Utils.showErrorMessage(context, e);
        });
      },
    );
  }

  deleteLetter(
    BuildContext context,
    TransportCard card,
  ) {
    Utils.showConfirmMessage(
      title: S.of(context).delete_letter,
      content: S.of(context).confirm_delete_letter(card.code ?? ''),
      context: context,
      onConfirm: () async {
        Navigator.pop(context);
        await APITransport.removeTransportationCard(card.id ?? "").then((v) {
          Utils.showSuccessMessage(
            context: context,
            e: S.of(context).success_remove,
            onClose: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                TransportCardScreen.routeName,
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

  missingReport(BuildContext context, ManageCard card) async {
    Utils.showConfirmMessage(
      title: S.of(context).report_missing_card,
      content: S.of(context).confirm_missing_report(card.as?.serial ?? ""),
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
        var submitCard = card.copyWith();

        submitCard.status = "LOST";
        submitCard.reasons = 'BAOMAT';
        var acc = context.read<ResidentInfoPrv>().userInfo?.account?.phone;
        var accName =
            context.read<ResidentInfoPrv>().userInfo?.account?.fullName;
        var resName = context.read<ResidentInfoPrv>().userInfo?.info_name;
        var residentId = context.read<ResidentInfoPrv>().residentId;
        await APITransport.reportMissingTransportCard(submitCard.toMap())
            //     .then((v) {
            //   var his = CardHistory(
            //     status: "LOST",
            //     residentId: residentId,
            //     person: resName ?? accName ?? acc,
            //     name: resName ?? accName ?? acc,
            //     action: "Báo mất",
            //     content: "Người dùng báo mất thẻ",
            //     manageCardId: card.id,
            //     perform_date: DateTime.now()
            //         .subtract(const Duration(hours: 7))
            //         .toIso8601String(),
            //   );
            //   return APIHistory.saveHistoryCard(his.toMap());
            // })
            .then((v) {
          Utils.showSuccessMessage(
            context: context,
            e: S.of(context).success_report_missing,
            onClose: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                TransportCardScreen.routeName,
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
}
