import 'package:flutter/cupertino.dart';

import '../../../../generated/l10n.dart';
import '../../../../models/letter_history.dart';
import '../../../../models/manage_card.dart';
import '../../../../models/transportation_card.dart';
import '../../../../services/api_history.dart';
import '../../../../services/api_transport.dart';
import '../../../../services/api_transportation.dart';
import '../../../../utils/utils.dart';
import '../manage_card_details_screen.dart';

class ManageCardDetailsPrv extends ChangeNotifier {
  ManageCardDetailsPrv(this.cancel);
  ManageCard card = ManageCard();
  Function? cancel;
  List<CardHistory> historyList = [];
  Future getHistoryCard() async {
    APIHistory.getHistoryCard(card.id).then((v) {
      if (v != null) {
        historyList.clear();
        for (var i in v) {
          historyList.add(CardHistory.fromMap(i));
        }
      }
      historyList.sort(
        (a, b) => b.perform_date!.compareTo(a.perform_date ?? ""),
      );
    });
  }

  Future getManageCardById(BuildContext context, String? id) async {
    return APITrans.getManageCarById(id).then((v) {
      card = ManageCard.fromMap(v);
    });
  }

  Future cancelTranport(BuildContext context, int index) async {
    List<TransportItem>? listTransport =
        (card.t?.transports_list ?? []).map((e) => e.copyWith()).toList();
    try {
      if (listTransport.length <= 1) {
        throw (S.of(context).trans_card_atleast_1);
      }

      Utils.showConfirmMessage(
        title: S.of(context).cancel_transport,
        content: S
            .of(context)
            .confirm_cancel_trans(listTransport[index].number_plate ?? ""),
        context: context,
        onConfirm: () async {
          TransportCard? transportCard = card.t?.copyWith();
          transportCard?.transports_list =
              List.from(listTransport..removeAt(index));
          Navigator.pop(context);
          await APITransport.saveTransportLetter(
            transportCard!.toMap(),
            true,
            true,
          ).then((v) {
            Utils.showSuccessMessage(
              context: context,
              e: S.of(context).success_cancel_trans,
              onClose: () {
                // Navigator.pop(context);
                // Navigator.pushNamedAndRemoveUntil(
                //   context,
                //   ManageCardDetailsScreen.routeName,
                //   (route) => route.isFirst,
                //   arguments: {
                //     "card": card,
                //     "cancel": cancel,
                //   },
                // );
              },
            );
          }).catchError((e) {
            Utils.showErrorMessage(context, e);
          });
        },
      );
    } catch (e) {
      Utils.showErrorMessage(context, e.toString());
    }
  }
}
