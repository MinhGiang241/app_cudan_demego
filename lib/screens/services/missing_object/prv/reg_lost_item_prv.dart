import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../../../utils/utils.dart';

class RegisterLostItemPrv extends ChangeNotifier {
  var existedImage = [];
  List<File> imagesLost = [];
  final TextEditingController lostDateController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  DateTime? lostDate;
  bool isLoading = false;
  String? validateName;
  String? validateLostTime;
  final formKey = GlobalKey<FormState>();

  submitRegister(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (formKey.currentState!.validate()) {
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

      notifyListeners();
    }
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
    await Utils.selectImage(context, true).then((value) {
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
