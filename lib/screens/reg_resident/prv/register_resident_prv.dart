import 'package:app_cudan/models/form_add_resident.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/services/api_resident_add_apartment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../models/dependence_sign_up.dart';
import '../../../utils/utils.dart';
import '../register_resident_screen.dart';

class RegisterResidentPrv extends ChangeNotifier {
  List<DependenceSignUp> listForm = [];
  String? sellectedApartment;
  onChangeApartment(v) {
    sellectedApartment = v;
  }

  getListForm(BuildContext context) async {
    var residentId = context.read<ResidentInfoPrv>().residentId;
    await APIResidentAddApartment.getFormResidentAddApartment(
      residentId ?? '',
      sellectedApartment,
    ).then((v) {
      listForm.clear();
      for (var i in v) {
        listForm.add(DependenceSignUp.fromMap(i));
      }
    });
  }

  cancelLetter(BuildContext context, DependenceSignUp data) async {
    data.status = 'CANCEL';
    data.reasons = 'NGUOIDUNGHUY';
    await Utils.showConfirmMessage(
      title: S.of(context).cancel_letter,
      context: context,
      content: S.of(context).confirm_cancel_request(data.ticket_code ?? ''),
      onConfirm: () async {
        await APIResidentAddApartment.changeStatusFormResidentAddApartment(
          data.toMap(),
        ).then((v) {
          Navigator.pop(context);
          Utils.showSuccessMessage(
            context: context,
            e: S.of(context).success_can_req,
            onClose: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                RegisterResidentScreen.routeName,
                (route) => route.isFirst,
              );
            },
          );
        }).catchError((e) {
          Navigator.pop(context);
          Utils.showErrorMessage(context, e);
        });
      },
    );
  }
}
