import 'package:app_cudan/constants/constants.dart';
import 'package:app_cudan/models/receipt.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/services/api_payment.dart';
import 'package:app_cudan/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../widgets/primary_card.dart';
import '../payment_list_screen.dart';

class PaymentPrv extends ChangeNotifier {
  PaymentPrv(
      {required this.listReceipts,
      required this.ctx,
      required this.year,
      required this.month}) {
    sum = listReceipts.fold(0.0, (a, b) {
      var own = b.transactions.fold(
          0.0,
          (previousValue, element) =>
              previousValue + (element.payment_amount ?? 0));
      var money = b.discount_money! - own;
      return (a + money);
    });
  }
  int year;
  int month;
  List<Receipt> listReceipts = [];
  var link = "assets/icons/vnpay.svg";
  var link1 = "assets/icons/paypal.svg";
  var value = 0;
  var isConfirm = false;
  late double sum;
  var isSendLoading = false;
  BuildContext ctx;

  changeValue(v) {
    value = v;
    notifyListeners();
  }

  changeConfirm() {
    isConfirm = true;
    notifyListeners();
  }

  onSaveReceits(BuildContext context) {
    Navigator.pop(context);
    isSendLoading = true;
    notifyListeners();
    var dataReceipts = listReceipts.map((e) {
      e.payer = context.read<ResidentInfoPrv>().userInfo!.info_name ?? "";
      e.payer_phone = context.read<ResidentInfoPrv>().userInfo!.phone;
      e.payment_status = 'PAID';
      e.residentId = context.read<ResidentInfoPrv>().residentId;

      return e.toJson();
    }).toList();

    // APIPayment.saveManyPayment(dataReceipts)
    APIPayment.makePayment(dataReceipts[0]).then((v) {
      var dataHistoryTransaction = listReceipts.map(
        (e) {
          var now = DateTime.now();
          var date = DateTime(now.year, now.month, now.day, 17);
          var time = '${now.hour}:${now.minute}';
          var paid =
              e.transactions.fold(0.0, (a, b) => a += (b.payment_amount ?? 0));
          var newTransaction = TransactionHistory(
            isMobile: true,
            receiptsId: e.id,
            amount_money: e.amount_due,
            amount_owed: 0,
            // employeeId: e.employeeId,
            payment_amount: e.discount_money! - paid,
            date: date.toIso8601String(),
            time: time,
          );
          return newTransaction.toJson();
        },
      ).toList();
      return APIPayment.saveHistoryTransaction(dataHistoryTransaction);
    }).then((v) {
      isSendLoading = false;

      notifyListeners();
      String me =
          "${listReceipts[0].reason.toString()} ${listReceipts[0].code.toString()}";
      Utils.showSuccessMessage(
          context: ctx,
          e: S.of(ctx).success_payment(me),
          onClose: () {
            Navigator.pushNamedAndRemoveUntil(
                ctx, PaymentListScreen.routeName, (route) => route.isFirst,
                arguments: {"index": 1, "year": year, "month": month});
          });
    }).catchError((e) {
      isSendLoading = false;
      notifyListeners();
      Utils.showErrorMessage(ctx, e);
    });
  }

  onEnterPin(BuildContext context) {
    TextEditingController pinCodeController = TextEditingController();
    // FocusNode focusPin = FocusNode();
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          // focusPin.requestFocus();
          return SingleChildScrollView(
            child: PrimaryCard(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 12),
                      child: Text(
                        S.of(context).enter_payment_pass,
                        style: txtBold(16),
                      ),
                    ),
                    const Divider(
                      color: grayScaleColor4,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 70, right: 70, top: 80, bottom: 25),
                      child: PinCodeTextField(
                        cursorHeight: 0,
                        obscuringWidget: ClipOval(
                            child: Container(
                          color: primaryColorBase,
                        )),
                        backgroundColor: Colors.white,
                        obscuringCharacter: "●",
                        // autoUnfocus: true,
                        autoFocus: true,
                        autoDisposeControllers: false,
                        autoDismissKeyboard: false,
                        keyboardType: TextInputType.number,
                        // focusNode: focusPin,
                        appContext: context,
                        length: 6,
                        obscureText: false,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          borderWidth: 0,
                          inactiveColor: grayScaleColor4,
                          inactiveFillColor: grayScaleColor4,
                          selectedColor: yellowColor,
                          selectedFillColor: yellowColor,
                          activeColor: Colors.white,
                          shape: PinCodeFieldShape.circle,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 20,
                          fieldWidth: 20,
                          activeFillColor: Colors.white,
                        ),
                        animationDuration: const Duration(milliseconds: 300),
                        // backgroundColor: grayScaleColorBase,
                        enableActiveFill: true,
                        controller: pinCodeController,
                        onCompleted: (v) {
                          onSaveReceits(context);
                        },
                        onChanged: (value) {},
                        // beforeTextPaste: (text) {
                        //   print("Allowing to paste $text");
                        //   //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //   //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        //   return true;
                        // },
                      ),
                    ),
                    InkWell(
                        child: Text(
                      S.of(context).forgot_pass.replaceAll('?', ''),
                      style: txtRegular(14, primaryColorBase),
                    )),
                    vpad(30),
                  ],
                )),
          );
        }).then((v) {
      // focusPin.unfocus();
      isConfirm = false;
      notifyListeners();
    });
  }
}
