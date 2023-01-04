import 'dart:io';

import 'package:app_cudan/models/missing_object.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/screens/services/missing_object/missing_object_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../../../../services/api_auth.dart';
import '../../../../services/api_lost.dart';
import '../../../../utils/utils.dart';

class RegisterLostItemPrv extends ChangeNotifier {
  var existedImage = [];
  List<File> imagesLost = [];
  List<MissingImage> submitImagesLost = [];
  final TextEditingController lostDateController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  DateTime? lostDate;
  bool isLoading = false;
  String? validateName;
  String? validateLostTime;
  final formKey = GlobalKey<FormState>();

  validate(BuildContext context) {
    if (formKey.currentState!.validate()) {
      validateName = null;
      validateLostTime = null;
    } else {
      if (lostDateController.text.isEmpty) {
        validateLostTime = S.of(context).not_blank;
      } else {
        validateLostTime = null;
      }
      if (nameController.text.trim().isEmpty) {
        validateName = S.of(context).not_blank;
      } else {
        validateName = null;
      }
    }

    notifyListeners();
  }

  submitRegisterLost(BuildContext context) {
    isLoading = true;
    validateName = null;
    validateLostTime = null;
    notifyListeners();
    FocusScope.of(context).unfocus();
    if (formKey.currentState!.validate()) {
      try {
        var now = DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day, 24);

        var listError = [];

        if (lostDate!.compareTo(now) >= 0) {
          listError.add(S.of(context).lost_time_now);
        }
        if (listError.isNotEmpty) {
          throw (listError.join(',  '));
        }
        var apartment = context.read<ResidentInfoPrv>().selectedApartment;
        var lost = MissingObject(
          apartment:
              "${apartment!.apartment!.name}, ${apartment.floor!.name}, ${apartment.building!.name}",
          customer: context.read<ResidentInfoPrv>().userInfo!.info_name,
          describe: noteController.text.trim(),
          image: submitImagesLost,
          time: lostDate!.toIso8601String(),
          name: nameController.text.trim(),
          phone_number:
              context.read<ResidentInfoPrv>().userInfo!.phone_required,
          status: "NOTFOUND",
        );
        return uploadImage(context).then((v) {
          return APILost.saveLostItem(lost.toJson());
        }).then((v) {
          Utils.showSuccessMessage(
              context: context,
              e: S.of(context).success_send_letter,
              onClose: () {
                Navigator.pushNamedAndRemoveUntil(context,
                    MissingObectScreen.routeName, (route) => route.isFirst,
                    arguments: {
                      "year": lostDate!.year,
                      "month": lostDate!.month,
                      "index": 0,
                    });
              });
          isLoading = false;
          validateName = null;
          validateLostTime = null;
          notifyListeners();
        }).catchError((e) {
          isLoading = false;
          validateName = null;
          validateLostTime = null;
          notifyListeners();
          Utils.showErrorMessage(context, e.toString());
        });
      } catch (e) {
        isLoading = false;
        validateName = null;
        validateLostTime = null;
        notifyListeners();
        Utils.showErrorMessage(context, e.toString());
      }
    } else {
      isLoading = false;
      validateName = null;
      validateLostTime = null;
      if (lostDateController.text.isEmpty) {
        validateLostTime = S.of(context).not_blank;
      } else {
        validateLostTime = null;
      }
      if (nameController.text.trim().isEmpty) {
        validateName = S.of(context).not_blank;
      } else {
        validateName = null;
      }

      notifyListeners();
    }
  }

  uploadImage(BuildContext context) async {
    await APIAuth.uploadSingleFile(files: imagesLost, context: context)
        .then((v) {
      if (v.isNotEmpty) {
        for (var e in v) {
          submitImagesLost.add(
            MissingImage(id: e.data, name: e.name),
          );
        }
      }
    }).catchError((e) {
      throw (e);
    });
  }

  pickLostDate(BuildContext context) {
    Utils.showDatePickers(
      context,
      initDate: lostDate ?? DateTime.now(),
      startDate: DateTime(DateTime.now().year - 10, 1, 1),
      endDate: DateTime(DateTime.now().year + 10, 1, 1),
    ).then((v) {
      if (v != null) {
        lostDateController.text = Utils.dateFormat(v.toIso8601String(), 0);
        lostDate = v;
      }
    });
  }

  onSelectImageLost(BuildContext context) async {
    await Utils.selectImage(context, false).then((value) {
      if (value != null) {
        final list = value.map<File>((e) => File(e.path)).toList();
        imagesLost.addAll(list);
        notifyListeners();
      }
    });
  }

  removeExistedImages(int index) {
    existedImage.removeAt(index);
    notifyListeners();
  }

  onRemoveImageLost(int index) {
    imagesLost.removeAt(index);
    notifyListeners();
  }
}
