import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../generated/l10n.dart';
import '../../../../models/selection_model.dart';
import '../../../../utils/utils.dart';

class RegisterRCardPrv extends ChangeNotifier {
  final List<SelectionModel> listTypeCard = [
    SelectionModel(title: 'S.current.temporary_residence'),
    SelectionModel(title: 'S.current.resident'),
    SelectionModel(title: 'S.current.temporary_residence_foreign'),
  ];
  final List<SelectionModel> listRelationshipWithOwner = [
    SelectionModel(title: 'S.current.helper'),
    SelectionModel(title: 'S.current.wife'),
    SelectionModel(title: 'S.current.husband'),
    SelectionModel(title: 'S.current.father'),
    SelectionModel(title: 'S.current.mother'),
    SelectionModel(title: 'S.current.father_in_law'),
    SelectionModel(title: ' S.current.mother_in_law'),
    SelectionModel(title: ' S.current.son'),
    SelectionModel(title: 'S.current.daughter'),
    SelectionModel(title: 'S.current.daughter'),
    SelectionModel(title: 'S.current.daughter'),
    SelectionModel(title: 'S.current.daughter'),
    SelectionModel(title: 'S.current.daughter'),
    SelectionModel(title: 'S.current.daughter'),
    SelectionModel(title: 'S.current.daughter'),
    SelectionModel(title: 'S.current.daughter'),
    SelectionModel(title: 'S.current.tenants'),
  ];
  final List<SelectionModel> listGender = [
    SelectionModel(title: S.current.male),
    SelectionModel(title: S.current.female),
    SelectionModel(title: S.current.other_gender),
  ];

  TextEditingController typeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController relationshipController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController idNumController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController emaiOrPhoneController = TextEditingController();

  List<File> listRImage = [];
  List<File> listIDImage = [];
  List<File> listTTImage = [];

  selectType(BuildContext context) {
    Utils.showBottomSelection(
        context: context,
        selections: listTypeCard,
        onSelection: (index) {
          typeController.text = listTypeCard[index].title;
          for (var i = 0; i < listTypeCard.length; i++) {
            if (i == index) {
              listTypeCard[i].isSelected = true;
            } else {
              listTypeCard[i].isSelected = false;
            }
          }
        });
  }

  selectRelationship(BuildContext context) {
    Utils.showBottomSelection(
        context: context,
        selections: listRelationshipWithOwner,
        onSelection: (index) {
          relationshipController.text = listRelationshipWithOwner[index].title;
          for (var i = 0; i < listRelationshipWithOwner.length; i++) {
            if (i == index) {
              listRelationshipWithOwner[i].isSelected = true;
            } else {
              listRelationshipWithOwner[i].isSelected = false;
            }
          }
        });
  }

  selectGender(BuildContext context) {
    Utils.showBottomSelection(
        context: context,
        selections: listGender,
        onSelection: (index) {
          genderController.text = listGender[index].title;
          for (var i = 0; i < listGender.length; i++) {
            if (i == index) {
              listGender[i].isSelected = true;
            } else {
              listGender[i].isSelected = false;
            }
          }
        });
  }

  selectDateOfBirth(BuildContext context) {
    Utils.showDatePickers(context, onChange: (d) {
      final date = DateFormat("dd/MM/yyyy").format(d);
      dateOfBirthController.text = date;
    }, onDone: (d) {
      final date = DateFormat("dd/MM/yyyy").format(d);
      dateOfBirthController.text = date;
    });
  }

  onSelecImageRecident(BuildContext context) async {
    await Utils.selectImage(context, true).then((value) {
      if (value != null) {
        final list = value.map<File>((e) => File(e.path)).toList();
        listRImage.addAll(list);
        notifyListeners();
      }
    });
  }

  onRemoveImageRecident(int index) {
    listRImage.removeAt(index);
    notifyListeners();
  }

  onSelecImageId(BuildContext context) async {
    await Utils.selectImage(context, true).then((value) {
      if (value != null) {
        final list = value.map<File>((e) => File(e.path)).toList();
        listIDImage.addAll(list);
        notifyListeners();
      }
    });
  }

  onRemoveImageId(int index) {
    listIDImage.removeAt(index);
    notifyListeners();
  }

  onSelecImageTT(BuildContext context) async {
    await Utils.selectImage(context, true).then((value) {
      if (value != null) {
        final list = value.map<File>((e) => File(e.path)).toList();
        listTTImage.addAll(list);
        notifyListeners();
      }
    });
  }

  onRemoveImageTT(int index) {
    listTTImage.removeAt(index);
    notifyListeners();
  }
}
