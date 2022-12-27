import 'package:app_cudan/models/missing_object.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/services/api_lost.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../../../../utils/utils.dart';
import '../missing_object_screen.dart';

class MissingObjectPrv extends ChangeNotifier {
  MissingObjectPrv({this.year, this.month}) {
    year ??= DateTime.now().year;
    month ??= DateTime.now().month;
  }
  int? year;
  int? month;
  List<MissingObject> lostList = [];
  List<LootItem> lootList = [];
  onChooseMonthYear(DateTime v) {
    year = v.year;
    month = v.month;
    notifyListeners();
  }

  saveLostItem(BuildContext context, MissingObject lost) async {
    lost.status = "FOUND";
    // var apartment = context.read<ResidentInfoPrv>()
    // lost.apartment = "${context}";
    await APILost.saveLostItem(lost.toJson()).then((v) {
      Utils.showSuccessMessage(
          context: context,
          e: S.of(context).success_returned,
          onClose: () {
            Navigator.pushNamedAndRemoveUntil(
                context, MissingObectScreen.routeName, (route) => route.isFirst,
                arguments: {
                  'year': year,
                  'month': month,
                  'index': 0,
                });
          });
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }

  saveLootItem(BuildContext context, LootItem loot) async {
    loot.status = "RETURNED";
    await APILost.saveLootItem(loot.toJson()).then((v) {
      Utils.showSuccessMessage(
          context: context,
          e: S.of(context).success_returned,
          onClose: () {
            Navigator.pushNamedAndRemoveUntil(
                context, MissingObectScreen.routeName, (route) => route.isFirst,
                arguments: {
                  'year': year,
                  'month': month,
                  'index': 0,
                });
          });
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }

  getLostItemList(BuildContext context) async {
    return await APILost.getLostItemList(year!, month!,
            context.read<ResidentInfoPrv>().userInfo!.phone_required ?? "")
        .then((v) {
      lostList.clear();
      for (var i in v) {
        lostList.add(MissingObject.fromJson(i));
      }
      notifyListeners();
      return APILost.getLootItemList(year!, month!,
          context.read<ResidentInfoPrv>().userInfo!.phone_required ?? "");
    }).then((v) {
      lootList.clear();
      for (var i in v) {
        lootList.add(LootItem.fromJson(i));
      }
      notifyListeners();
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }
}
