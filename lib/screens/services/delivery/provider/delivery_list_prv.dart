import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/services/api_delivery.dart';
import 'package:app_cudan/widgets/primary_button.dart';
import 'package:app_cudan/widgets/primary_dialog.dart';
import 'package:app_cudan/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../models/delivery.dart';
import '../../../../utils/utils.dart';
import '../delivery_list_screen.dart';

class DeliveryListPrv extends ChangeNotifier {
  List<Delivery> listItems = [];
  List<Delivery> listWaitItems = [];
  TextEditingController reasonController = TextEditingController();

  refuseLetter(BuildContext context, Delivery data) {
    var copyData = data.copyWith();
    // Utils.showConfirmMessage(
    //   context: context,
    //   title: S.of(context).refuse_letter,
    //   content: S.of(context).confirm_refuse_letter(data.code ?? ""),
    //   onConfirm: () {
    reasonController.clear();
    // Navigator.pop(context);
    Utils.showDialog(
      context: context,
      dialog: PrimaryDialog.custom(
        // title: S.of(context).refuse_letter,
        content: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                S.of(context).refuse_letter,
                style: txtBold(14),
              ),
            ),
            vpad(12),
            PrimaryTextField(
              label: S.of(context).reason_refuse,
              enable: false,
              initialValue: S.of(context).owner_refuse,
            ),
            vpad(12),
            PrimaryTextField(
              controller: reasonController,
              maxLines: 3,
              label: S.of(context).note,
              hint: S.of(context).note,
            ),
            vpad(12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PrimaryButton(
                  width: 80,
                  text: S.of(context).cancel,
                  buttonType: ButtonType.red,
                  buttonSize: ButtonSize.small,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                PrimaryButton(
                  text: S.of(context).confirm,
                  buttonType: ButtonType.primary,
                  buttonSize: ButtonSize.small,
                  onTap: () async {
                    Navigator.pop(context);
                    copyData.status = "CANCEL";
                    copyData.reasons = 'CHUHOTUCHOI';
                    copyData.isMobile = true;
                    copyData.note_reason = reasonController.text;
                    APIDelivery.changeStatus(copyData.toJson()).then((v) {
                      Utils.showSuccessMessage(
                        context: context,
                        e: S.of(context).success_refuse_letter,
                        onClose: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            DeliveryListScreen.routeName,
                            (route) => route.isFirst,
                            arguments: 1,
                          );
                        },
                      );
                    }).catchError((e) {
                      Utils.showErrorMessage(context, e);
                    });
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
    //   },
    // );
  }

  acceptLetter(BuildContext context, Delivery data) {
    var copyData = data.copyWith();
    Utils.showConfirmMessage(
      context: context,
      title: S.of(context).confirm,
      content: S.of(context).confirm_accept_letter(data.code ?? ""),
      onConfirm: () {
        copyData.status = 'WAIT_MANAGER';
        APIDelivery.changeStatus(copyData.toJson()).then((v) {
          Navigator.pop(context);
          Utils.showSuccessMessage(
            context: context,
            e: S.of(context).success_accept_letter,
            onClose: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                DeliveryListScreen.routeName,
                (route) => route.isFirst,
                arguments: 1,
              );
            },
          );
        }).catchError((e) {
          Utils.showErrorMessage(context, e);
        });
      },
    );
  }

  cancelRequetsAprrove(BuildContext context, Delivery data) {
    var copyData = data.copyWith();
    Utils.showConfirmMessage(
      context: context,
      title: S.of(context).cancel_request,
      content: S.of(context).confirm_cancel_request(data.code ?? ""),
      onConfirm: () {
        copyData.status = 'CANCEL';
        copyData.reasons = 'NGUOIDUNGHUY';
        copyData.isMobile = true;
        // APIDelivery.saveNewDelivery(data.toJson())
        APIDelivery.changeStatus(copyData.toJson()).then((v) {
          Navigator.pop(context);
          Utils.showSuccessMessage(
            context: context,
            e: S.of(context).success_can_req,
            onClose: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                DeliveryListScreen.routeName,
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

  sendToApprove(BuildContext context, Delivery data) {
    var copyData = data.copyWith();
    copyData.isMobile = true;
    if (data.item_added_list == null || data.item_added_list!.isEmpty) {
      Utils.showErrorMessage(context, S.of(context).item_list_not_empty);
      return;
    } else {
      if (context.read<ResidentInfoPrv>().selectedApartment?.type == "BUY" ||
          context.read<ResidentInfoPrv>().selectedApartment?.type == "RENT") {
        copyData.status = 'WAIT_MANAGER';
      } else {
        copyData.status = 'WAIT_OWNER';
      }

      Utils.showConfirmMessage(
        title: S.of(context).send_request,
        content: S.of(context).confirm_send_request(data.code ?? ""),
        context: context,
        onConfirm: () {
          // APIDelivery.saveNewDelivery(data.toJson())
          APIDelivery.changeStatus(copyData.toJson()).then((v) {
            Navigator.pop(context);
            Utils.showSuccessMessage(
              context: context,
              e: S.of(context).success_send_req,
              onClose: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  DeliveryListScreen.routeName,
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

  getWaitConfirmLetter(BuildContext context) async {
    var residentId = context.read<ResidentInfoPrv>().residentId;
    var apartmentId =
        context.read<ResidentInfoPrv>().selectedApartment?.apartmentId;

    await APIDelivery.getWaitConfirmLetter(residentId, apartmentId).then((v) {
      if (v != null) {
        listWaitItems.clear();
        for (var i in v) {
          listWaitItems.add(Delivery.fromJson(i));
        }
      }
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }

  getDeliveryList(
    BuildContext context,
  ) async {
    var residentId = context.read<ResidentInfoPrv>().residentId;
    var apartmentId =
        context.read<ResidentInfoPrv>().selectedApartment?.apartmentId;
    await APIDelivery.getDeliveryListByResidentId(residentId, apartmentId).then(
      (value) {
        listItems.clear();
        if (value != null) {
          for (var i in value) {
            listItems.add(Delivery.fromJson(i));
          }
        }
      },
    ).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }

  deleteLetter(BuildContext context, Delivery e) {
    Utils.showConfirmMessage(
      title: S.of(context).delete_letter,
      content: S.of(context).confirm_delete_letter(e.code ?? ''),
      context: context,
      onConfirm: () async {
        await APIDelivery.deleteDelivery(e.id ?? '').then((v) {
          Navigator.pop(context);
          Utils.showSuccessMessage(
            context: context,
            e: S.of(context).success_remove,
            onClose: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                DeliveryListScreen.routeName,
                ((route) => route.isFirst),
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
