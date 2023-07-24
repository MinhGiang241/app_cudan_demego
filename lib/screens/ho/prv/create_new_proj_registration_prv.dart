import 'package:app_cudan/services/api_ho_account.dart';
import 'package:flutter/material.dart';
import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/ho_model.dart';
import '../../../models/response_resident_own.dart';
import '../../../services/Api_project_service.dart';
import '../../../services/api_ho_service.dart';
import '../../../utils/utils.dart';
import '../project_registration_screen.dart';

class CreateNewProjRegistrationPrv extends ChangeNotifier {
  ApiProjectService? projectApi;

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
  String? validateType;
  String? validateContractNum;

  String? valueProject;
  String? valueApartment;
  String? valueRelation;
  String? valueType;

  bool isSelectAprt = false;

  List<OwnInfofromHO> listOwnHO = [];
  List<DropdownMenuItem<String>> relationshipList = [];
  List<DropdownMenuItem<String>> projectListChoice = [];
  List<Project> projectList = [];

  setNewApiProject(String apiEndPoint, String regcode) {
    projectApi = ApiProjectService(
      regcode: regcode,
      access_token: ApiHOService.shared.access_token ?? "",
      expireDate: ApiHOService.shared.expireDate,
      domain: "${apiEndPoint}/graphql",
    );
  }

  onSelectType(v) {
    searchApartmentKey = UniqueKey();
    relationKey = UniqueKey();
    relationshipList.clear();
    valueRelation = null;
    if (v != null) {
      valueType = v;
      validateType = null;
    }

    notifyListeners();
  }

  getProjectData(
    String apiEndPoint,
    String regcode,
    BuildContext context,
  ) async {
    setNewApiProject(apiEndPoint, regcode);
    await projectApi!.loadDataRegister().then((v) {
      if (v != null) {
        var info = ResidentInfoFromHO.fromMap(v);
        listOwnHO.clear();
        for (var i in info.owninfo ?? []) {
          listOwnHO.add(i);
        }
      }
    });
  }

  onSaveApartment(v) {
    print(v);
  }

  onChangeProject(v, context) async {
    print(projectList);
    if (v != null) {
      if (valueProject != v) {
        searchApartmentKey = UniqueKey();
        relationKey = UniqueKey();
        relationshipList.clear();
        valueRelation = null;

        var pro = projectList.firstWhere((e) => e.registrationId == v);
        notifyListeners();
        await getProjectData(pro.apiEndpoint!, pro.regcode ?? "", context);
      }
      valueProject = v.toString();
      validateProject = null;
      isSelectAprt = false;
    }
    //getRelationShipList();
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
    validateType = null;
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
    if (valueType == null) {
      validateType = S.current.not_blank;
    } else {
      validateType = null;
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
    if (v != null) {
      var selectedAprt = listOwnHO.firstWhere((e) => e.id == v);

      if (selectedAprt.relation == null) {
        relationshipList = [
          DropdownMenuItem(
            value: '',
            child: Text(S.current.owner),
          )
        ];
        valueRelation = '';
      } else {
        relationshipList = [
          DropdownMenuItem(
            value: selectedAprt.relation?.code,
            child: Text(selectedAprt.relation?.name ?? ""),
          )
        ];
        valueRelation = selectedAprt.relation?.code;
      }
    } else {
      relationKey = UniqueKey();
      relationshipList.clear();
      valueRelation = null;
    }

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
      // var results = await APIHOAccount.getApartmentSuggestion(
      //   valueProject!,
      //   key ?? "",
      // );
      // print(results);

      return <SearchableDropdownMenuItem<String>>[
        ...(listOwnHO).map(
          (e) => SearchableDropdownMenuItem(
            child: Text(
              '${e.apartment?.label}',
              style: txtBodySmallBold(
                color: grayScaleColorBase,
              ),
            ),
            value: '${e.id}',
            label: '${e.apartment?.label}',
          ),
        )
      ];
    } catch (e) {
      return [];
    }
  }

  onSubmit(BuildContext context) async {
    autoValid = true;
    isLoading = true;
    notifyListeners();
    if (formKey.currentState!.validate()) {
      clearValidateString();
      await projectApi!
          .registeResident(valueType!, valueApartment)
          // await APIHOAccount.submitResidentRegister(
          //   valueProject!,
          //   valueApartment!,
          //   valueRelation!,
          //   contractNumController.text.trim(),
          // )
          .then((v) {
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
      isLoading = false;
      notifyListeners();
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

    // await APIHOAccount.getRelationshipList(valueProject!).then((v) {
    //   if (v != null) {
    //     relationshipList.clear();
    //     for (var i in v) {
    //       relationshipList.add(
    //         DropdownMenuItem(
    //           value: i['value'],
    //           child: Text(i['label'] ?? ''),
    //         ),
    //       );
    //     }
    //   }
    // }).catchError((e) {
    //   relationshipList.clear();
    // });

    notifyListeners();
  }
}
