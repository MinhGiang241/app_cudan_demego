import 'package:app_cudan/models/form_add_resident.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/services/api_resident_add_apartment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterResidentPrv extends ChangeNotifier {
  List<FormAddResidence> listForm = [];
  getListForm(BuildContext context) async {
    var residentId = context.read<ResidentInfoPrv>().residentId;
    APIResidentAddApartment.getFormResidentAddApartment(residentId ?? "")
        .then((v) {
      listForm.clear();
      for (var i in v) {
        listForm.add(FormAddResidence.fromMap(i));
      }
    });
  }
}
