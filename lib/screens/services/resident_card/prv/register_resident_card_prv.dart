// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../../../models/resident_card.dart';
import '../../../../services/api_auth.dart';
import '../../../../services/api_resident_card.dart';
import '../../../../utils/utils.dart';
import '../resident_card_screen.dart';

class RegisterResidentCardPrv extends ChangeNotifier {
  RegisterResidentCardPrv({
    this.id,
    this.imageUrlFront,
    this.imageUrlBack,
    this.otherImage,
    this.residentId,
    this.apartmentId,
  });

  bool isLoading = false;
  String? id;
  String? imageUrlFront;
  String? imageUrlBack;
  String? otherImage;
  String? residentId;
  String? apartmentId;
  List<File> imageFileFront = [];
  List<File> imageFileBack = [];
  List<File> otherImageFile = [];
  onSubmitCard(BuildContext context, bool isRequest) {
    isLoading = true;
    notifyListeners();
    uploadFrontPhoto(context).then((v) {
      return uploadBackPhoto(context);
    }).then((v) {
      return uploadOtherImage(context);
    }).then((v) {
      var newCard = ResidentCard(
          id: id,
          apartmentId: apartmentId,
          residentId: residentId,
          identity_image_front: imageUrlFront,
          identity_image_back: imageUrlBack,
          other_image: otherImage,
          ticket_status: isRequest ? "WAIT" : "NEW");
      if (isRequest && newCard.identity_image_front == null) {
        throw (S.of(context).not_empty_front);
      }
      if (isRequest && newCard.identity_image_back == null) {
        throw (S.of(context).not_empty_back);
      }
      var data = newCard.toJson();

      return APIResCard.saveResidentCard(data);
    }).then((v) {
      isLoading = false;
      notifyListeners();
      Utils.showSuccessMessage(
          context: context,
          e: isRequest
              ? S.of(context).success_send_req
              : id != null
                  ? S.of(context).success_edit
                  : S.of(context).success_cr_new,
          onClose: () {
            // var count = 0;
            Navigator.pushReplacementNamed(
                context, ResidentCardListScreen.routeName);
          });
    }).catchError((e) {
      isLoading = false;
      notifyListeners();
      Utils.showErrorMessage(context, e.toString());
    });
    ;
  }

  onRemoveFront(int index) {
    imageFileFront.removeAt(index);
    notifyListeners();
  }

  onSelectFrontPhoto(BuildContext context) async {
    await Utils.selectImage(context, false).then((value) {
      if (value != null) {
        final list = value.map<File>((e) => File(e.path)).toList();
        imageFileFront.addAll(list);
        notifyListeners();
      }
    });
  }

  onRemoveBack(int index) {
    imageFileBack.removeAt(index);
    notifyListeners();
  }

  onSelectBackPhoto(BuildContext context) async {
    await Utils.selectImage(context, false).then((value) {
      if (value != null) {
        final list = value.map<File>((e) => File(e.path)).toList();
        imageFileBack.addAll(list);
        notifyListeners();
      }
    });
  }

  onRemoveOtherImage(int index) {
    otherImageFile.removeAt(index);
    notifyListeners();
  }

  onSelectOtherImage(BuildContext context) async {
    await Utils.selectImage(context, false).then((value) {
      if (value != null) {
        final list = value.map<File>((e) => File(e.path)).toList();
        otherImageFile.addAll(list);
        notifyListeners();
      }
    });
  }

  onRemoveUrlImage(BuildContext context, int choice) {
    if (choice == 1) {
      imageUrlFront = null;
    } else if (choice == 2) {
      imageUrlBack = null;
    } else {
      otherImage = null;
    }
    notifyListeners();
  }

  uploadFrontPhoto(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    await APIAuth.uploadSingleFile(files: imageFileFront, context: context)
        .then((v) {
      isLoading = false;

      if (v.isNotEmpty) {
        imageUrlFront = v[0].data;
      }

      notifyListeners();
    }).catchError((e) {
      isLoading = false;
      notifyListeners();
      throw (e);
    });
  }

  uploadBackPhoto(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    await APIAuth.uploadSingleFile(files: imageFileBack, context: context)
        .then((v) {
      isLoading = false;

      if (v.isNotEmpty) {
        imageUrlBack = v[0].data;
      }

      notifyListeners();
    }).catchError((e) {
      isLoading = false;
      notifyListeners();
      throw (e);
    });
  }

  uploadOtherImage(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    await APIAuth.uploadSingleFile(files: otherImageFile, context: context)
        .then((v) {
      isLoading = false;

      if (v.isNotEmpty) {
        otherImage = v[0].data;
      }

      notifyListeners();
    }).catchError((e) {
      isLoading = false;
      notifyListeners();
      throw (e);
    });
  }

  final formKey = GlobalKey<FormState>();
}
