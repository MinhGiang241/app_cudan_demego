import 'dart:io';

import 'package:app_cudan/services/api_transportation.dart';
import 'package:flutter/material.dart';

import '../../../../models/transportation_card.dart';
import '../../../../services/api_auth.dart';
import '../../../../utils/utils.dart';
import '../../../../models/selection_model.dart';
import '../../../../utils/utils.dart';

class RegisterTransportationCardPrv extends ChangeNotifier {
  RegisterTransportationCardPrv({this.apartmentId});
  final List<SelectionModel> listVehicles = [
    SelectionModel(title: "Xe máy"),
    SelectionModel(title: "Ô tô")
  ];
  final List<SelectionModel> listResidents = [
    SelectionModel(title: "Nguyễn Văn A"),
    SelectionModel(title: "Nguyễn Thị B"),
  ];

  bool isOwner = false;
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  List<VehicleType> transTypeList = [];

  List<File> imagesVehicle = [];
  List<File> imagesRelated = [];

  // final TextEditingController vTypeController = TextEditingController();
  final TextEditingController liceneController = TextEditingController();
  final TextEditingController regNumController = TextEditingController();
  // final TextEditingController lpController = TextEditingController();
  // final TextEditingController colorController = TextEditingController();
  final TextEditingController rNumController = TextEditingController();
  // final TextEditingController noteController = TextEditingController();

  String? apartmentId;

  String? imageUrlFront;
  String? imageUrlBack;
  String? imageUrlRelated;

  String? validateApartment;
  String? validateVehicleType;
  String? validateLiceneNum;
  String? validateRegNum;
  String? vehicleType;
  String? liceneNum;
  String? regNum;

  getTransportationType(BuildContext context) async {
    await APITrans.getTransportationType().then(
      (value) {
        transTypeList.clear();
        if (value != null) {
          value.forEach((e) {
            transTypeList.add(VehicleType.fromJson(e));
          });
        }
      },
    ).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }

  // selectVehicleType(BuildContext context) {
  // Utils.showBottomSelection(
  //     context: context,
  //     selections: listVehicles,
  //     onSelection: (index) {
  //       vTypeController.text = listVehicles[index].title;
  //       for (var i = 0; i < listVehicles.length; i++) {
  //         if (i == index) {
  //           listVehicles[i].isSelected = true;
  //         } else {
  //           listVehicles[i].isSelected = false;
  //         }
  //       }
  //     });
  // }

  onSubmitCreate(BuildContext context) {
    if (formKey.currentState!.validate()) {
      var newCard = TransportationCard(
          // apartmentId:
          );
    }
  }

  selectMember(BuildContext context) {
    Utils.showBottomSelection(
        context: context,
        selections: listResidents,
        onSelection: (index) {
          liceneController.text = listResidents[index].title;
          for (var i = 0; i < listResidents.length; i++) {
            if (i == index) {
              listResidents[i].isSelected = true;
            } else {
              listResidents[i].isSelected = false;
            }
          }
        });
  }

  uploadVehicleImage(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    await APIAuth.uploadSingleFile(files: imagesVehicle, context: context)
        .then((v) {
      isLoading = false;
      notifyListeners();
      if (v.length == 1) {
        imageUrlFront = v[0].data;
      } else if (v.length == 2) {
        imageUrlFront = v[0].data;
        imageUrlBack = v[1].data;
      }
    }).catchError((e) {
      isLoading = false;
      notifyListeners();
      Utils.showErrorMessage(context, e);
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
        imagesVehicle.addAll(list);
        notifyListeners();
      }
    });
  }

  onSelectImageRelated(BuildContext context) async {
    await Utils.selectImage(context, true).then((value) {
      if (value != null) {
        final list = value.map<File>((e) => File(e.path)).toList();
        imagesRelated.addAll(list);
        notifyListeners();
      }
    });
  }

  onRemoveImageV(int index) {
    imagesVehicle.removeAt(index);
    notifyListeners();
  }

  onRemoveImageR(int index) {
    imagesRelated.removeAt(index);
    notifyListeners();
  }
}
