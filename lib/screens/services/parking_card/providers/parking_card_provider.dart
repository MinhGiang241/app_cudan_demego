import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../models/response_parking_card_model.dart';
import '../../../../services/api_tower.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/primary_button.dart';
import '../../../../widgets/primary_dialog.dart';
import '../../../services/gym_card/gym_card_list_screen.dart';

class ParkingCardProvider extends ChangeNotifier {
  ResponseParkingCardsList? parkingCardsList;

  bool isLoading = false;

  final String toaNhaId;

  ParkingCardProvider(this.toaNhaId) {
    _initial();
  }

  reportLostCard(BuildContext context) async {
    await Utils.showDialog(
        context: context,
        dialog: PrimaryDialog.custom(
          title: 'S.of(context).report_lost_card',
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              children: [
                Text('S.of(context).report_lost_card_msg',
                    style: txtBodySmallRegular(), textAlign: TextAlign.center),
                vpad(20),
                PrimaryButton(
                  onTap: () {},
                  width: double.infinity,
                  text: S.of(context).confirm,
                  buttonType: ButtonType.secondary,
                  textColor: primaryColorBase,
                  secondaryBackgroundColor: Colors.blue[50],
                ),
                vpad(20),
                PrimaryButton(
                  onTap: () {},
                  width: double.infinity,
                  text: 'S.of(context).confirm_register',
                  buttonType: ButtonType.primary,
                  secondaryBackgroundColor: primaryColor5,
                ),
                vpad(20),
                PrimaryButton(
                  onTap: () {},
                  width: double.infinity,
                  text: S.of(context).cancel,
                  buttonType: ButtonType.secondary,
                  textColor: redColorBase,
                  secondaryBackgroundColor: redColor5,
                ),
              ],
            ),
          ),
        ));
  }

  deactiveCard(BuildContext context) {
    Utils.showDialog(
        context: context,
        dialog: PrimaryDialog.custom(
          title: 'S.of(context).deactive_card',
          content: Column(
            children: [
              Text('S.of(context).reason_deactive',
                  style: txtBodySmallRegular(), textAlign: TextAlign.center),
              vpad(10),
              PrimaryRadio(
                isSelected: true,
                title: "Tôi đã bán phương tiện",
                onTap: () {},
              ),
              PrimaryRadio(
                isSelected: false,
                title: "Tôi chuyển nhà",
                onTap: () {},
              ),
              PrimaryRadio(
                isSelected: false,
                title: "Khác",
                onTap: () {},
              ),
              // TextField()
              vpad(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: PrimaryButton(
                      text: S.of(context).cancel,
                      buttonType: ButtonType.secondary,
                      secondaryBackgroundColor: redColor5,
                      textColor: redColorBase,
                      onTap: () {
                        Utils.pop(context);
                      },
                    ),
                  ),
                  hpad(32),
                  Expanded(
                    child: PrimaryButton(
                      text: S.of(context).confirm,
                      buttonType: ButtonType.primary,
                      secondaryBackgroundColor: redColor5,
                      isFit: true,
                      onTap: () {},
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }

  Future _initial() async {
    await APITower.getParkingCardsList().then((value) async {
      parkingCardsList = value;
      notifyListeners();
    });
  }

  Future retry() async {
    parkingCardsList = null;
    notifyListeners();
    _initial();
  }
}
