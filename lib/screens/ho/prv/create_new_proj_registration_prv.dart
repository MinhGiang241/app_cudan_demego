import 'package:app_cudan/services/api_ho_account.dart';
import 'package:flutter/material.dart';
import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';

class CreateNewProjRegistrationPrv extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  bool autoValid = false;
  String? validateProject;
  String? validateApartment;
  String? validateRelation;
  String? validateContractNum;

  String? valueProject;
  String? valueApartment;
  String? valueRelation;

  onChangeProject(v) {
    if (v != null) {
      valueProject = v.toString();
      validateProject = null;
    }

    notifyListeners();
  }

  onChangeRelation(v) {
    if (v != null) {
      valueRelation = v.toString();
      validateRelation = null;
    }
    notifyListeners();
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
  }

  Future<List<SearchableDropdownMenuItem<String>>?> paginatedRequest(
    int i,
    String? key,
  ) async {
    if (i == 2) return null;
    var results = await APIHOAccount.getApartmentSuggestion(
      "6495a54c093b143e81f6b660",
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
  }

  onSubmit() {
    if (formKey.currentState!.validate()) {
      autoValid = true;
      notifyListeners();
      clearValidateString();
    } else {
      genValidateString();
    }
  }
}
