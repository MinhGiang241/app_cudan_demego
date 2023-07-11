import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/ho_model.dart';
import '../../../services/api_ho_account.dart';
import '../../../services/api_ho_service.dart';
import '../../../services/api_service.dart';
import '../../../services/api_tower.dart';
import '../../../services/prf_data.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_dialog.dart';
import '../../auth/prv/auth_prv.dart';
import '../../auth/sign_in_screen.dart';
import '../select_project_screen.dart';

class HOAccountServicePrv extends ChangeNotifier {
  HOAccountServicePrv();
  AuthStatus authStatus = AuthStatus.unauthen;
  String? access_token;
  DateTime? expireDate;
  List<Project> projectList = [];
  List<ResidentResitration> registrationList = [];
  var isLoginLoading = false;
  var isSignupLoading = false;

  navigateToProject(BuildContext context, Project e) async {
    try {
      await ApiService.shared.setAPI(
        e.domain ?? "",
        ApiHOService.shared.access_token,
        ApiHOService.shared.expireDate,
      );
      var a = await APITower.mobileMe();
      print(a);
    } catch (e) {
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
                      Utils.pop(context, true);
                      PrfData.shared.deleteApartment();
                      authStatus = AuthStatus.unauthen;
                      access_token = null;
                      expireDate = null;
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
                )
              ],
            )
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
      } else {
        await PrfData.shared.deteleSignInStore();
      }
      isLoginLoading = false;
      notifyListeners();
      Navigator.pushNamed(context, SelectProjectScreen.routeName);
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
        projectList.clear();
        for (var i in v) {
          var pj = Project.fromMap(i);

          projectList.add(pj);
        }
      }
      print(projectList);
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