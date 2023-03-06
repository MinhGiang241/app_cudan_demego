import 'dart:io';

import 'package:app_cudan/services/api_reflection.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../../models/file_upload.dart';
import '../../../models/relationship.dart';
import '../../../services/api_relation.dart';
import '../../../utils/utils.dart';

class AddNewResidentPrv extends ChangeNotifier {
  int activeStep = 0;
  bool isDisableRightCroll = true;
  bool autoValidStep1 = false;
  bool autoValidStep2 = false;
  List<RelationShip> relations = [];
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final PageController controller = PageController();

  DateTime? birthDate;
  final TextEditingController apartmentAddController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController relationController = TextEditingController();
  final TextEditingController sexController = TextEditingController();
  final TextEditingController birthController = TextEditingController();
  final TextEditingController identityController = TextEditingController();
  final TextEditingController issuePlaceController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController resTypeController = TextEditingController();
  final TextEditingController provController = TextEditingController();
  final TextEditingController wardController = TextEditingController();
  final TextEditingController blockController = TextEditingController();

  String? apartmentAddValidate;
  String? nameValidate;
  String? relationValidate;
  String? sexValidate;
  String? birthValidate;
  String? identityValidate;
  String? nationalityValidate;
  String? resTypeValidate;
  String? provValidate;
  String? wardValidate;
  String? blockValidate;

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
    identityValidate;
    nationalityValidate = null;
    resTypeValidate = null;
    provValidate = null;
    wardValidate = null;
    blockValidate = null;
    notifyListeners();
  }

  genValidStep1() {
    if (apartmentAddController.text.trim().isEmpty) {
      apartmentAddValidate = S.current.not_blank;
    } else {
      apartmentAddValidate = null;
    }
    if (nameController.text.trim().isEmpty) {
      nameValidate = S.current.not_blank;
    } else {
      nameValidate = null;
    }
    if (relationController.text.trim().isEmpty) {
      relationValidate = S.current.not_blank;
    } else {
      relationValidate = null;
    }
    if (sexController.text.trim().isEmpty) {
      sexValidate = S.current.not_blank;
    } else {
      sexValidate = null;
    }
    if (identityController.text.trim().isEmpty) {
      identityValidate = S.current.not_blank;
    } else {
      birthValidate = null;
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
    if (resTypeController.text.trim().isEmpty) {
      resTypeValidate = S.current.not_blank;
    } else {
      resTypeValidate = null;
    }
    if (provController.text.trim().isEmpty) {
      provValidate = S.current.not_blank;
    } else {
      provValidate = null;
    }
    if (wardController.text.trim().isEmpty) {
      wardValidate = S.current.not_blank;
    } else {
      wardValidate = null;
    }
    if (blockController.text.trim().isEmpty) {
      blockValidate = S.current.not_blank;
    } else {
      blockValidate = null;
    }
    notifyListeners();
  }

  validate1(BuildContext context) {
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

  pickBirthDay(BuildContext context) {
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

  preFetchData(BuildContext context) async {
    try {
      relations.clear();
      var relationData = await APIRelation.preFetchDataRelation();
      for (var i in relationData) {
        relations.add(RelationShip.fromMap(i));
      }
    } catch (e) {
      Utils.showErrorMessage(context, e.toString());
    }
  }
}
