import 'package:app_cudan/models/construction.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/services/api_construction.dart';
import 'package:app_cudan/widgets/primary_dialog.dart';
import 'package:app_cudan/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n.dart';
import '../../../../models/fiexed_date_service.dart';
import '../../../../models/receipt.dart';
import '../../../../utils/utils.dart';
import '../construction_list_screen.dart';

class ConstructionListPrv extends ChangeNotifier {
  List<ConstructionRegistration> listRegistration = [];
  List<ConstructionRegistration> listWaitRegistration = [];
  List<ConstructionDocument> listDocument = [];
  FixedDateService? fixedDateService;
  getFixedDate() async {
    await APIConstruction.getFixedDateService().then((v) {
      fixedDateService = FixedDateService.fromMap(v[0]);
    });
  }

  sendToApprove(BuildContext context, ConstructionRegistration data) async {
    List<Map<String, dynamic>> listReceipt = [];
    var resident = context.read<ResidentInfoPrv>().userInfo;
    var residentId = context.read<ResidentInfoPrv>().residentId;
    var apartment = context.read<ResidentInfoPrv>().listOwn.firstWhere((e) {
      return e.apartment!.id == data.apartmentId;
    });
    var status = (apartment.type == 'BUY' || apartment.type == "RENT")
        ? 'WAIT_PAY'
        : "WAIT_OWNER";
    data.status = status;
    data.isMobile = true;
    if (data.isContructionCost != true) {
      Receipt? receiptFee = Receipt(
          residentId: residentId,
          phone: resident?.phone_required,
          discount_money: data.construction_cost,
          refSchema: "ConstructionRegistration",
          type: "ContructionCost",
          payment_status: "UNPAID",
          amount_due: data.construction_cost,
          apartmentId: apartment.apartmentId,
          check: true,
          content: "Thanh toán phí thi công",
          reason: "Thanh toán phí thi công",
          customer_type: "RESIDENT",
          full_name: resident?.info_name,
          receipts_status: "NEW",
          expiration_date: DateTime.now()
              .add(Duration(days: fixedDateService!.cut_service_date ?? 0))
              .subtract(const Duration(hours: 7))
              .toIso8601String(),
          date: DateTime.now()
              .subtract(const Duration(hours: 7))
              .toIso8601String());
      listReceipt.add(receiptFee.toJson());
    }

    if (data.isDepositFee != true) {
      Receipt? receiptDeposiy = Receipt(
        residentId: residentId,
        phone: resident?.phone_required,
        discount_money: data.deposit_fee,
        refSchema: "ConstructionRegistration",
        type: "DepositFee",
        payment_status: "UNPAID",
        amount_due: data.deposit_fee,
        apartmentId: apartment.apartmentId,
        check: true,
        reason: "Thanh toán phí đặt cọc thi công",
        content: "Thanh toán phí đặt cọc thi công",
        customer_type: "RESIDENT",
        full_name: resident?.info_name,
        receipts_status: "NEW",
        expiration_date: DateTime.parse(data.time_end!)
            .add(Duration(days: fixedDateService!.cut_service_date ?? 0))
            .subtract(const Duration(hours: 7))
            .toIso8601String(),
        date:
            DateTime.now().subtract(const Duration(hours: 7)).toIso8601String(),
      );
      listReceipt.add(receiptDeposiy.toJson());
    }
    ConstructionHistory conHis = ConstructionHistory(
      constructionregistrationId: data.id,
      date: DateTime.now().subtract(const Duration(hours: 7)).toIso8601String(),
      residentId: context.read<ResidentInfoPrv>().residentId,
      person: context.read<ResidentInfoPrv>().userInfo!.info_name,
      status: status,
    );
    Utils.showConfirmMessage(
        context: context,
        title: S.of(context).send_request,
        content: S.of(context).confirm_send_request(data.code ?? ""),
        onConfirm: () {
          Navigator.pop(context);
          // APIConstruction.saveConstructionRegistration(data.toJson())
          return APIConstruction.changeStatus(
                  data.toJson(), listReceipt, conHis.toJson())
              .then((v) {
            // ConstructionHistory conHis = ConstructionHistory(
            //   constructionregistrationId: data.id,
            //   date: DateTime.now()
            //       .subtract(const Duration(hours: 7))
            //       .toIso8601String(),
            //   residentId: context.read<ResidentInfoPrv>().residentId,
            //   person: context.read<ResidentInfoPrv>().userInfo!.info_name,
            //   status: status,
            // );
            // return APIConstruction.saveConstructionHistory();
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
    ConstructionHistory conHis = ConstructionHistory(
      constructionregistrationId: data.id,
      date: DateTime.now().subtract(const Duration(hours: 7)).toIso8601String(),
      residentId: context.read<ResidentInfoPrv>().residentId,
      person: context.read<ResidentInfoPrv>().userInfo!.info_name,
      status: "CANCEL",
    );
    Utils.showConfirmMessage(
        context: context,
        title: S.of(context).cancel_request,
        content: S.of(context).confirm_cancel_request(data.code ?? ""),
        onConfirm: () {
          Navigator.pop(context);
          // APIConstruction.saveConstructionRegistration(data.toJson())
          APIConstruction.changeStatus(data.toJson(), null, conHis.toJson())
              .then((v) {
            // return APIConstruction.saveConstructionHistory(conHis.toJson());
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
      context.read<ResidentInfoPrv>().selectedApartment?.apartmentId ?? "",
    ).then((v) {
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
      context.read<ResidentInfoPrv>().selectedApartment!.apartmentId ?? "",
    ).then((v) {
      listRegistration.clear();
      for (var i in v) {
        listRegistration.add(ConstructionRegistration.fromJson(i));
      }
      // notifyListeners();
      getFixedDate();
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }

  getContructionRegistrationLetterListWait(BuildContext context) async {
    await APIConstruction.getConstructionRegistrationListWait(
      context.read<ResidentInfoPrv>().residentId ?? "",
    ).then((v) {
      listWaitRegistration.clear();
      for (var i in v) {
        listWaitRegistration.add(ConstructionRegistration.fromJson(i));
      }
      getFixedDate();
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }

  refuseLetter(BuildContext context, ConstructionRegistration data) async {
    var submitData = data.copyWith();
    Utils.showDialog(
      context: context,
      dialog: PrimaryDialog.custom(
        content: Column(
          children: [
            PrimaryTextField(
              label: S.of(context).reason_refuse,
              enable: false,
              initialValue: "Chủ hộ từ chôi",
            )
          ],
        ),
      ),
    );
  }

  acceptLetter(BuildContext context) async {}
}
