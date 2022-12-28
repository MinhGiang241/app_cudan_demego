import 'package:app_cudan/models/construction.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/services/api_construction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/utils.dart';

class ConstructionListPrv extends ChangeNotifier {
  List<ConstructionRegistration> listRegistration = [];
  List<ConstructionDocument> listDocument = [];
  getContructionDocumentList(BuildContext context) async {
    await APIConstruction.getConstructionDocumentList(
            context.read<ResidentInfoPrv>().residentId ?? "",
            context.read<ResidentInfoPrv>().selectedApartment!.apartmentId ??
                "")
        .then((v) {
      listDocument.clear();
      for (var i in v) {
        listDocument.add(ConstructionDocument.fromJson(i));
      }
      notifyListeners();
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }

  getContructionRegistrationLetterList(BuildContext context) async {
    await APIConstruction.getConstructionRegistrationList(
            context.read<ResidentInfoPrv>().residentId ?? "",
            context.read<ResidentInfoPrv>().selectedApartment!.apartmentId ??
                "")
        .then((v) {
      listRegistration.clear();
      for (var i in v) {
        listRegistration.add(ConstructionRegistration.fromJson(i));
      }
      notifyListeners();
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }
}
