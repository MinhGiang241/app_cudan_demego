// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/screens/reg_resident/add_new_resident_screen.dart';
import 'package:app_cudan/services/api_province.dart';
import 'package:app_cudan/services/api_reflection.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../models/file_upload.dart';
import '../../../models/form_add_resident.dart';
import '../../../models/province.dart';
import '../../../models/relationship.dart';
import '../../../services/api_auth.dart';
import '../../../services/api_relation.dart';
import '../../../services/api_resident_add_apartment.dart';
import '../../../utils/utils.dart';
import '../register_resident_screen.dart';

class AddNewResidentPrv extends ChangeNotifier {
  int activeStep = 0;
  bool isDisableRightCroll = true;
  bool autoValidStep1 = false;
  bool autoValidStep2 = false;
  bool isLoading = false;
  List<RelationShip> relations = [];
  List<Province> provinces = [];
  List<Distric> districs = [];
  List<Ward> wards = [];
  List<Ethnic> ethnics = [];
  List<Nationality> nationalities = [];
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final PageController controller = PageController();

  DateTime? birthDate;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthController = TextEditingController();
  final TextEditingController identityController = TextEditingController();
  final TextEditingController issuePlaceController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController qualificationController = TextEditingController();
  final TextEditingController jobController = TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController zaloController = TextEditingController();
  final TextEditingController instagramController = TextEditingController();
  final TextEditingController linkedinController = TextEditingController();
  final TextEditingController tiktokController = TextEditingController();

  String? apartmentAddValue;
  String? relationValue;
  String? sexValue;
  String? resTypeValue;
  String? provinceValue;
  String? districtValue;
  String? wardValue;
  String? ethnicValue;
  String? nationalityValue;
  String? matialStatusValue;
  String? educationValue;

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
  String? ethnicValidate;

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

  clearValidStringStep2() {
    ethnicValidate = null;
    notifyListeners();
  }

  genValidStep2() {
    if (ethnicValue == null) {
      ethnicValidate = S.current.not_blank;
    } else {
      ethnicValidate = null;
    }
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
    if (nationalityValue == null) {
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

  validate2(BuildContext context) {
    if (formKey2.currentState!.validate()) {
      clearValidStringStep2();
    } else {
      genValidStep2();
    }

    notifyListeners();
  }

  onPageChanged(v) {
    activeStep = v;
    notifyListeners();
  }

  onStep1Next(BuildContext context) {
    FocusScope.of(context).unfocus();
    autoValidStep1 = true;

    if (formKey1.currentState!.validate() &&
        (resImages.isNotEmpty || existedResImages.isNotEmpty)) {
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
      if (resImages.isEmpty && existedResImages.isEmpty) {
        Utils.showErrorMessage(context, S.of(context).res_image_not_empty);
      }
      genValidStep1();
    }
    notifyListeners();
  }

  onSendRequest(BuildContext context) async {
    FocusScope.of(context).unfocus();
    autoValidStep2 = true;
    isLoading = true;
    notifyListeners();
    if (formKey2.currentState!.validate()) {
      var apartment = context
          .read<ResidentInfoPrv>()
          .listOwn
          .firstWhere((element) => element.apartmentId == apartmentAddValue);
      var province =
          provinces.firstWhere((element) => element.code == provinceValue);
      var district =
          districs.firstWhere((element) => element.code == districtValue);
      var ward = wards.firstWhere((element) => element.code == wardValue);
      var residentId = context.read<ResidentInfoPrv>().residentId;

      try {
        await uploadResientImages(context);
        await uploadIdentityImages(context);
        await uploadDocument(context);

        FormAddResidence formAddResident = FormAddResidence(
          apartmentId: apartmentAddValue,
          buildingId: apartment.buildingId,
          floorId: apartment.floorId,
          date_birth:
              birthDate!.subtract(const Duration(hours: 7)).toIso8601String(),
          provinceId: province.id,
          districtId: district.id,
          wardsId: ward.id,
          residentId: residentId,
          material_status: matialStatusValue,
          education: educationValue,
          email: emailController.text.trim(),
          info_name: nameController.text.trim(),
          ethnicId: ethnicValue,
          identity_card_required: identityController.text.trim(),
          job: jobController.text.trim(),
          nationalId: nationalityValue,
          relationshipId: relationValue,
          qualification: qualificationController.text.trim(),
          phone_required: phoneController.text.trim(),
          resident_images: existedResImages + uploadedResImages,
          identity_images: existedIdentityImages + uploadedIdentityImages,
          upload: existedDoccuments + uploadedDocuments,
          place_of_issue_required: issuePlaceController.text.trim(),
          residence_type: resTypeValue,
          sex: sexValue,
          facebook: facebookController.text.trim(),
          zalo: zaloController.text.trim(),
          instagram: instagramController.text.trim(),
          linkedin: linkedinController.text.trim(),
          tiktok: tiktokController.text.trim(),
          status: "NEW",
        );
        await APIResidentAddApartment.saveFormResidentAddApartment(
                formAddResident.toMap())
            .then((v) {
          isLoading = false;
          notifyListeners();
          Utils.showSuccessMessage(
              context: context,
              e: S.of(context).success_register_dependence,
              onClose: () {
                Navigator.pushNamedAndRemoveUntil(context,
                    RegisterResidentScreen.routeName, (route) => route.isFirst);
              });
        });
      } catch (e) {
        isLoading = false;
        notifyListeners();
        Utils.showErrorMessage(context, e.toString());
      }
    } else {
      isLoading = false;
      genValidStep2();
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

  onSellectEthnic(v) {
    ethnicValue = v;
    ethnicValidate = null;
    notifyListeners();
  }

  onSellectNationality(v) {
    nationalityValue = v;
    nationalityValidate = null;
    notifyListeners();
  }

  onSellectMatialStatus(v) {
    matialStatusValue = v;
    notifyListeners();
  }

  onSellectEducation(v) {
    educationValue = v;
    notifyListeners();
  }

  Future uploadResientImages(BuildContext context) async {
    await APIAuth.uploadSingleFile(files: resImages, context: context)
        .then((v) {
      if (v.isNotEmpty) {
        for (var e in v) {
          uploadedResImages.add(
            FileUploadModel(id: e.data, name: e.name),
          );
        }
      }
    }).catchError((e) {
      throw (e);
    });
  }

  Future uploadIdentityImages(BuildContext context) async {
    await APIAuth.uploadSingleFile(files: identityImages, context: context)
        .then((v) {
      if (v.isNotEmpty) {
        for (var e in v) {
          uploadedIdentityImages.add(
            FileUploadModel(id: e.data, name: e.name),
          );
        }
      }
    }).catchError((e) {
      throw (e);
    });
  }

  Future uploadDocument(BuildContext context) async {
    await APIAuth.uploadSingleFile(files: documents, context: context)
        .then((v) {
      if (v.isNotEmpty) {
        for (var e in v) {
          uploadedDocuments.add(
            FileUploadModel(id: e.data, name: e.name),
          );
        }
      }
    }).catchError((e) {
      throw (e);
    });
  }

  preFetchData(BuildContext context) async {
    try {
      var relationData = await APIRelation.preFetchDataRelation();
      var provinceData = await APIProvince.getProvince();
      var ethnicData = await APIProvince.getEthnics();
      var nationalityData = await APIProvince.getNationalities();
      relations.clear();
      provinces.clear();
      ethnics.clear();
      nationalities.clear();
      for (var i in relationData) {
        relations.add(RelationShip.fromMap(i));
      }
      for (var i in provinceData) {
        provinces.add(Province.fromMap(i));
      }
      for (var i in ethnicData) {
        ethnics.add(Ethnic.fromMap(i));
      }
      for (var i in nationalityData) {
        nationalities.add(Nationality.fromMap(i));
      }
      provinces.sort((a, b) =>
          removeDiacritics(a.name!).compareTo(removeDiacritics(b.name ?? "")));
      nationalities.sort((a, b) =>
          removeDiacritics(a.name!).compareTo(removeDiacritics(b.name ?? "")));
      ethnics.sort((a, b) => (a.code!).compareTo((b.code ?? "")));
    } catch (e) {
      Utils.showErrorMessage(context, e.toString());
    }
  }
}
