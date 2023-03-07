import 'dart:io';

import 'package:app_cudan/services/api_province.dart';
import 'package:app_cudan/services/api_reflection.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../../models/file_upload.dart';
import '../../../models/province.dart';
import '../../../models/relationship.dart';
import '../../../services/api_relation.dart';
import '../../../utils/utils.dart';

class AddNewResidentPrv extends ChangeNotifier {
  int activeStep = 0;
  bool isDisableRightCroll = true;
  bool autoValidStep1 = false;
  bool autoValidStep2 = false;
  List<RelationShip> relations = [];
  List<Province> provinces = [];
  List<Distric> districs = [];
  List<Ward> wards = [];
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final PageController controller = PageController();

  DateTime? birthDate;
  // final GlobalKey<FormFieldState> districtDropdownKey =
  //     GlobalKey<FormFieldState>();
  // final GlobalKey<FormFieldState> wardDropdownKey = GlobalKey<FormFieldState>();
  // final TextEditingController apartmentAddController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  // final TextEditingController relationController = TextEditingController();
  // final TextEditingController sexController = TextEditingController();
  final TextEditingController birthController = TextEditingController();
  final TextEditingController identityController = TextEditingController();
  final TextEditingController issuePlaceController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  // final TextEditingController resTypeController = TextEditingController();
  // final TextEditingController provController = TextEditingController();
  // final TextEditingController districtController = TextEditingController();
  // final TextEditingController wardController = TextEditingController();

  String? apartmentAddValue;
  String? relationValue;
  String? sexValue;
  String? resTypeValue;
  String? provinceValue;
  String? districtValue;
  String? wardValue;

  String? apartmentAddValidate;
  String? nameValidate;
  String? relationValidate;
  String? sexValidate;
  String? birthValidate;
  String? identityValidate;
  String? nationalityValidate;
  String? resTypeValidate;
  String? provValidate;
  String? districtValidate;
  String? wardValidate;

  List<FileUploadModel> existedResImages = [];
  List<FileUploadModel> existedIdentityImages = [];
  List<FileUploadModel> existedDoccuments = [];

  List<File> resImages = [];
  List<File> identityImages = [];
  List<File> documents = [];

  List<FileUploadModel> uploadedResImages = [];
  List<FileUploadModel> uploadedIdentityImages = [];
  List<FileUploadModel> uploadedDocuments = [];

  onSelectResImages(BuildContext context) async {
    await Utils.selectImage(context, false).then((value) {
      if (value != null) {
        final list = value.map<File>((e) => File(e.path)).toList();
        resImages.addAll(list);
        notifyListeners();
      }
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }

  onSelectIdentityImages(BuildContext context) async {
    await Utils.selectImage(context, false).then((value) {
      if (value != null) {
        final list = value.map<File>((e) => File(e.path)).toList();
        identityImages.addAll(list);
        notifyListeners();
      }
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }

  onSelectDocuments(BuildContext context) async {
    await Utils.selectFile(context, false).then((value) {
      if (value != null) {
        final list = value.map<File>((e) => File(e!.path)).toList();
        documents.addAll(list);
        notifyListeners();
      }
    });
  }

  onRemoveResImages(int index) {
    resImages.removeAt(index);
    notifyListeners();
  }

  onRemoveIdentityImage(int index) {
    identityImages.removeAt(index);
    notifyListeners();
  }

  onRemoveDocuments(int index) {
    documents.removeAt(index);
    notifyListeners();
  }

  onRemoveExistedResImages(int index) {
    existedResImages.removeAt(index);
    notifyListeners();
  }

  onRemoveExistedIdentityImage(int index) {
    existedIdentityImages.removeAt(index);
    notifyListeners();
  }

  onRemoveExistedDocuments(int index) {
    uploadedDocuments.removeAt(index);
    notifyListeners();
  }

  clearValidStringStep1() {
    apartmentAddValidate = null;
    nameValidate = null;
    relationValidate = null;
    sexValidate = null;
    birthValidate = null;
    identityValidate = null;
    nationalityValidate = null;
    resTypeValidate = null;
    provValidate = null;
    districtValidate = null;
    wardValidate = null;
    notifyListeners();
  }

  genValidStep1() {
    if (apartmentAddValue == null) {
      apartmentAddValidate = S.current.not_blank;
    } else {
      apartmentAddValidate = null;
    }
    if (nameController.text.trim().isEmpty) {
      nameValidate = S.current.not_blank;
    } else {
      nameValidate = null;
    }
    if (relationValue == null) {
      relationValidate = S.current.not_blank;
    } else {
      relationValidate = null;
    }
    if (sexValue == null) {
      sexValidate = S.current.not_blank;
    } else {
      sexValidate = null;
    }
    if (identityController.text.trim().isEmpty) {
      identityValidate = S.current.not_blank;
    } else {
      identityValidate = null;
    }
    if (birthController.text.trim().isEmpty) {
      birthValidate = S.current.not_blank;
    } else {
      birthValidate = null;
    }
    if (nationalityController.text.trim().isEmpty) {
      nationalityValidate = S.current.not_blank;
    } else {
      nationalityValidate = null;
    }
    if (resTypeValue == null) {
      resTypeValidate = S.current.not_blank;
    } else {
      resTypeValidate = null;
    }
    if (provinceValue == null) {
      provValidate = S.current.not_blank;
    } else {
      provValidate = null;
    }
    if (districtValue == null) {
      districtValidate = S.current.not_blank;
    } else {
      districtValidate = null;
    }
    if (wardValue == null) {
      wardValidate = S.current.not_blank;
    } else {
      wardValidate = null;
    }
    notifyListeners();
  }

  validate1(BuildContext context) {
    if (formKey1.currentState!.validate()) {
      clearValidStringStep1();
    } else {
      genValidStep1();
    }

    notifyListeners();
  }

  validate2(BuildContext context) {}
  onPageChanged(v) {
    activeStep = v;
    notifyListeners();
  }

  onStep1Next(BuildContext context) {
    FocusScope.of(context).unfocus();
    autoValidStep1 = true;
    if (formKey1.currentState!.validate()) {
      isDisableRightCroll = false;
      notifyListeners();
      clearValidStringStep1();
      controller
          .animateToPage(++activeStep,
              duration: const Duration(milliseconds: 250),
              curve: Curves.bounceInOut)
          .then((_) {
        isDisableRightCroll = true;
        notifyListeners();
      });
    } else {
      genValidStep1();
    }
    notifyListeners();
  }

  onChangeProvince(v) async {
    if (v != null) {
      if (provinceValue != v) {
        provinceValue = v;

        districtValue = null;
        wardValue = null;
        districs.clear();
        wards.clear();
        if (autoValidStep1) {
          districtValidate = S.current.not_blank;
        }
      }
      await getDistricByProvinceCode(v);
    }

    notifyListeners();
  }

  onChangeDistrict(v) async {
    if (v != null) {
      districtValidate = null;

      if (districtValue != v) {
        districtValue = v;
        wardValue = null;
        districtValidate = null;

        wards.clear();

        if (autoValidStep1) {
          wardValidate = S.current.not_blank;
        }
      }
      await getWardscByDistrictCode(v);
    }

    notifyListeners();
  }

  getDistricByProvinceCode(code) async {
    var dataDistric = await APIProvince.getDistric(code);
    districs.clear();
    wards.clear();
    for (var i in dataDistric) {
      districs.add(Distric.fromMap(i));
    }
    districs.sort((a, b) => removeDiacritics(a.name ?? "")
        .compareTo(removeDiacritics(a.name ?? "")));
  }

  getWardscByDistrictCode(code) async {
    var dataWard = await APIProvince.getWards(code);
    wards.clear();
    for (var i in dataWard) {
      wards.add(Ward.fromMap(i));
    }
    wards.sort((a, b) => removeDiacritics(a.name ?? "")
        .compareTo(removeDiacritics(a.name ?? "")));
  }

  pickBirthDay(BuildContext context) {
    FocusScope.of(context).unfocus();
    Utils.showDatePickers(
      context,
      initDate: DateTime.now(),
      startDate: DateTime(DateTime.now().year - 10, 1, 1),
      endDate: DateTime(DateTime.now().year + 10, 1, 1),
    ).then((v) {
      if (v != null) {
        birthDate = v;
        birthController.text = Utils.dateFormat(v.toIso8601String(), 0);
        // birthValidate = null;
        notifyListeners();
      }
    });
  }

  onSellectApartment(v) {
    apartmentAddValue = v;
    apartmentAddValidate = null;
    notifyListeners();
  }

  onSellectRelation(v) {
    relationValue = v;
    relationValidate = null;
    notifyListeners();
  }

  onSellectSex(v) {
    sexValue = v;
    sexValidate = null;
    notifyListeners();
  }

  onSellectType(v) {
    resTypeValue = v;
    resTypeValidate = null;
    notifyListeners();
  }

  onSellectProvince(v) {
    provinceValue = v;
    provValidate = null;
    notifyListeners();
  }

  onSellectDistrict(v) {
    districtValue = v;
    districtValidate = null;
    notifyListeners();
  }

  onSellectWard(v) {
    wardValue = v;
    wardValidate = null;
    notifyListeners();
  }

  preFetchData(BuildContext context) async {
    try {
      var relationData = await APIRelation.preFetchDataRelation();
      var provinceData = await APIProvince.getProvince();
      relations.clear();
      provinces.clear();
      for (var i in relationData) {
        relations.add(RelationShip.fromMap(i));
      }
      for (var i in provinceData) {
        provinces.add(Province.fromMap(i));
      }
      provinces.sort((a, b) =>
          removeDiacritics(a.name!).compareTo(removeDiacritics(b.name ?? "")));
    } catch (e) {
      Utils.showErrorMessage(context, e.toString());
    }
  }
}
