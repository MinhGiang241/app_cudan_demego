import 'dart:io';

import 'package:app_cudan/services/api_lost.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../../../../models/missing_object.dart';
import '../../../../services/api_auth.dart';
import '../../../../utils/utils.dart';
import '../../../auth/prv/resident_info_prv.dart';
import '../missing_object_screen.dart';

class PickItemPrv extends ChangeNotifier {
  var existedImage = [];
  List<File> imagesPick = [];
  List<MissingImage> submitImagesLoot = [];
  bool isLoading = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController foundController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  DateTime? foundDate;
  String? validateName;
  String? validatePlace;
  String? validateFoundTime;
  bool autoValid = false;
  final formKey = GlobalKey<FormState>();

  validate(BuildContext context) {
    if (formKey.currentState!.validate()) {
      validateName = null;
      validatePlace = null;
      validateFoundTime = null;
    } else {
      if (placeController.text.trim().isEmpty) {
        validatePlace = S.of(context).not_blank;
      } else {
        validatePlace = null;
      }
      if (nameController.text.trim().isEmpty) {
        validateName = S.of(context).not_blank;
      } else {
        validateName = null;
      }
      if (foundController.text.trim().isEmpty) {
        validateFoundTime = S.of(context).not_blank;
      } else {
        validateFoundTime = null;
      }
    }

    notifyListeners();
  }

  submitPick(BuildContext context) {
    autoValid = true;
    isLoading = true;
    validateName = null;
    validatePlace = null;
    validateFoundTime = null;
    notifyListeners();
    FocusScope.of(context).unfocus();
    if (formKey.currentState!.validate()) {
      try {
        var now = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          24,
        );
        var listError = [];
        if (foundDate!.compareTo(now) > 0) {
          listError.add(S.of(context).find_time_now);
        }
        if (imagesPick.isEmpty) {
          listError.add(S.of(context).image_not_empty);
        }
        if (listError.isNotEmpty) {
          throw (listError.join(',  '));
        }

        return uploadImage(context).then((v) {
          // var apartment = context.read<ResidentInfoPrv>().selectedApartment;

          var loot = LootItem(
            address: placeController.text.trim(),
            date: (foundDate!.subtract(const Duration(hours: 7)))
                .toIso8601String(),
            describe: noteController.text.trim(),
            name: nameController.text.trim(),
            photo: submitImagesLoot,
            tel: context.read<ResidentInfoPrv>().userInfo!.phone_required,
            residential: context.read<ResidentInfoPrv>().userInfo!.info_name,
            status: "WAIT_RETURN",
            residentId: context.read<ResidentInfoPrv>().residentId,
            apartmentId:
                context.read<ResidentInfoPrv>().selectedApartment?.apartmentId,
          );

          return APILost.saveLootItem(loot.toJson());
        }).then((v) {
          Utils.showSuccessMessage(
            context: context,
            e: S.of(context).success_send_letter,
            onClose: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                MissingObectScreen.routeName,
                (route) => route.isFirst,
                arguments: {
                  "year": foundDate!.year,
                  "month": foundDate!.month,
                  "index": 1,
                },
              );
            },
          );
          validateName = null;
          isLoading = false;
          validatePlace = null;
          validateFoundTime = null;
          notifyListeners();
        }).catchError((e) {
          submitImagesLoot.clear();
          isLoading = false;
          validateName = null;
          validatePlace = null;
          validateFoundTime = null;
          notifyListeners();
          Utils.showErrorMessage(context, e.toString());
        });
      } catch (e) {
        submitImagesLoot.clear();
        isLoading = false;
        validateName = null;
        validatePlace = null;
        validateName = null;
        notifyListeners();
        Utils.showErrorMessage(context, e.toString());
      }
    } else {
      isLoading = false;
      validateName = null;
      validatePlace = null;
      validateName = null;
      if (placeController.text.trim().isEmpty) {
        validatePlace = S.of(context).not_blank;
      } else {
        validatePlace = null;
      }
      if (nameController.text.trim().isEmpty) {
        validateName = S.of(context).not_blank;
      } else {
        validateName = null;
      }
      if (foundController.text.trim().isEmpty) {
        validateFoundTime = S.of(context).not_blank;
      } else {
        validateFoundTime = null;
      }

      notifyListeners();
    }
  }

  uploadImage(BuildContext context) async {
    await APIAuth.uploadSingleFile(files: imagesPick, context: context)
        .then((v) {
      if (v.isNotEmpty) {
        for (var e in v) {
          submitImagesLoot.add(
            MissingImage(id: e.data, name: e.name),
          );
        }
      }
    }).catchError((e) {
      throw (e);
    });
  }

  pickFoundDate(BuildContext context) {
    Utils.showDatePickers(
      context,
      initDate: foundDate ?? DateTime.now(),
      startDate: DateTime(DateTime.now().year - 10, 1, 1),
      endDate: DateTime(DateTime.now().year + 10, 1, 1),
    ).then((v) {
      if (v != null) {
        foundController.text = Utils.dateFormat(v.toIso8601String(), 0);
        foundDate = v;
      }
    });
  }

  onSelectImagePick(BuildContext context) async {
    await Utils.selectImage(context, false).then((value) {
      if (value != null) {
        final list = value.map<File>((e) => File(e.path)).toList();
        imagesPick.addAll(list);
        notifyListeners();
      }
    });
  }

  removeExistedImages(int index) {
    existedImage.removeAt(index);
    notifyListeners();
  }

  onRemoveImagePick(int index) {
    imagesPick.removeAt(index);
    notifyListeners();
  }
}
