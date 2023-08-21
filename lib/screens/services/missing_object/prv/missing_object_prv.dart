import 'package:app_cudan/models/missing_object.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/services/api_lost.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../../../../utils/utils.dart';
import '../missing_object_screen.dart';

class MissingObjectPrv extends ChangeNotifier {
  MissingObjectPrv({this.year, this.month, this.initTab = 0}) {
    year ??= DateTime.now().year;
    month ??= DateTime.now().month;
  }

  var initIndex = 0;
  int? initTab;
  int? year;
  int? month;
  List<MissingObject> lostList = [];
  List<LootItem> lootList = [];

  bool isInitHis = true;
  bool isInitPic = true;

  int filterValuePick = 0;
  changeStatusListPick(v) {
    filterValuePick = v;
    notifyListeners();
  }

  int filterValueHistory = 0;
  changeStatusListHistory(v) {
    filterValueHistory = v;
    notifyListeners();
  }

  onChooseMonthYear(DateTime v) {
    year = v.year;
    month = v.month;
    isInitHis = false;
    isInitPic = false;
    notifyListeners();
  }

  saveLostItem(BuildContext context, MissingObject lost) async {
    var data = lost.toJson();
    data["status"] = "ACCEPT";
    data["find_time"] =
        (DateTime.now().subtract(const Duration(hours: 7))).toIso8601String();
    // var apartment = context.read<ResidentInfoPrv>()
    // lost.apartment = "${context}";
    await APILost.saveLostItem(data).then((v) {
      Utils.showSuccessMessage(
        context: context,
        e: S.of(context).success_confirm,
        onClose: () {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(
              context,
              MissingObectScreen.routeName,
              arguments: {
                'year': year,
                'month': month,
                'index': 0,
              },
            );
          });
        },
      );
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }

  saveLootItem(BuildContext context, LootItem loot) async {
    var data = loot.toJson();
    data["status"] = "RETURNED";
    data["time_pay"] =
        (DateTime.now().subtract(const Duration(hours: 7))).toIso8601String();
    await APILost.saveLootItem(data).then((v) {
      Utils.showSuccessMessage(
        context: context,
        e: S.of(context).returned,
        onClose: () {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(
              context,
              MissingObectScreen.routeName,
              arguments: {
                'year': year,
                'month': month,
                'index': 1,
              },
            );
          });
        },
      );
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }

  getLostItemList(BuildContext context) async {
    try {
      lostList.clear();
      lootList.clear();
      var phone = context.read<ResidentInfoPrv>().userInfo!.phone_required;
      var residentId = context.read<ResidentInfoPrv>().residentId;
      var apartmentId =
          context.read<ResidentInfoPrv>().selectedApartment?.apartmentId;
      var lost = await APILost.getLostItemList(
        year!,
        month!,
        phone ?? "",
        residentId,
        apartmentId,
        isInitHis,
      );
      for (var i in lost) {
        lostList.add(MissingObject.fromJson(i));
      }
      var loot = await APILost.getLootItemList(
        year!,
        month!,
        phone ?? "",
        residentId,
        apartmentId,
        isInitPic,
      );
      for (var i in loot) {
        lootList.add(LootItem.fromJson(i));
      }
      // notifyListeners();
    } catch (e) {
      Utils.showErrorMessage(context, e.toString());
    }
  }
}
