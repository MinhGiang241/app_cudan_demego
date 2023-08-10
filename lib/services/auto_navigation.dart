import 'dart:convert';

import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/screens/ho/prv/ho_account_service_prv.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../generated/l10n.dart';
import '../main.dart';
import '../models/ho_model.dart';
import '../models/response_resident_own.dart';
import '../models/user_account_HO.dart';
import '../screens/auth/apartment_selection_screen.dart';
import '../screens/auth/prv/auth_prv.dart';
import '../screens/ho/select_project_screen.dart';
import '../screens/home/home_screen.dart';
import '../utils/utils.dart';
import 'api_ho_account.dart';
import 'api_ho_service.dart';
import 'api_service.dart';
import 'api_tower.dart';
import 'prf_data.dart';

class AutoNavigation {
  static Future autoLogin(BuildContext context) async {
    final arg = ModalRoute.of(context)!.settings.arguments as Map?;
    bool notAuto = arg?['not-auto'] ?? false;
    if (notAuto) {
      context.read<HOAccountServicePrv>().onSetAutoLoginLoading(false);

      return;
    }
    var a, p;
    var authState = await PrfData.shared.getAuthState();
    if (authState != logIn) {
      context.read<HOAccountServicePrv>().onSetAutoLoginLoading(false);
      return;
    }
    var acc = await PrfData.shared.getSignInStore();
    if (acc != null && acc['acc'] != null && acc['pass'] != null) {
      a = acc['acc'];
      p = acc['pass'];
      await APIHOAccount.loginHO(a, p).then((v) async {
        Navigator.pushNamed(
          context,
          SelectProjectScreen.routeName,
        );
        context.read<HOAccountServicePrv>().onSetAutoLoginLoading(false);
      }).catchError((e) {
        context.read<HOAccountServicePrv>().onSetAutoLoginLoading(false);
        if ((e as DioError).response?.statusCode == 401) {
          Utils.showErrorMessage(context, S.of(context).incorrect_usn_pass);
        } else {
          Utils.showErrorMessage(context, e.error.toString());
        }
      });
    } else {
      context.read<HOAccountServicePrv>().onSetAutoLoginLoading(false);
    }
  }

  static Future autoSelectProject(BuildContext context, setLogin) async {
    final arg = ModalRoute.of(context)!.settings.arguments as Map?;
    bool notAuto = arg?['not-auto'] ?? false;
    if (notAuto) {
      setLogin(false);
      return;
    }
    var a = await PrfData.shared.getProjectInstore();
    print("a: $a");
    if (a != null) {
      var project = RegistrationProjectList.fromJson(a);
      List<RegistrationProjectList> registrationProjectList = [];

      await APIHOAccount.getProjectListApi().then((v) {
        if (v != null) {
          registrationProjectList.clear();
          for (var i in v) {
            var pj = RegistrationProjectList.fromMap(i);

            registrationProjectList.add(pj);
          }
        }
      });
      var indexProject = registrationProjectList.indexWhere(
        (e) => e.project?.project_code == project.project?.project_code,
      );
      if (indexProject == -1) {
        setLogin(false);
        return;
      }
      try {
        await ApiService.shared.setAPI(
          project.deployment?.apiEndpoint ?? "",
          ApiHOService.shared.access_token,
          ApiHOService.shared.expireDate,
          project.project?.registration?.code,
        );

        await PrfData.shared.setProjectInStore(project);
        var me = await APITower.mobileMe();
        //
        print(me);
        if (me != null) {
          var userHO = UserAccountHO.fromMap(me);
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
            arguments: {"project": project.project?.project_name},
          );
        }
      } catch (e) {
        setLogin(false);
        Utils.showErrorMessage(context, e.toString());
      }

      // await context
      //     .read<HOAccountServicePrv>()
      //     .navigateToProject(context, project);
    } else {
      setLogin(false);
    }
  }

  static Future autoSelectApartment(BuildContext context, setLogin) async {
    final arg = ModalRoute.of(context)!.settings.arguments as Map?;
    bool notAuto = arg?['not-auto'] ?? false;
    if (notAuto) {
      setLogin(false);
      return;
    }
    try {
      var a = await PrfData.shared.getApartments();
      if (a != null) {
        var selectedApartment = ResponseResidentOwn.fromJson(json.decode(a));
        var listOwn = context.read<ResidentInfoPrv>().listOwn;
        var indexOwn = listOwn
            .indexWhere((e) => e.apartmentId == selectedApartment.apartmentId);
        if (indexOwn == -1) {
          setLogin(false);
          return;
        }
        context.read<AuthPrv>().authStatus = AuthStatus.auth;
        context.read<ResidentInfoPrv>().selectedApartment = selectedApartment;
        // await PrfData.shared
        //     .setApartments(json.encode(selectedApartment.toJson()));

        Navigator.of(context).pushNamedAndRemoveUntil(
          HomeScreen.routeName,
          (route) => route.isCurrent,
        );
      } else {
        setLogin(false);
      }
    } catch (e) {
      setLogin(false);
      Utils.showErrorMessage(context, e.toString());
    }
  }
}
