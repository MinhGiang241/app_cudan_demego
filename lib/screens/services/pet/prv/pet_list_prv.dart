import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/services/api_pet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../../../../models/pet.dart';
import '../../../../utils/utils.dart';
import '../pet_list_screen.dart';

class PetListPrv extends ChangeNotifier {
  List<Pet> listPet = [];

  cancelRequetsAprrove(BuildContext context, Pet p) async {
    var data = p.copyWith();
    data.pet_status = 'CANCEL';
    data.reasons = 'NGUOIDUNGHUY';
    Utils.showConfirmMessage(
      context: context,
      title: S.of(context).cancel_request,
      content: S.of(context).confirm_cancel_request(data.code ?? ""),
      onConfirm: () {
        Navigator.pop(context);
        // APIPet.savePet(data.toJson())
        APIPet.changeStatus(data.toJson()).then(
          (v) {
            Utils.showSuccessMessage(
              context: context,
              e: S.of(context).success_can_req,
              onClose: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  PetListScreen.routeName,
                  ((route) => route.isFirst),
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

  deleteLetter(BuildContext context, Pet data) {
    Utils.showConfirmMessage(
      context: context,
      title: S.of(context).delete_letter,
      content: S.of(context).confirm_delete_letter(data.code ?? ''),
      onConfirm: () async {
        Navigator.pop(context);
        await APIPet.deletePet(data.id ?? "").then((v) {
          Utils.showSuccessMessage(
            context: context,
            e: S.of(context).success_remove,
            onClose: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                PetListScreen.routeName,
                ((route) => route.isFirst),
              );
            },
          );
        }).catchError((e) {
          Utils.showErrorMessage(context, e);
        });
      },
    );
  }

  sendToApprove(BuildContext context, Pet p) {
    var data = p.copyWith();
    data.pet_status = 'WAIT';
    data.isMobile = true;
    Utils.showConfirmMessage(
      context: context,
      title: S.of(context).send_request,
      content: S.of(context).confirm_send_request(data.code ?? ""),
      onConfirm: () {
        Navigator.pop(context);
        // APIPet.savePet(data.toJson())
        APIPet.changeStatus(data.toJson()).then((v) {
          Utils.showSuccessMessage(
            context: context,
            e: S.of(context).success_send_req,
            onClose: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                PetListScreen.routeName,
                (route) => route.isFirst,
              );
            },
          );
        }).catchError((e) {
          Utils.showErrorMessage(context, e);
        });
      },
    );
  }

  getPetList(BuildContext context) async {
    if (context.read<ResidentInfoPrv>().selectedApartment == null) return;
    await APIPet.getPetList(
      context.read<ResidentInfoPrv>().residentId,
      context.read<ResidentInfoPrv>().selectedApartment?.apartmentId,
    ).then((v) {
      listPet.clear();
      for (var i in v) {
        listPet.add(Pet.fromJson(i));
      }
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }
}
