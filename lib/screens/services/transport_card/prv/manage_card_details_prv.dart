import 'package:app_cudan/models/list_transport.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../../../../models/letter_history.dart';
import '../../../../models/manage_card.dart';
import '../../../../models/transportation_card.dart';
import '../../../../services/api_history.dart';
import '../../../../services/api_transport.dart';
import '../../../../services/api_transportation.dart';
import '../../../../utils/utils.dart';
import '../../../auth/prv/resident_info_prv.dart';

class ManageCardDetailsPrv extends ChangeNotifier {
  ManageCardDetailsPrv(this.cancel);
  ManageCard card = ManageCard();
  Function? cancel;
  List<CardHistory> historyList = [];
  List<ListTransport> listTranspost = [];
  Future getListTransport(String? id) async {
    await APITransport.getListTransportByManageCardId(id).then((v) {
      listTranspost.clear();
      if (v != null) {
        for (var i in v) {
          listTranspost.add(ListTransport.fromMap(i));
        }
      }
      notifyListeners();
    });
  }

  Future getHistoryCard(id) async {
    await APIHistory.getHistoryCard(id).then((v) {
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
      return getListTransport(id);
    });
  }

  Future cancelTranport(BuildContext context, int index, String? id) async {
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
          await APITransport.deleteListTransport(id)
              // .then((v) {
              //   var acc =
              //       context.read<ResidentInfoPrv>().userInfo?.account?.phone_number;
              //   var accName =
              //       context.read<ResidentInfoPrv>().userInfo?.account?.fullName;
              //   var resName = context.read<ResidentInfoPrv>().userInfo?.info_name;
              //   var residentId = context.read<ResidentInfoPrv>().residentId;
              //   var his = CardHistory(
              //     status: card.status,
              //     residentId: residentId,
              //     person: resName ?? accName ?? acc,
              //     name: resName ?? accName ?? acc,
              //     action: "Hủy phương tiện",
              //     content: "Người dùng hủy phương tiện",
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
            listTranspost.removeAt(index);
            notifyListeners();
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
