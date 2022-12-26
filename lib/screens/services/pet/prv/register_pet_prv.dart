import 'dart:io';

import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/services/api_pet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../../../../models/pet.dart';
import '../../../../services/api_auth.dart';
import '../../../../utils/utils.dart';
import '../pet_list_screen.dart';

class RegisterPetPrv extends ChangeNotifier {
  RegisterPetPrv({
    this.existedPet,
  }) {
    isAgree = existedPet!.check ?? false;
    nameController.text = existedPet!.pet_name ?? "";
    typeController.text = existedPet!.pet_type ?? "";
    colorController.text = existedPet!.color ?? "";
    originController.text = existedPet!.pet_type ?? '';
    sexController.text = existedPet!.sex ?? '';
    weightController.text =
        existedPet!.weight != null ? existedPet!.weight.toString() : '';
    descriptionController.text = existedPet!.describe ?? "";
    isAgree = existedPet!.check ?? false;
    existedImage = existedPet!.avt_pet ?? [];
    exitedCertificateFiles = existedPet!.certificate ?? [];
    existedReportFiles = existedPet!.report ?? [];
  }
  final formKey = GlobalKey<FormState>();
  List<PetFile> existedImage = [];
  List<File> imagesPet = [];
  List<PetFile> submitImagesPet = [];
  List<File> certificateFiles = [];
  List<PetFile> submitCertificateFiles = [];
  List<PetFile> exitedCertificateFiles = [];
  List<File> reportFiles = [];
  List<PetFile> submitReportFiles = [];
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
  Pet? existedPet;
  String? validateName;
  String? validateType;
  String? validateColor;
  String? validateOrigin;
  String? validateSex;
  String? validateWeight;

  onSendSummitPet(BuildContext context, bool isRequest) async {
    FocusScope.of(context).unfocus();
    if (formKey.currentState!.validate()) {
      if (isRequest) {
        isSendApproveLoading = true;
      } else {
        isAddNewLoading = true;
      }
      notifyListeners();
      try {
        var listError = [];
        var w = weightController.text.trim();
        if (double.tryParse(w) != null && double.parse(w) <= 15) {
          listError.add(S.of(context).weight_not_15);
        }
        if (!isAgree) {
          listError.add(S.of(context).pet_agree);
        }
        if (listError.isNotEmpty) {
          throw (listError.join(',  '));
        }

        await uploadImagePet(context).then((v) {
          return uploadCertificatePet(context);
        }).then((o) {
          return uploadReport(context);
        }).then((c) {
          var newPet = Pet(
            apartmentId:
                context.read<ResidentInfoPrv>().selectedApartment!.apartmentId,
            isMobile: true,
            check: isAgree,
            color: colorController.text.trim(),
            describe: descriptionController.text.trim(),
            pet_name: nameController.text.trim(),
            pet_status: isRequest ? "WAIT" : "NEW",
            sex: sexController.text.trim(),
            pet_type: typeController.text.trim(),
            species: originController.text.trim(),
            subscriberId: context.read<ResidentInfoPrv>().residentId,
            tel: context.read<ResidentInfoPrv>().userInfo!.phone_required,
            weight: int.tryParse(weightController.text.trim()) != null
                ? int.parse(weightController.text.trim())
                : 0,
            avt_pet: existedImage + submitImagesPet,
            certificate: exitedCertificateFiles + submitCertificateFiles,
            report: existedReportFiles + submitReportFiles,
          );
          return APIPet.savePet(newPet.toJson());
        }).then((v) {
          Utils.showSuccessMessage(
              context: context,
              e: isRequest
                  ? S.of(context).success_send_req
                  : existedPet != null
                      ? S.of(context).success_edit
                      : S.of(context).success_cr_new,
              onClose: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, PetListScreen.routeName, (route) => route.isFirst);
              });
          isSendApproveLoading = false;
          isAddNewLoading = false;
          validateName = null;
          validateType = null;
          validateColor = null;
          validateOrigin = null;
          validateSex = null;
          validateWeight = null;
          notifyListeners();
        }).catchError((e) {
          throw (e);
        });
      } catch (e) {
        isSendApproveLoading = false;
        isAddNewLoading = false;
        validateName = null;
        validateType = null;
        validateColor = null;
        validateOrigin = null;
        validateSex = null;
        validateWeight = null;
        notifyListeners();
        Utils.showErrorMessage(context, e.toString());
      }
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

  uploadImagePet(BuildContext context) async {
    await APIAuth.uploadSingleFile(files: imagesPet, context: context)
        .then((v) {
      if (v.isNotEmpty) {
        for (var e in v) {
          submitImagesPet.add(
            PetFile(id: e.data, name: e.name),
          );
        }
      }
    }).catchError((e) {
      throw (e);
    });
  }

  uploadCertificatePet(BuildContext context) async {
    await APIAuth.uploadSingleFile(files: certificateFiles, context: context)
        .then((v) {
      if (v.isNotEmpty) {
        for (var e in v) {
          submitCertificateFiles.add(
            PetFile(id: e.data, name: e.name),
          );
        }
      }
    }).catchError((e) {
      throw (e);
    });
  }

  uploadReport(BuildContext context) async {
    await APIAuth.uploadSingleFile(files: reportFiles, context: context)
        .then((v) {
      if (v.isNotEmpty) {
        for (var e in v) {
          submitReportFiles.add(
            PetFile(id: e.data, name: e.name),
          );
        }
      }
    }).catchError((e) {
      throw (e);
    });
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
