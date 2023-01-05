import 'dart:io';

import 'package:app_cudan/constants/regex_text.dart';
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
    this.code,
    this.isShowLicense = true,
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
  bool isAddNewLoading = false;
  bool isSendApproveLoading = false;
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
  String? code;

  String? imageUrlFront;
  List<File> imageFileFront = [];
  String? imageUrlBack;
  List<File> imageFileBack = [];
  String? imageUrlRelated;
  List<OtherImage>? otherExistedImages = [];
  List<OtherImage> otherImages = [];
  bool isShowLicense = true;

  String? validateApartment;
  String? validateVehicleType;
  String? validateLiceneNum;
  String? validateRegNum;
  String? vehicleType;
  String? liceneNum;
  String? regNum;
  bool autoVaid = false;

  validate(BuildContext context) {
    if (formKey.currentState!.validate()) {
      validateApartment = null;
      validateVehicleType = null;
      validateLiceneNum = null;
      validateRegNum = null;
    } else {
      if (liceneController.text.trim().isEmpty) {
        validateLiceneNum =
            "${S.current.licene_plate} ${S.current.not_blank.toLowerCase()}";
      } else if (RegexText.vietNameseChar(liceneController.text.trim())) {
        validateLiceneNum =
            "${S.current.licene_plate} ${S.current.not_vietnamese.toLowerCase()}";
      } else if (RegexText.requiredSpecialChar(liceneController.text.trim())) {
        validateLiceneNum =
            "${S.current.licene_plate} ${S.current.not_special_char.toLowerCase()}";
      } else {
        validateLiceneNum = null;
      }
      if (regNumController.text.trim().isEmpty) {
        validateRegNum =
            '${S.current.reg_num} ${S.current.not_blank.toLowerCase()}';
      } else {
        validateRegNum = null;
      }
    }

    notifyListeners();
  }

  onChangevehicleType(v) {
    vehicleType = v;
    try {
      var bike = transTypeList.firstWhere((e) => e.code == 'BICYCLE');
      if (v == bike.id) {
        isShowLicense = false;
        notifyListeners();
      } else {
        isShowLicense = true;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  onSelectApartment(String id) {
    apartmentId = id;
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
        // if (transTypeList.isNotEmpty && vehicleType == null) {
        //   vehicleType = transTypeList[0].id;
        // }
      },
    ).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }

  onAddNewTransCard(BuildContext context, bool isRequest) {
    autoVaid = true;

    if (formKey.currentState!.validate() || !isShowLicense) {
      if (isRequest) {
        isSendApproveLoading = true;
      } else {
        isAddNewLoading = true;
      }
      notifyListeners();
      try {
        var listError = [];

        if (isShowLicense && imageUrlFront == null && imageFileFront.isEmpty) {
          listError.add(S.of(context).resgiter_vehicle_front_image_not_empty);
        }
        if (isShowLicense && imageUrlBack == null && imageFileBack.isEmpty) {
          listError.add(S.of(context).resgiter_vehicle_back_image_not_empty);
        }

        if (vehicleType == null) {
          listError.add(S.of(context).not_empty_vehicle_type);
        }

        if (listError.isNotEmpty) {
          throw (listError.join(', '));
        }

        uploadFrontPhoto(context).then((v) {
          return uploadBackPhoto(context);
        }).then((v) {
          return uploadRelatedImage(context);
        }).then((_) {
          otherExistedImages ??= [];

          var type =
              transTypeList.firstWhere((element) => element.id == vehicleType);

          var listOther = otherExistedImages! + otherImages;
          var newCard = TransportationCard(
              isMobile: true,
              type: type.code,
              code: code,
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

          // if (isRequest && newCard.registration_image_back == null) {
          //   throw (S.of(context).not_empty_back);
          // }
          return APITrans.saveTransportationCard(data);
        }).then((v) async {
          await Utils.showSuccessMessage(
              context: context,
              e: isRequest
                  ? S.of(context).success_send_req
                  : id != null
                      ? S.of(context).success_edit
                      : S.of(context).success_cr_new,
              onClose: () {
                // var count = 0;
                Navigator.pushNamedAndRemoveUntil(
                    context,
                    TransportationCardListScreen.routeName,
                    (route) => route.isFirst,
                    arguments: 1);
              });

          isSendApproveLoading = false;

          isAddNewLoading = false;

          notifyListeners();
        }).catchError((e) {
          Utils.showErrorMessage(context, e.toString());

          isSendApproveLoading = false;

          isAddNewLoading = false;

          notifyListeners();
        });
      } catch (e) {
        validateApartment = null;
        validateVehicleType = null;
        validateLiceneNum = null;
        validateRegNum = null;
        Utils.showErrorMessage(context, e.toString());
        isSendApproveLoading = false;
        isAddNewLoading = false;
        notifyListeners();
      }
    } else {
      isSendApproveLoading = false;
      isAddNewLoading = false;
      if (liceneController.text.trim().isEmpty) {
        validateLiceneNum =
            "${S.current.licene_plate} ${S.current.not_blank.toLowerCase()}";
      } else if (RegexText.vietNameseChar(liceneController.text.trim())) {
        validateLiceneNum =
            "${S.current.licene_plate} ${S.current.not_vietnamese.toLowerCase()}";
      } else if (RegexText.requiredSpecialChar(liceneController.text.trim())) {
        validateLiceneNum =
            "${S.current.licene_plate} ${S.current.not_special_char.toLowerCase()}";
      } else {
        validateLiceneNum = null;
      }
      if (regNumController.text.trim().isEmpty) {
        validateRegNum =
            '${S.current.reg_num} ${S.current.not_blank.toLowerCase()}';
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
    notifyListeners();
    await APIAuth.uploadSingleFile(files: imageFileFront, context: context)
        .then((v) {
      if (v.isNotEmpty) {
        imageUrlFront = v[0].data;
      }

      notifyListeners();
    }).catchError((e) {
      notifyListeners();
      throw (e);
      // Utils.showErrorMessage(context, e);
    });
  }

  uploadBackPhoto(BuildContext context) async {
    notifyListeners();
    await APIAuth.uploadSingleFile(files: imageFileBack, context: context)
        .then((v) {
      notifyListeners();
      if (v.isNotEmpty) {
        imageUrlBack = v[0].data;
      }
    }).catchError((e) {
      notifyListeners();
      throw (e);
      // Utils.showErrorMessage(context, e);
    });
  }

  uploadVehicleImage(BuildContext context) async {
    await APIAuth.uploadSingleFile(files: imagesVehicle, context: context)
        .then((v) {
      if (v.length == 1) {
        imageUrlFront = v[0].data;
      } else if (v.length == 2) {
        imageUrlFront = v[0].data;
        imageUrlBack = v[1].data;
      }
    }).catchError((e) {
      throw (e);
      // Utils.showErrorMessage(context, e);
    });
  }

  uploadRelatedImage(BuildContext context) async {
    otherImages = [];

    await APIAuth.uploadSingleFile(files: imagesRelated, context: context)
        .then((v) {
      notifyListeners();
      if (v.isNotEmpty) {
        for (var element in v) {
          // otherImages.add({"file": element.data, 'name': element.data});
          otherImages.add(OtherImage(id: element.data, name: element.name));
        }
      }
    }).catchError((e) {
      throw (e);
    });
  }

  onChangeOwnerOfV(bool? v) {
    isOwner = v ?? false;
    notifyListeners();
  }

  onSelectImageVehicle(BuildContext context) async {
    await Utils.selectImage(context, false).then((value) {
      if (value != null) {
        final list = value.map<File>((e) => File(e.path)).toList();
        imagesVehicle.addAll(list);
        notifyListeners();
      }
    });
  }

  onSelectImageRelated(BuildContext context) async {
    await Utils.selectImage(context, false).then((value) {
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
