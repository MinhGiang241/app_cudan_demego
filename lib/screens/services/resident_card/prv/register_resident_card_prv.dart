// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:app_cudan/models/file_upload.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../../../../models/resident_card.dart';
import '../../../../services/api_auth.dart';
import '../../../../services/api_resident_card.dart';
import '../../../../services/api_rules.dart';
import '../../../../utils/utils.dart';
import '../resident_card_screen.dart';

class RegisterResidentCardPrv extends ChangeNotifier {
  RegisterResidentCardPrv({
    this.id,
    this.residentId,
    this.apartmentId,
    this.code,
    this.existCard,
  }) {
    if (existCard != null) {
      identityImageExisted = [...(existCard?.identity_image ?? [])];
      residentImageExisted = [...(existCard?.resident_image ?? [])];
      otherImageExisted = [...(existCard?.other_image ?? [])];
      confirm = existCard?.confirmation ?? true;
    }
  }

  ResidentCard? existCard;

  bool isAddNewLoading = false;
  bool isSendApproveLoading = false;
  String? id;
  String? code;

  String? residentId;
  String? apartmentId;

  bool confirm = true;

  List<File> identityImageFiles = [];
  List<File> residentImageFiles = [];
  List<File> otherImageFiles = [];

  List<FileUploadModel> identityImageExisted = [];
  List<FileUploadModel> residentImageExisted = [];
  List<FileUploadModel> otherImageExisted = [];

  List<FileUploadModel> identityImageUploaded = [];
  List<FileUploadModel> residentImageUploaded = [];
  List<FileUploadModel> otherImageUploaded = [];

  List<FileUploadModel> rulesFiles = [];

  getRuleFiles() async {
    await APIRule.getListRulesFiles('transportcard').then((v) {
      if (v != null) {
        rulesFiles.clear();
        for (var i in v) {
          rulesFiles.add(FileUploadModel.fromMap(i));
        }
        rulesFiles.sort(
          (a, b) => a.id!.compareTo(b.id!),
        );
      }
    });
  }

  toggleConfirm(v) {
    confirm = !confirm;
    notifyListeners();
  }

  onSubmitCard(BuildContext context, bool isRequest) async {
    var relationship =
        context.read<ResidentInfoPrv>().selectedApartment?.relationshipId;
    isRequest ? isSendApproveLoading = true : isAddNewLoading = true;

    notifyListeners();

    try {
      var listError = [];

      if (listError.isNotEmpty) {
        throw (listError.join(', '));
      }

      await uploadIdentity();
      await uploadRes();
      await uploadOther();

      var newCard = ResidentCard(
        isMobile: true,
        id: id,
        code: code,
        apartmentId: apartmentId,
        residentId: residentId,
        ticket_status: isRequest ? "WAIT" : "NEW",
        confirmation: confirm,
        other_image: otherImageExisted + otherImageUploaded,
        resident_image: residentImageExisted + residentImageUploaded,
        identity_image: identityImageExisted + identityImageUploaded,
        relationship: relationship,
        registration_date:
            DateTime.now().subtract(const Duration(hours: 7)).toIso8601String(),
      );
      var data = newCard.toMap();

      return APIResCard.saveResidentCard(data, id != null).then((v) async {
        await Utils.showSuccessMessage(
          context: context,
          e: isRequest
              ? S.of(context).success_send_req
              : id != null
                  ? S.of(context).success_update
                  : S.of(context).success_cr_new,
          onClose: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              ResidentCardListScreen.routeName,
              (route) => route.isFirst,
              arguments: 1,
            );
          },
        );
        isAddNewLoading = false;
        isSendApproveLoading = false;
        notifyListeners();
      }).catchError((e) {
        isAddNewLoading = false;
        isSendApproveLoading = false;
        residentImageUploaded.clear();
        identityImageUploaded.clear();
        otherImageUploaded.clear();
        notifyListeners();
        Utils.showErrorMessage(context, e.toString());
      });
    } catch (e) {
      residentImageUploaded.clear();
      identityImageUploaded.clear();
      otherImageUploaded.clear();
      isAddNewLoading = false;
      isSendApproveLoading = false;
      notifyListeners();
      Utils.showErrorMessage(context, e.toString());
    }
  }

  onRemoveIdentity(int index) {
    identityImageFiles.removeAt(index);
    notifyListeners();
  }

  onRemoveRes(int index) {
    residentImageFiles.removeAt(index);
    notifyListeners();
  }

  onRemoveOtherImage(int index) {
    otherImageFiles.removeAt(index);
    notifyListeners();
  }

  onRemoveExistIdentity(int index) {
    identityImageExisted.removeAt(index);
    notifyListeners();
  }

  onRemoveExistRes(int index) {
    residentImageExisted.removeAt(index);
    notifyListeners();
  }

  onRemoveExistOtherImage(int index) {
    otherImageExisted.removeAt(index);
    notifyListeners();
  }

  onSelectIdentity(BuildContext context) async {
    await Utils.selectImage(context, false).then((value) {
      if (value != null) {
        final list = value.map<File>((e) => File(e.path)).toList();
        identityImageFiles.addAll(list);
        notifyListeners();
      }
    });
  }

  onSelectResPhoto(BuildContext context) async {
    await Utils.selectImage(context, false).then((value) {
      if (value != null) {
        final list = value.map<File>((e) => File(e.path)).toList();
        residentImageFiles.addAll(list);
        notifyListeners();
      }
    });
  }

  onSelectOtherImage(BuildContext context) async {
    await Utils.selectImage(context, false).then((value) {
      if (value != null) {
        final list = value.map<File>((e) => File(e.path)).toList();
        otherImageFiles.addAll(list);
        notifyListeners();
      }
    });
  }

  Future uploadIdentity() async {
    await APIAuth.uploadSingleFile(
      files: identityImageFiles,
    ).then((v) {
      if (v.isNotEmpty) {
        for (var e in v) {
          identityImageUploaded.add(
            FileUploadModel(id: e.data, name: e.name),
          );
        }
      }
    }).catchError((e) {
      throw (e);
    });
  }

  Future uploadRes() async {
    await APIAuth.uploadSingleFile(
      files: residentImageFiles,
    ).then((v) {
      if (v.isNotEmpty) {
        for (var e in v) {
          residentImageUploaded.add(
            FileUploadModel(id: e.data, name: e.name),
          );
        }
      }
    }).catchError((e) {
      throw (e);
    });
  }

  Future uploadOther() async {
    await APIAuth.uploadSingleFile(
      files: otherImageFiles,
    ).then((v) {
      if (v.isNotEmpty) {
        for (var e in v) {
          otherImageUploaded.add(
            FileUploadModel(id: e.data, name: e.name),
          );
        }
      }
    }).catchError((e) {
      throw (e);
    });
  }

  final formKey = GlobalKey<FormState>();
}
