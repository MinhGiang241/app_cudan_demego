import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../utils/utils.dart';
import '../../../../models/selection_model.dart';
import '../../../../utils/utils.dart';

class RegisterParkingCardPrv extends ChangeNotifier {
  final List<SelectionModel> listVehicles = [
    SelectionModel(title: "Xe máy"),
    SelectionModel(title: "Ô tô")
  ];
  final List<SelectionModel> listResidents = [
    SelectionModel(title: "Nguyễn Văn A"),
    SelectionModel(title: "Nguyễn Thị B"),
  ];

  bool isOwner = false;

  List<File> images = [];

  final TextEditingController vTypeController = TextEditingController();
  final TextEditingController memberController = TextEditingController();
  final TextEditingController vComController = TextEditingController();
  final TextEditingController lpController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController rNumController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  selectVehicleType(BuildContext context) {
    Utils.showBottomSelection(
        context: context,
        selections: listVehicles,
        onSelection: (index) {
          vTypeController.text = listVehicles[index].title;
          for (var i = 0; i < listVehicles.length; i++) {
            if (i == index) {
              listVehicles[i].isSelected = true;
            } else {
              listVehicles[i].isSelected = false;
            }
          }
        });
  }

  selectMember(BuildContext context) {
    Utils.showBottomSelection(
        context: context,
        selections: listResidents,
        onSelection: (index) {
          memberController.text = listResidents[index].title;
          for (var i = 0; i < listResidents.length; i++) {
            if (i == index) {
              listResidents[i].isSelected = true;
            } else {
              listResidents[i].isSelected = false;
            }
          }
        });
  }

  onChangeOwnerOfV(bool? v) {
    isOwner = v ?? false;
    notifyListeners();
  }

  onSelectImageVehicle(BuildContext context) async {
    await Utils.selectImage(context, true).then((value) {
      if (value != null) {
        final list = value.map<File>((e) => File(e.path)).toList();
        images.addAll(list);
        notifyListeners();
      }
    });
  }

  onRemoveImageV(int index) {
    images.removeAt(index);
    notifyListeners();
  }
}
