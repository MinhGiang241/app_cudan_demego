import 'dart:convert';

import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../generated/l10n.dart';
import '../main.dart';
import '../models/ho_model.dart';
import '../models/response_resident_own.dart';
import '../models/user_account_HO.dart';
import '../screens/auth/apartment_selection_screen.dart';
import '../screens/auth/prv/auth_prv.dart';
import '../screens/auth/prv/sign_in_prv.dart';
import '../screens/ho/prv/ho_account_service_prv.dart';
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
    var a, p;
    var acc = await PrfData.shared.getSignInStore();
    if (acc != null && acc['acc'] != null && acc['pass'] != null) {
      a = acc['acc'];
      p = acc['pass'];
      await APIHOAccount.loginHO(a, p).then((v) async {
        Navigator.pushNamed(context, SelectProjectScreen.routeName);
      }).catchError((e) {
        if ((e as DioError).response?.statusCode == 401) {
          Utils.showErrorMessage(context, S.of(context).incorrect_usn_pass);
        } else {
          Utils.showErrorMessage(context, e.error.toString());
        }
      });
    }
  }

  static Future autoSelectProject(BuildContext context) async {
    var a = await PrfData.shared.getProjectInstore();
    print("a: $a");
    if (a != null) {
      var project = RegistrationProjectList.fromJson(a);
      // var s = context.read<ResidentInfoPrv>().;
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
            arguments: project.project?.project_name,
          );
        }
      } catch (e) {
        Utils.showErrorMessage(context, e.toString());
      }

      // await context
      //     .read<HOAccountServicePrv>()
      //     .navigateToProject(context, project);
    }
  }

  static Future autoSelectApartment(BuildContext context) async {
    var a = await PrfData.shared.getApartments();
    if (a != null) {
      var selectedApartment = ResponseResidentOwn.fromJson(json.decode(a));
      context.read<AuthPrv>().authStatus = AuthStatus.auth;
      context.read<ResidentInfoPrv>().selectedApartment = selectedApartment;
      // await PrfData.shared
      //     .setApartments(json.encode(selectedApartment.toJson()));

      Navigator.of(context).pushNamedAndRemoveUntil(
        HomeScreen.routeName,
        (route) => route.isCurrent,
      );
    }
  }
}