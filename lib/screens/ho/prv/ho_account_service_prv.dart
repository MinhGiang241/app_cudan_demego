import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

import '../../../constants/api_account_constant.dart';
import '../../../generated/l10n.dart';
import '../../../models/account.dart';
import '../../../models/ho_model.dart';
import '../../../models/response.dart';
import '../../../services/api_auth.dart';
import '../../../services/api_ho_account.dart';
import '../../../services/prf_data.dart';
import '../../../utils/error_handler.dart';
import '../../../utils/utils.dart';
import '../../auth/project_selection_screen.dart';
import '../select_project_screen.dart';

class HOAccountServicePrv extends ChangeNotifier {
  HOAccountServicePrv(this.context);
  BuildContext context;
  // String? access_token;
  // DateTime? expireDate;
  List<Project> projectList = [];
  List<ResidentResitration> registrationList = [];
  var isLoginLoading = false;

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
