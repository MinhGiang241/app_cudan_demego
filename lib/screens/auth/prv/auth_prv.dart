import 'dart:async';

import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/response_apartment.dart';
import '../../../models/response_user.dart';
import '../../../services/api_auth.dart';
import '../../../services/api_service.dart';
import '../../../services/api_tower.dart';
import '../../../services/prf_data.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_dialog.dart';
import '../apartment_selection_screen.dart';
import '../sign_in_screen.dart';
import '../verify_otp_screen.dart';

enum AuthStatus { unknown, auth, unauthen }

class AuthPrv extends ChangeNotifier {
  AuthStatus authStatus = AuthStatus.unknown;

  ResponseUser? userInfo;

  ResponseApartment? apartments;

  FloorPlan? selectedApartment;

  bool isLoading = false;

  Future<void> start() async {
    await ApiService.shared.getExistClient().then((cre) async {
      if (cre != null) {
        if (cre.credentials.isExpired) {
          authStatus = AuthStatus.unauthen;
          await ApiService.shared.refresh(cre);
        }
        authStatus = AuthStatus.auth;

        // apartments = PrfData.shared.getApartments();

        // selectedApartment = PrfData.shared.getFLoorPlan();

        // await getUserInfo();
      } else {
        authStatus = AuthStatus.unauthen;
      }
      notifyListeners();
    });
  }

  Future<void> getUserInfo() async {
    await APIAuth.getUserInfo().then((value) {
      if (value.status == null) {
        userInfo = value;
        notifyListeners();
      }
    });
  }

  Future<void> onSignIn(
      BuildContext context, String account, String pass) async {
    isLoading = true;
    notifyListeners();

    await APIAuth.signIn(
        username: account,
        password: pass,
        onError: () {
          Utils.showDialog(
              context: context,
              dialog: PrimaryDialog.error(
                msg:
                    '${S.of(context).incorrect_usn_pass} ${S.of(context).retry}',
              ));
        }).then((value) async {
      if (value != null) {
        Navigator.of(context).pushNamed(ApartmentSeletionScreen.routeName);
        // await APITower.getApartments().then((r) {
        //   if (r.status == null) {
        //     apartments = r;
        //     isLoading = false;
        //     notifyListeners();
        //     Utils.pushScreen(context, ApartmentSeletionScreen(listProject: r));
        //   } else {
        //     Utils.showDialog(
        //         context: context,
        //         dialog: PrimaryDialog.error(
        //           msg: S.of(context).err_x(r.message ?? " "),
        //         ));
        //   }
        // });

        // await getUserInfo();
      }
    });
  }

  Future<void> onCreateAccount(BuildContext context, String user, String name,
      String email, String pass, String cPass) async {
    await APIAuth.createResidentAccount(
            user: user,
            name: name,
            email: email,
            passWord: pass,
            confirmPassword: cPass)
        .then((value) {
      if (value.code == 0) {
        Utils.showDialog(
            context: context,
            dialog: PrimaryDialog.success(
              msg: S.of(context).rgstr_code_0,
              onClose: () {
                Navigator.pushNamed(context, SignInScreen.routeName);
              },
            ));
      } else {
        Utils.showDialog(
            context: context,
            dialog: PrimaryDialog.error(
              msg: value.message,
            ));
      }
    }).catchError((e) {
      Utils.showDialog(
          context: context,
          dialog: PrimaryDialog.error(msg: S.of(context).err_internet));
    });
  }

  Future<void> onVerify(
    BuildContext context,
    String phone,
    String otp,
  ) async {
    await APIAuth.verifyOTP(phoneNum: phone, otp: otp).then((value) {
      // if (value.status == null) {
      //   if (value.code == 0) {
      //     Utils.showDialog(
      //         context: context,
      //         dialog: PrimaryDialog.success(
      //           msg: "S.of(context).rgstr_code_0",
      //         )).then((value) {
      //       Utils.pushAndRemoveUntil(
      //           context, const SignInScreen(), (route) => route.isFirst);
      //     });
      //   } else {
      //     Utils.showDialog(
      //         context: context,
      //         dialog: PrimaryDialog.errorCode(
      //           code: value.code,
      //         ));
      //   }
      // } else {
      //   if (value.status == "internet_error") {
      //     Utils.showDialog(
      //         context: context,
      //         dialog: PrimaryDialog.error(
      //           msg: " S.of(context).network_error",
      //         ));
      //   } else {
      //     Utils.showDialog(
      //         context: context,
      //         dialog: PrimaryDialog.error(
      //           msg: "S.of(context).err_x(value.message ?? " ")",
      //         ));
      //   }
      // }
    });
  }

  Future<void> onSelectApartment(
      BuildContext context, FloorPlan floorPlan) async {
    selectedApartment = floorPlan;
    authStatus = AuthStatus.auth;
    notifyListeners();
    await PrfData.shared.setApartments(apartments!);
    await PrfData.shared.setFloorPlan(floorPlan).then((value) {
      Navigator.popUntil(context, (route) => route.isFirst);
    });
  }

  Future<void> onChangeApartment(
      BuildContext context, FloorPlan floorPlan) async {
    selectedApartment = floorPlan;
    notifyListeners();
    await PrfData.shared.setFloorPlan(floorPlan).then((value) {
      Utils.pop(context);
    });
  }

  Future<void> onChangePassEvent() async {}

  Future<void> onResetPassEvent() async {}

  Future<void> onSignOut(BuildContext context) async {
    Utils.showDialog(
        context: context,
        dialog: PrimaryDialog.custom(
          title: S.of(context).sign_out,
          content: Column(
            children: [
              Text(S.of(context).sign_out_msg),
              vpad(16),
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      text: S.of(context).sign_out,
                      buttonSize: ButtonSize.medium,
                      isFit: true,
                      buttonType: ButtonType.secondary,
                      secondaryBackgroundColor: redColor2,
                      onTap: () {
                        Utils.pop(context, true);
                        Navigator.of(context).pushNamed(SignInScreen.routeName);
                      },
                    ),
                  ),
                  hpad(24),
                  Expanded(
                    child: PrimaryButton(
                      text: S.of(context).cancel,
                      buttonSize: ButtonSize.medium,
                      buttonType: ButtonType.secondary,
                      secondaryBackgroundColor: primaryColor4,
                      textColor: primaryColorBase,
                      onTap: () {
                        Utils.pop(context);
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        )).then((value) async {
      if (value != null) {
        if ((value as bool)) {
          userInfo = null;
          selectedApartment = null;
          await APIAuth.signOut().then((value) async {
            authStatus = AuthStatus.unauthen;
            await PrfData.shared.deleteApartment();
            notifyListeners();
          });
        }
      }
    });
  }
}
