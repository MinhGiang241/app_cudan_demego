import 'package:app_cudan/models/transportation_card.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
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
  lockCard(BuildContext context) {}

//letter
  cancelLetter(BuildContext context) {}
  sendRequest(BuildContext context) {}
  editLetter(BuildContext context) {}
  deleteLetter(BuildContext context) {}

//old

  Future retry() async {
    parkingCardsList = null;
    notifyListeners();
  }
}
