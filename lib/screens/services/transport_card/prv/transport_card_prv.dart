import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/services/api_transport.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/manage_card.dart';
import '../../../../models/transportation_card.dart';
import '../../../../utils/utils.dart';

class TransportCardPrv extends ChangeNotifier {
  List<TransportCard> letterList = [];
  List<ManageCard> cardList = [];

  Future getTransportCardList(BuildContext context) async {
    var residentId = context.read<ResidentInfoPrv>().residentId;
    var apartmentId =
        context.read<ResidentInfoPrv>().selectedApartment?.apartmentId;
    await APITransport.getTransportCardList(
      residentId,
      apartmentId,
    ).then((v) {
      cardList.clear();
      for (var i in v) {
        cardList.add(ManageCard.fromMap(i));
      }

      notifyListeners();
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }

  Future getTransportLetterList(BuildContext context) async {
    var residentId = context.read<ResidentInfoPrv>().residentId;
    var apartmentId =
        context.read<ResidentInfoPrv>().selectedApartment?.apartmentId;
    await APITransport.getTransportLetterList(residentId, apartmentId, true)
        .then((v) {
      letterList.clear();
      for (var i in v) {
        letterList.add(TransportCard.fromMap(i));
      }

      notifyListeners();
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }
}
