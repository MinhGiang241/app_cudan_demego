import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../../../utils/utils.dart';

class PickItemPrv extends ChangeNotifier {
  var existedImage = [];
  List<File> imagesPick = [];
  bool isLoading = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController foundController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  DateTime? foundDate;
  String? validateName;
  String? validatePlace;
  String? validateFoundTime;
  final formKey = GlobalKey<FormState>();

  submitPick(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (formKey.currentState!.validate()) {
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

      notifyListeners();
    }
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
    await Utils.selectImage(context, true).then((value) {
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
