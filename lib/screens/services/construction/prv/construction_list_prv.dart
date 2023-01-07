import 'package:app_cudan/models/construction.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/services/api_construction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n.dart';
import '../../../../utils/utils.dart';
import '../construction_list_screen.dart';

class ConstructionListPrv extends ChangeNotifier {
  List<ConstructionRegistration> listRegistration = [];
  List<ConstructionDocument> listDocument = [];

  sendToApprove(BuildContext context, ConstructionRegistration data) async {
    data.status = 'WAIT_TECHNICAL';
    data.isMobile = true;
    Utils.showConfirmMessage(
        context: context,
        title: S.of(context).send_request,
        content: S.of(context).confirm_send_request(data.code ?? ""),
        onConfirm: () {
          Navigator.pop(context);
          // APIConstruction.saveConstructionRegistration(data.toJson())
          APIConstruction.changeStatus(data.toJson()).then((v) {
            ConstructionHistory conHis = ConstructionHistory(
              constructionregistrationId: data.id,
              date: DateTime.now()
                  .subtract(const Duration(hours: 7))
                  .toIso8601String(),
              residentId: context.read<ResidentInfoPrv>().residentId,
              person: context.read<ResidentInfoPrv>().userInfo!.info_name,
              status: "WAIT_TECHNICAL",
            );
            return APIConstruction.saveConstructionHistory(conHis.toJson());
          }).then((v) {
            Utils.showSuccessMessage(
                context: context,
                e: S.of(context).success_send_req,
                onClose: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context,
                      ConstructionListScreen.routeName,
                      (route) => route.isFirst);
                });
          }).catchError((e) {
            Utils.showErrorMessage(context, e);
          });
        });
  }

  cancelRequetsAprrove(
      BuildContext context, ConstructionRegistration data) async {
    data.status = 'CANCEL';
    data.cancel_reason = 'NGUOIDUNGHUY';
    data.isMobile = true;
    Utils.showConfirmMessage(
        context: context,
        title: S.of(context).cancel_request,
        content: S.of(context).confirm_cancel_request(data.code ?? ""),
        onConfirm: () {
          Navigator.pop(context);
          // APIConstruction.saveConstructionRegistration(data.toJson())
          APIConstruction.changeStatus(data.toJson()).then((v) {
            ConstructionHistory conHis = ConstructionHistory(
              constructionregistrationId: data.id,
              date: DateTime.now()
                  .subtract(const Duration(hours: 7))
                  .toIso8601String(),
              residentId: context.read<ResidentInfoPrv>().residentId,
              person: context.read<ResidentInfoPrv>().userInfo!.info_name,
              status: "CANCEL",
            );
            return APIConstruction.saveConstructionHistory(conHis.toJson());
          }).then((v) {
            Utils.showSuccessMessage(
                context: context,
                e: S.of(context).success_can_req,
                onClose: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context,
                      ConstructionListScreen.routeName,
                      (route) => route.isFirst);
                });
          }).catchError((e) {
            Utils.showErrorMessage(context, e);
          });
        });
  }

  deleteLetter(BuildContext context, ConstructionRegistration data) async {
    Utils.showConfirmMessage(
        context: context,
        title: S.of(context).delete_letter,
        content: S.of(context).confirm_delete_letter(data.code ?? ""),
        onConfirm: () {
          Navigator.pop(context);
          APIConstruction.removeConstructionRegistration(data.id ?? "")
              .then((v) {
            return APIConstruction.removeConstructionHistory(data.id ?? "");
          }).then((v) {
            Utils.showSuccessMessage(
                context: context,
                e: S.of(context).success_remove,
                onClose: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context,
                      ConstructionListScreen.routeName,
                      (route) => route.isFirst);
                });
          }).catchError((e) {
            Utils.showErrorMessage(context, e);
          });
        });
  }

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
      // notifyListeners();
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }
}
