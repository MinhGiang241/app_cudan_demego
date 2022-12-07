import 'package:app_cudan/models/extra_service.dart';
import 'package:app_cudan/models/service_registration.dart';
import 'package:app_cudan/services/api_extra_service.dart';
import 'package:app_cudan/services/api_service.dart';
import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../../../utils/utils.dart';
import '../extra_service_card_list.dart';

class ExtraServiceCardListPrv extends ChangeNotifier {
  ExtraServiceCardListPrv(
      {required this.extraService, required this.year, required this.month});
  List<ServiceRegistration> listCard = [];
  int year;
  int month;
  ExtraService extraService;
  getRegisterExtraServiceList(
      BuildContext context, String residentId, String serviceId) async {
    await APIExtraService.getServiceRegistration(
            residentId, serviceId, year, month)
        .then((v) {
      listCard.clear();
      for (var i in v) {
        listCard.add(ServiceRegistration.fromJson(i));
      }
      notifyListeners();
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }

  chooseMonthYear(int selectedYear, int selectedMonth) {
    // setState({});
    year = selectedYear;
    month = selectedMonth;
    notifyListeners();
  }

  cancelRequetsAprrove(BuildContext context, ServiceRegistration card) {
    Utils.showConfirmMessage(
        context: context,
        title: S.of(context).cancel_request,
        content: S.of(context).confirm_cancel_request(card.code ?? ""),
        onConfirm: () {
          card.status = 'CANCEL';
          card.cancel_reason = 'NGUOIDUNGHUY';
          card.isMobile = true;
          APIExtraService.saveRegistrationService(card.toJson()).then((v) {
            Navigator.pop(context);
            Utils.showSuccessMessage(
                context: context,
                e: S.of(context).success_can_req,
                onClose: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context,
                      ExtraServiceCardListScreen.routeName,
                      (route) => route.isFirst,
                      arguments: {
                        "service": extraService,
                        "year": year,
                        "month": month,
                      });
                });
          }).catchError((e) {
            Navigator.pop(context);
            Utils.showErrorMessage(context, e);
          });
        });
  }

  sendToApprove(BuildContext context, ServiceRegistration card) {
    card.status = 'WAIT';
    Utils.showConfirmMessage(
        title: S.of(context).send_request,
        content: S.of(context).confirm_send_request(card.code ?? ""),
        context: context,
        onConfirm: () {
          APIExtraService.saveRegistrationService(card.toJson()).then((v) {
            Navigator.pop(context);
            Utils.showSuccessMessage(
                context: context,
                e: S.of(context).success_send_req,
                onClose: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    ExtraServiceCardListScreen.routeName,
                    (route) => route.isFirst,
                    arguments: {
                      "service": extraService,
                      "year": year,
                      "month": month,
                    },
                  );
                });
          }).catchError((e) {
            Navigator.pop(context);
            Utils.showErrorMessage(context, e);
          });
        });
  }

  deleteLetter(BuildContext context, ServiceRegistration card) {
    Utils.showConfirmMessage(
        title: S.of(context).delete_letter,
        content: S.of(context).confirm_delete_letter(card.code ?? ''),
        context: context,
        onConfirm: () async {
          await APIExtraService.deleteRegistrationService(card.id ?? '')
              .then((v) {
            Navigator.pop(context);
            Utils.showSuccessMessage(
                context: context,
                e: S.of(context).success_remove(card.code ?? ""),
                onClose: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    ExtraServiceCardListScreen.routeName,
                    (route) => route.isFirst,
                    arguments: {
                      "service": extraService,
                      "year": year,
                      "month": month,
                    },
                  );
                });
          }).catchError((e) {
            Navigator.pop(context);
            Utils.showErrorMessage(context, e);
          });
        });
  }
}
