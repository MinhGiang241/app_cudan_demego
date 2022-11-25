import 'dart:io';

import 'package:app_cudan/services/api_transportation.dart';
import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../../../models/transportation_card.dart';
import '../../../../services/api_auth.dart';
import '../../../../utils/utils.dart';
import '../../../../models/selection_model.dart';
import '../../../../utils/utils.dart';
import '../transport_card_list_screen.dart';

class RegisterTransportationCardPrv extends ChangeNotifier {
  RegisterTransportationCardPrv({
    this.apartmentId,
    this.residentId,
    this.vehicleType,
    this.id,
    this.imageUrlBack,
    this.imageUrlFront,
    this.otherExistedImages,
  });
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
  String? residentId;
  String? id;

  String? imageUrlFront;
  List<File> imageFileFront = [];
  String? imageUrlBack;
  List<File> imageFileBack = [];
  String? imageUrlRelated;
  List<OtherImage>? otherExistedImages = [];
  List<OtherImage> otherImages = [];

  String? validateApartment;
  String? validateVehicleType;
  String? validateLiceneNum;
  String? validateRegNum;
  String? vehicleType;
  String? liceneNum;
  String? regNum;

  onSelectBackPhoto(BuildContext context) async {
    await Utils.selectImage(context, false).then((value) {
      if (value != null) {
        final list = value.map<File>((e) => File(e.path)).toList();
        imageFileBack.addAll(list);

        notifyListeners();
      }
    });
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

  removeImageTwoSide(BuildContext context, bool isFrnt) {
    if (isFrnt) {
      imageUrlFront = null;
    } else {
      imageUrlBack = null;
    }

    notifyListeners();
  }

  getTransportationType(BuildContext context) async {
    await APITrans.getTransportationType().then(
      (value) {
        transTypeList.clear();
        if (value != null) {
          value.forEach((e) {
            transTypeList.add(VehicleType.fromJson(e));
          });
        }
        if (transTypeList.isNotEmpty && vehicleType == null) {
          vehicleType = transTypeList[0].id;
        }
      },
    ).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }

  onAddNewTransCard(BuildContext context, bool isRequest) {
    if (formKey.currentState!.validate()) {
      uploadFrontPhoto(context).then((v) {
        return uploadBackPhoto(context);
      }).then((v) {
        return uploadRelatedImage(context);
      }).then((_) {
        otherExistedImages ??= [];

        var listOther = otherExistedImages! + otherImages;
        var newCard = TransportationCard(
            id: id,
            apartmentId: apartmentId,
            other_image: listOther,
            vehicleTypeId: vehicleType,
            registration_image_back: imageUrlBack,
            registration_image_front: imageUrlFront,
            residentId: residentId,
            number_plate: liceneController.text.trim(),
            registration_number: regNumController.text.trim(),
            ticket_status: isRequest ? "WAIT" : "NEW");
        var data = newCard.toJson();
        // print(data2);
        if (isRequest && newCard.registration_image_front == null) {
          throw (S.of(context).not_empty_trans_front);
        }
        if (isRequest && newCard.registration_image_back == null) {
          throw (S.of(context).not_empty_trans_back);
        }
        return APITrans.saveTransportationCard(data);
      }).then((v) {
        Utils.showSuccessMessage(
            context: context,
            e: id != null
                ? S.of(context).success_edit
                : isRequest
                    ? S.of(context).success_send_req
                    : S.of(context).success_cr_new,
            onClose: () {
              // var count = 0;
              Navigator.pushReplacementNamed(
                  context, TransportationCardListScreen.routeName);
            });
      }).catchError((e) {
        Utils.showErrorMessage(context, e.toString());
      });
    } else {
      isLoading = false;
      if (liceneController.text.trim().isEmpty) {
        validateLiceneNum = S.current.not_blank;
      } else {
        validateLiceneNum = null;
      }
      if (regNumController.text.trim().isEmpty) {
        validateRegNum = S.current.not_blank;
      } else {
        validateRegNum = null;
      }
      notifyListeners();
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
      // Utils.showErrorMessage(context, e);
    });
  }

  uploadBackPhoto(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    await APIAuth.uploadSingleFile(files: imageFileBack, context: context)
        .then((v) {
      isLoading = false;
      notifyListeners();
      if (v.isNotEmpty) {
        imageUrlBack = v[0].data;
      }
    }).catchError((e) {
      isLoading = false;
      notifyListeners();
      throw (e);
      // Utils.showErrorMessage(context, e);
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
      throw (e);
      // Utils.showErrorMessage(context, e);
    });
  }

  uploadRelatedImage(BuildContext context) async {
    isLoading = true;
    otherImages = [];
    notifyListeners();
    await APIAuth.uploadSingleFile(files: imagesRelated, context: context)
        .then((v) {
      isLoading = false;
      notifyListeners();
      if (v.isNotEmpty) {
        for (var element in v) {
          // otherImages.add({"file": element.data, 'name': element.data});
          otherImages.add(OtherImage(id: element.data, name: element.data));
        }
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

  onRemoveFront(int index) {
    // imagesVehicle.removeAt(index);
    imageFileFront.clear();
    imageUrlFront = null;
    notifyListeners();
  }

  onRemoveBack(int index) {
    // imagesVehicle.removeAt(index);
    imageFileBack.clear();
    imageUrlBack = null;
    notifyListeners();
  }

  onRemoveImageR(int index) {
    imagesRelated.removeAt(index);
    notifyListeners();
  }

  onRemoveExist(int index) {
    otherExistedImages!.removeAt(index);
    notifyListeners();
  }
}
