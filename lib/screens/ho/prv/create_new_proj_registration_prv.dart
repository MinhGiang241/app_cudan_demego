import 'package:app_cudan/services/api_ho_account.dart';
import 'package:flutter/material.dart';
import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/ho_model.dart';
import '../../../utils/utils.dart';
import '../project_registration_screen.dart';

class CreateNewProjRegistrationPrv extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  var searchApartmentKey = UniqueKey();
  var relationKey = UniqueKey();

  CreateNewProjRegistrationPrv() {
    getProjectList();
  }
  bool autoValid = false;
  bool isLoading = false;
  String? validateProject;
  String? validateApartment;
  String? validateRelation;
  String? validateContractNum;

  String? valueProject;
  String? valueApartment;
  String? valueRelation;

  bool isSelectAprt = false;

  List<DropdownMenuItem<String>> relationshipList = [];
  List<DropdownMenuItem<String>> projectListChoice = [];
  List<Project> projectList = [];

  onSaveApartment(v) {
    print(v);
  }

  onChangeProject(
    v,
  ) async {
    if (v != null) {
      if (valueProject != v) {
        searchApartmentKey = UniqueKey();
        relationKey = UniqueKey();
        relationshipList.clear();
        valueRelation = null;
        onChangeApartment(null);
        notifyListeners();
        await futureApart();
      }
      valueProject = v.toString();
      validateProject = null;
      isSelectAprt = false;
    }
    getRelationShipList();
    notifyListeners();
  }

  onChangeRelation(v) {
    if (v != null) {
      valueRelation = v.toString();
      validateRelation = null;
    }
    notifyListeners();
  }

  futureApart() async {
    return Future.delayed(Duration(milliseconds: 10));
  }

  validate(BuildContext context) {
    if (formKey.currentState!.validate()) {
      clearValidateString();
    } else {
      genValidateString();
    }
    notifyListeners();
  }

  clearValidateString() {
    validateProject = null;
    validateRelation = null;
    validateContractNum = null;
    notifyListeners();
  }

  genValidateString() {
    if (valueProject == null) {
      validateProject = S.current.not_blank;
    } else {
      validateProject = null;
    }
    if (valueRelation == null) {
      validateRelation = S.current.not_blank;
    } else {
      validateRelation = null;
    }
    if (contractNumController.text.trim().isEmpty) {
      validateContractNum = S.current.not_blank;
    } else {
      validateContractNum = null;
    }
    notifyListeners();
  }

  TextEditingController contractNumController = TextEditingController();
  onChangeApartment(String? v) {
    valueApartment = v;
    notifyListeners();
  }

  Future<List<SearchableDropdownMenuItem<String>>?> paginatedRequest(
    int i,
    String? key,
  ) async {
    if (i == 2) return [];
    if (valueProject == null) return [];
    //"6495a54c093b143e81f6b660"
    try {
      var results = await APIHOAccount.getApartmentSuggestion(
        valueProject!,
        key ?? "",
      );
      print(results);

      return <SearchableDropdownMenuItem<String>>[
        ...(results ?? []).map(
          (e) => SearchableDropdownMenuItem(
            child: Text(
              '${e['label']}',
              style: txtBodySmallBold(
                color: grayScaleColorBase,
              ),
            ),
            value: '${e['value']}',
            label: '${e['label']}',
          ),
        )
      ];
    } catch (e) {
      return [];
    }
  }

  onSubmit(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      autoValid = true;
      isLoading = true;
      notifyListeners();
      clearValidateString();

      await APIHOAccount.submitResidentRegister(
        valueProject!,
        valueApartment!,
        valueRelation!,
        contractNumController.text.trim(),
      ).then((v) {
        isLoading = false;
        notifyListeners();
        Utils.showSuccessMessage(
          context: context,
          e: S.of(context).success_reg_res,
          onClose: () {
            Navigator.pushReplacementNamed(
              context,
              ProjectRegistrationScreen.routeName,
            );
          },
        );
      }).catchError((e) {
        isLoading = false;
        notifyListeners();
        Utils.showErrorMessage(context, e);
      });
    } else {
      genValidateString();
    }
  }

  getProjectList() async {
    await APIHOAccount.getProjectSuggestion().then((v) {
      if (v != null) {
        projectList.clear();
        projectListChoice.clear();
        for (var i in v) {
          var p = Project.fromMap(i);
          projectList.add(p);
          projectListChoice.add(
            DropdownMenuItem(
              value: p.registrationId,
              child: Text(p.project_name ?? ''),
            ),
          );
        }
      }
      notifyListeners();
    });
  }

  getRelationShipList() async {
    //"6495a54c093b143e81f6b660"
    if (valueProject == null) return;

    await APIHOAccount.getRelationshipList(valueProject!).then((v) {
      if (v != null) {
        relationshipList.clear();
        for (var i in v) {
          relationshipList.add(
            DropdownMenuItem(
              value: i['value'],
              child: Text(i['label'] ?? ''),
            ),
          );
        }
      }
    }).catchError((e) {
      relationshipList.clear();
    });

    notifyListeners();
  }
}
