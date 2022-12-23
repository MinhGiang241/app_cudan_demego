import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/services/api_pet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/pet.dart';
import '../../../../utils/utils.dart';

class PetListPrv extends ChangeNotifier {
  List<Pet> listPet = [];
  getPetList(BuildContext context) async {
    await APIPet.getPetList(context.read<ResidentInfoPrv>().residentId,
            context.read<ResidentInfoPrv>().selectedApartment!.apartmentId)
        .then((v) {
      listPet.clear();
      for (var i in v) {
        listPet.add(Pet.fromJson(i));
      }
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }
}
