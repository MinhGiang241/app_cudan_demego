import 'dart:convert';

import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/screens/chat/new_chat/bloc/new_chat_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../main.dart';
import '../../../models/ho_model.dart';
import '../../../models/response_resident_own.dart';
import '../../../models/user_account_HO.dart';
import '../../../services/api_ho_account.dart';
import '../../../services/api_ho_service.dart';
import '../../../services/api_service.dart';
import '../../../services/api_tower.dart';
import '../../../services/prf_data.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_dialog.dart';
import '../../auth/apartment_selection_screen.dart';
import '../../auth/prv/auth_prv.dart';
import '../../auth/sign_in_screen.dart';
import '../../home/home_screen.dart';
import '../select_project_screen.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class HOAccountServicePrv extends ChangeNotifier {
  HOAccountServicePrv();
  AuthStatus authStatus = AuthStatus.unauthen;
  String? access_token;
  DateTime? expireDate;
  List<Project> projectList = [];
  List<RegistrationProjectList> registrationProjectList = [];
  List<ResidentResitration> registrationList = [];
  var isLoginLoading = false;
  var isSelectProjectLoading = false;
  var isSignupLoading = false;
  var isAutoLoginLoading = true;

  onSetAutoLoginLoading(bool value) {
    isAutoLoginLoading = value;
    notifyListeners();
  }

  navigateToHomeScreen(BuildContext context, ResponseResidentOwn e) async {
    context.read<AuthPrv>().authStatus = AuthStatus.auth;
    context.read<ResidentInfoPrv>().selectedApartment = e;
    await PrfData.shared.setApartments(json.encode(e.toJson()));

    Navigator.of(context).pushNamedAndRemoveUntil(
      HomeScreen.routeName,
      (route) => route.isCurrent,
    );
  }

  navigateToProject(
    BuildContext context,
    RegistrationProjectList e,
  ) async {
    try {
      isSelectProjectLoading = true;
      notifyListeners();
      await ApiService.shared.setAPI(
        e.deployment?.apiEndpoint ?? "",
        ApiHOService.shared.access_token,
        ApiHOService.shared.expireDate,
        e.project?.registration?.code,
        e.project?.project_name,
      );

      await PrfData.shared.setProjectInStore(e);
      var a = await APITower.mobileMe();

      print(a);
      if (a != null) {
        var userHO = UserAccountHO.fromMap(a);
        ApiService.shared.setToken(a["token"]);
        await firebase.push_device(userHO.user?.userName ?? "");
        await context.read<ResidentInfoPrv>().setUserInfoFromHO(userHO);
      }

      await context.read<ResidentInfoPrv>().setListOwn(context);
      // ignore: unused_local_variable
      var residentId = context.read<ResidentInfoPrv>().residentId;
      if (context.read<ResidentInfoPrv>().listOwn.isEmpty) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          HomeScreen.routeName,
          (route) => route.isCurrent,
        );
      } else {
        Navigator.of(context).pushNamed(
          ApartmentSeletionScreen.routeName,
          arguments: {
            "project": e.project?.project_name,
            "not-auto": true,
          },
        );
      }
      isSelectProjectLoading = false;
      notifyListeners();
    } catch (e) {
      isSelectProjectLoading = false;
      notifyListeners();
      Utils.showErrorMessage(context, e.toString());
    }

    // await AuthPrv()
    //     .onSignIn(context, '0969881567', '1234');

    // Navigator.of(context).pushNamed(
    //   ApartmentSeletionScreen.routeName,
    //   arguments: e.project_name,
    // );
  }

  Future logOutHO(BuildContext context) async {
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
                      ApiService.shared.clearToken();
                      Utils.pop(context, true);
                      // PrfData.shared.deleteApartment();
                      authStatus = AuthStatus.unauthen;
                      access_token = null;
                      expireDate = null;
                      context.read<ResidentInfoPrv>().clearData();
                      await PrfData.shared.setAuthState(logOut);
                      await PrfData.shared.deleteApartment();
                      await PrfData.shared.deleteProject();
                      context.read<NewChatBloc>().add(NewChatInitEvent());
                      context.read<NewChatBloc>().state.messages = [
                        types.TextMessage(
                          author: types.User(
                            lastName: S.current.auto_message,
                            imageUrl: AppImage.avatarUrl,
                            id: '1111',
                          ),
                          createdAt: DateTime.now().millisecondsSinceEpoch,
                          id: const Uuid().v4(),
                          text: S.current.chat_greeting,
                        ),
                      ];
                      notifyListeners();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        SignInScreen.routeName,
                        ((route) => route.isCurrent),
                      );
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future createAccount(
    String phone,
    String password,
    String email,
    String fullName,
    BuildContext context,
  ) async {
    isSignupLoading = true;
    notifyListeners();

    await APIHOAccount.createAccount(phone, password, email, fullName)
        .then((v) {
      isSignupLoading = false;
      notifyListeners();
      Utils.showSuccessMessage(
        context: context,
        e: S.of(context).success_sign_up,
        onClose: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            SignInScreen.routeName,
            ((route) => route.isCurrent),
          );
        },
      );
    }).catchError((e) {
      isSignupLoading = false;
      notifyListeners();
      Utils.showErrorMessage(context, e);
    });
  }

  Future loginHO(
    String userName,
    String password,
    BuildContext context,
    bool remember,
  ) async {
    isLoginLoading = true;
    notifyListeners();
    await APIHOAccount.loginHO(userName, password).then((v) async {
      if (remember) {
        await PrfData.shared.setSignInStore(
          userName,
          password,
        );
        await PrfData.shared.setAuthState(logIn);
      } else {
        await PrfData.shared.deteleSignInStore();
      }
      isLoginLoading = false;
      notifyListeners();

      Navigator.pushNamed(
        context,
        SelectProjectScreen.routeName,
        arguments: {
          "not-auto": true,
        },
      );
    }).catchError((e) {
      isLoginLoading = false;
      notifyListeners();
      if ((e as DioError).response?.statusCode == 401) {
        Utils.showErrorMessage(context, S.of(context).incorrect_usn_pass);
      } else {
        Utils.showErrorMessage(context, e.error.toString());
      }
    });
  }

  Future getProjectList(BuildContext context) async {
    await APIHOAccount.getProjectListApi().then((v) {
      if (v != null) {
        registrationProjectList.clear();
        for (var i in v) {
          var pj = RegistrationProjectList.fromMap(i);

          registrationProjectList.add(pj);
        }
      }
      notifyListeners();
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });

    return;
  }

  Future getRegisterList(BuildContext context) async {
    await APIHOAccount.getProjectListNotApprovedRegistrationApi().then((v) {
      if (v != null) {
        registrationList.clear();
        for (var i in v) {
          var resReg = ResidentResitration.fromMap(i);

          registrationList.add(resReg);
        }
      }
      print(projectList);
      notifyListeners();
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });

    return;
  }
}
