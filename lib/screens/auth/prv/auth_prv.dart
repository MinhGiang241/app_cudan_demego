// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:app_cudan/screens/account/change_pass/change_pass_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/account.dart';
import '../../../models/response_apartment.dart';
import '../../../models/resident_info.dart';
import '../../../models/response_resident_own.dart';
import '../../../models/response_user.dart';
import '../../../services/api_auth.dart';
import '../../../services/api_service.dart';
import '../../../services/api_tower.dart';
import '../../../services/prf_data.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_dialog.dart';
import '../../home/home_screen.dart';
import '../apartment_selection_screen.dart';
import '../fogot_pass/reset_pass_screen.dart';
import '../project_selection_screen.dart';
import '../sign_in_screen.dart';
import '../verify_otp_screen.dart';
import 'resident_info_prv.dart';

enum AuthStatus { unknown, auth, unauthen, authRes }

class AuthPrv extends ChangeNotifier {
  AuthStatus authStatus = AuthStatus.unknown;

  Account? account;

  ResponseUser? userInfo;

  ResponseApartment? apartments;

  FloorPlan? selectedApartment;

  bool isLoading = false;

  bool remember = false;

  clearData() {
    account = null;
    apartments = null;
    selectedApartment = null;
    notifyListeners();
  }

  Future<void> start(BuildContext context) async {
    await ApiService.shared.getExistClient().then((cre) async {
      if (cre != null) {
        if (cre.credentials.isExpired) {
          authStatus = AuthStatus.unauthen;
          await ApiService.shared.refresh(cre, remember);
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

  Future<void> onSignIn(
      BuildContext context, String account, String pass) async {
    isLoading = true;
    notifyListeners();

    onError(String va) {
      Utils.showDialog(
          context: context,
          dialog: PrimaryDialog.error(
              // msg: '${S.of(context).incorrect_usn_pass} ${S.of(context).retry}',
              msg: va.contains("host")
                  ? S.of(context).err_conn
                  : '${S.of(context).incorrect_usn_pass} ${S.of(context).retry}'));
    }

    await APIAuth.signIn(
            context: context,
            username: account,
            password: pass,
            remember: remember,
            onError: onError)
        .then((value) async {
      if (value != null) {
        authStatus = AuthStatus.auth;

        if (remember) {
          await PrfData.shared.setSignInStore(account, pass);
        } else {
          await PrfData.shared.deteleSignInStore();
        }
        // await APIAuth.getAccountInfo().then((v) {
        //   context.watch<AuthPrv>().account = Account.fromJson(v);
        // }).catchError((e) {});
        await APITower.getResidentInfo(account).then((value) async {
          if (value != null) {
            context.read<ResidentInfoPrv>().userInfo =
                ResponseResidentInfo.fromJson(value);
            context.read<ResidentInfoPrv>().residentId =
                context.read<ResidentInfoPrv>().userInfo != null
                    ? context.read<ResidentInfoPrv>().userInfo!.id
                    : null;
            await APITower.getUserOwnInfo(
                    context.read<ResidentInfoPrv>().userInfo!.id as String)
                .then((v) async {
              context.read<ResidentInfoPrv>().listOwn.clear();
              v.forEach((i) {
                if (i['status'] == 'ACTIVE' &&
                    (i['type'] == 'BUY' || i['type'] == 'RENT')) {
                  context
                      .read<ResidentInfoPrv>()
                      .listOwn
                      .add(ResponseResidentOwn.fromJson(i));
                }
              });
              int? aprt = await PrfData.shared.getApartments();
              var lo = context.read<ResidentInfoPrv>().listOwn;
              if (lo.isNotEmpty) {
                context.read<AuthPrv>().authStatus = AuthStatus.authRes;
              }
              context.read<AuthPrv>().authStatus = AuthStatus.auth;
              notifyListeners();
              if (context.read<ResidentInfoPrv>().listOwn.isEmpty) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  HomeScreen.routeName,
                  (route) => route.isCurrent,
                );
              } else if (aprt != null) {
                print(aprt);
                context.read<ResidentInfoPrv>().selectApartmentFromHive(aprt);
                notifyListeners();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  HomeScreen.routeName,
                  (route) => route.isCurrent,
                );
              } else {
                Navigator.pushReplacementNamed(
                    context, ProjectSelectionScreen.routeName);
              }

              // Navigator.of(context)
              //     .pushNamed(ApartmentSeletionScreen.routeName, arguments: {
              //   "listOwn": listOwn,
              // });
            }).catchError((e) {
              Utils.showErrorMessage(context, e);
              context.read<AuthPrv>().authStatus = AuthStatus.unauthen;
              isLoading = false;
              notifyListeners();
            });
          } else {
            context.read<ResidentInfoPrv>().userInfo = null;
            context.read<ResidentInfoPrv>().residentId = null;
            context.read<ResidentInfoPrv>().listOwn.clear();
            context.read<ResidentInfoPrv>().selectedApartment = null;
            Navigator.of(context).pushNamed(
              HomeScreen.routeName,
              // arguments: {
              //   "listOwn": [],
              // },
            );
          }
        }).catchError((e) {
          Utils.showErrorMessage(context, e);
        });

        // Navigator.of(context).pushNamed(ApartmentSeletionScreen.routeName,arguments: {
        //   // "residentId":value.['resident_resident_find_phone_by_email']['data']
        // });

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
      } else {
        // throw(S.of(context).emai)
        // onError.call('');
        return;
      }
    })
        // .then((value) async {
        //   if (value != null) {
        //     context.read<ResidentInfoPrv>().setUserInfo(value);
        //     return await APITower.getUserOwnInfo(value['_id'] as String);
        //   } else {
        //     return null;
        //     // Navigator.of(context).pushNamed(
        //     //   HomeScreen.routeName,
        //     //   // arguments: {
        //     //   //   "listOwn": [],
        //     //   // },
        //     // );
        //   }
        // }).then((v) {
        //   // var l = context.read<ResidentInfoPrv>().listOwn;
        //   context.read<ResidentInfoPrv>().clearListOwn();

        //   if (v != null) {
        //     v.forEach((i) {
        //       if (i['status'] == 'ACTIVE' &&
        //           (i['type'] == 'BUY' || i['type'] == 'RENT')) {
        //         context.read<ResidentInfoPrv>().addListOwn(i);
        //       }
        //     });
        //     Navigator.pushNamedAndRemoveUntil(
        //         context, ProjectSelectionScreen.routeName, (r) => r.isActive);
        //   } else {
        //     // Navigator.of(context).pushNamed(
        //     //   HomeScreen.routeName,
        //     // );
        //   }

        //   // Navigator.of(context)
        //   //     .pushNamed(ApartmentSeletionScreen.routeName, arguments: {
        //   //   "listOwn": listOwn,
        //   // });
        // })

        .catchError((e) {
      // Utils.showErrorMessage(context, e);
      onError.call(e);
      isLoading = false;
      notifyListeners();
    });
  }

  Future<void> onCreateAccount(BuildContext context, String user, String name,
      String email, String pass, String cPass) async {
    await APIAuth.createResidentAccount(
            context: context,
            user: user,
            name: name,
            email: email,
            passWord: pass,
            confirmPassword: cPass)
        .then((value) {
      Utils.showSuccessMessage(
          context: context,
          e: S.of(context).success_sign_up,
          onClose: () {
            Navigator.pushReplacementNamed(context, SignInScreen.routeName);
          });
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }

  Future<void> onVerify(
      BuildContext context,
      String name,
      String mail,
      String phone,
      String otp,
      bool isFogotPass,
      bool isPhone,
      Function verify) async {
    if (isFogotPass) {
      await APIAuth.verifyOtp(otp, isPhone ? phone : mail).then((v) {
        Utils.pushScreen(
            context,
            ResetPassScreen(
              user: name,
              token: '',
            ));
      }).catchError((e) {
        Utils.showErrorMessage(context, e);
      });
    } else {
      // await APIAuth.verifyOtp(otp, isPhone ? phone : mail)
      await verify().then((v) {}).catchError((e) {
        Utils.showErrorMessage(context, e);
      });
    }
  }

  Future<void> onSelectApartment(
      BuildContext context, FloorPlan floorPlan) async {
    selectedApartment = floorPlan;
    authStatus = AuthStatus.auth;
    notifyListeners();

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
                      buttonSize: ButtonSize.small,
                      isFit: true,
                      buttonType: ButtonType.secondary,
                      secondaryBackgroundColor: redColor2,
                      onTap: () async {
                        Utils.pop(context, true);
                        await APIAuth.signOut(context: context);
                        authStatus = AuthStatus.unauthen;
                        context.read<ResidentInfoPrv>().clearData();

                        context.read<AuthPrv>().userInfo = null;
                        context.read<AuthPrv>().account = null;
                        context.read<AuthPrv>().apartments = null;
                        context.read<AuthPrv>().clearData();
                        notifyListeners();

                        Navigator.of(context).pushNamedAndRemoveUntil(
                            SignInScreen.routeName,
                            ((route) => route.isCurrent),
                            arguments: true);
                      },
                    ),
                  ),
                  hpad(24),
                  Expanded(
                    child: PrimaryButton(
                      isFit: true,
                      text: S.of(context).cancel,
                      buttonSize: ButtonSize.small,
                      buttonType: ButtonType.secondary,
                      secondaryBackgroundColor: primaryColor3,
                      textColor: Colors.white,
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
          await APIAuth.signOut(context: context).then((value) async {
            authStatus = AuthStatus.unauthen;
            await PrfData.shared.deleteApartment();
            notifyListeners();
          });
        }
      }
    });
  }
}
