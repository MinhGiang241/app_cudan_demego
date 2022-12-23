import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../../../models/pet.dart';
import '../../../../utils/utils.dart';

class RegisterPetPrv extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  List<PetFile> existedImage = [];
  List<File> imagesPet = [];
  List<File> certificateFiles = [];
  List<PetFile> exitedCertificateFiles = [];
  List<File> reportFiles = [];
  List<PetFile> existedReportFiles = [];
  bool isAgree = false;
  bool isAddNewLoading = false;
  bool isSendApproveLoading = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController originController = TextEditingController();
  final TextEditingController sexController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? validateName;
  String? validateType;
  String? validateColor;
  String? validateOrigin;
  String? validateSex;
  String? validateWeight;

  onSendSummitPet(BuildContext context, bool isRequest) {
    FocusScope.of(context).unfocus();
    if (formKey.currentState!.validate()) {
      if (isRequest) {
        isSendApproveLoading = true;
      } else {
        isAddNewLoading = true;
      }
      notifyListeners();
    } else {
      if (nameController.text.trim().isEmpty) {
        validateName = S.of(context).not_blank;
      } else {
        validateName = null;
      }
      if (typeController.text.trim().isEmpty) {
        validateType = S.of(context).not_blank;
      } else {
        validateType = null;
      }
      if (colorController.text.trim().isEmpty) {
        validateColor = S.of(context).not_blank;
      } else {
        validateColor = null;
      }
      if (originController.text.trim().isEmpty) {
        validateOrigin = S.of(context).not_blank;
      } else {
        validateOrigin = null;
      }
      if (sexController.text.trim().isEmpty) {
        validateSex = S.of(context).not_blank;
      } else {
        validateSex = null;
      }
      if (weightController.text.trim().isEmpty) {
        validateWeight = S.of(context).not_blank;
      } else {
        validateWeight = null;
      }

      notifyListeners();
    }
  }

  onAgree() {
    isAgree = !isAgree;
    notifyListeners();
  }

  onRemoveImagePet(int index) {
    imagesPet.removeAt(index);
    notifyListeners();
  }

  removeExistedImages(int index) {
    existedImage.removeAt(index);
    notifyListeners();
  }

  onSelectImagePet(BuildContext context) async {
    await Utils.selectImage(context, true).then((value) {
      if (value != null) {
        final list = value.map<File>((e) => File(e.path)).toList();
        imagesPet.addAll(list);
        notifyListeners();
      }
    });
  }

  onSelectCertificate(BuildContext context) async {
    await Utils.selectFile(context, false).then((value) {
      if (value != null) {
        final list = value.map<File>((e) => File(e!.path)).toList();
        certificateFiles.addAll(list);
        notifyListeners();
      }
    });
  }

  onRemoveCertificate(int index) {
    certificateFiles.removeAt(index);
    notifyListeners();
  }

  removeExistedCertificateFile(int index) {
    exitedCertificateFiles.removeAt(index);
    notifyListeners();
  }

  onSelectReport(BuildContext context) async {
    await Utils.selectFile(context, false).then((value) {
      if (value != null) {
        final list = value.map<File>((e) => File(e!.path)).toList();
        reportFiles.addAll(list);
        notifyListeners();
      }
    });
  }

  onRemoveReport(int index) {
    reportFiles.removeAt(index);
    notifyListeners();
  }

  removeExistedReportFile(int index) {
    existedReportFiles.removeAt(index);
    notifyListeners();
  }
}
