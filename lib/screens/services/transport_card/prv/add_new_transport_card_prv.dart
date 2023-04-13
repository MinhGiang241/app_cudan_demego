import 'dart:io';

import 'package:app_cudan/models/file_upload.dart';
import 'package:app_cudan/models/manage_card.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/screens/services/resident_card/prv/resident_card_prv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../../../../models/transportation_card.dart';
import '../../../../services/api_auth.dart';
import '../../../../services/api_transport.dart';
import '../../../../utils/utils.dart';
import '../transport_card_screen.dart.dart';

class AddNewTransportCardPrv extends ChangeNotifier {
  int activeStep = 0;
  final PageController pageController = PageController();
  bool isDisableCroll = true;
  bool isAddNewLoading = false;
  bool isSendApproveLoading = false;
  bool isAddTransLoading = false;
  bool isIntergate = false;
  bool isObey = false;
  bool autoValid = false;
  bool isShowLicense = true;
  final formKey = GlobalKey<FormState>();

  final TextEditingController liceneController = TextEditingController();
  final TextEditingController seatNumController = TextEditingController();
  final TextEditingController regNumController = TextEditingController();

  String? validateLicene;
  String? validateSeat;
  String? validateTrans;
  String? validateReg;
  String? validateExpire;

  String? transTypeValue;
  String? expiredValue;

  List<File> imageFileFront = [];
  List<File> imageFileBack = [];
  List<File> otherImages = [];
  List<FileUploadModel> otherExistedImages = [];
  List<FileUploadModel> frontExistedImages = [];
  List<FileUploadModel> backExistedImages = [];
  List<FileUploadModel> otherUploadedImages = [];
  List<FileUploadModel> frontUploadedImages = [];
  List<FileUploadModel> backUploadedImages = [];

  List<VehicleType> transTypeList = [];
  List<ShelfLife> shelfLifeList = [];

  List<TransportItem> transportList = [];

  onPageChanged(v) {
    activeStep = v;
    notifyListeners();
  }

  Future getInitData(BuildContext context) async {
    await getShelfLife();
    await getTransportType();
  }

  Future getShelfLife() async {
    await APITransport.getShelfLife().then((v) {
      shelfLifeList.clear();
      if (v != null) {
        v.forEach((e) {
          shelfLifeList.add(ShelfLife.fromMap(e));
        });
      }
    });
  }

  Future getTransportType() async {
    await APITransport.getTransportationType().then((v) {
      transTypeList.clear();
      if (v != null) {
        v.forEach((e) {
          transTypeList.add(VehicleType.fromJson(e));
        });
      }
    });
  }

  removeItemTrans(int index) {
    transportList.removeAt(index);
    notifyListeners();
  }

  addTransport() {
    isDisableCroll = false;
    notifyListeners();
    pageController
        .animateToPage(
      ++activeStep,
      duration: const Duration(milliseconds: 250),
      curve: Curves.bounceInOut,
    )
        .then((v) {
      isDisableCroll = true;
      notifyListeners();
    });
  }

  backStepScreen() {
    isDisableCroll = false;
    notifyListeners();
    pageController
        .animateToPage(
      --activeStep,
      duration: const Duration(milliseconds: 250),
      curve: Curves.bounceInOut,
    )
        .then((v) {
      isDisableCroll = true;
      notifyListeners();
    });
  }

  toggleObey(v) {
    isObey = !isObey;
    notifyListeners();
  }

  toggleIntergate(v) {
    isIntergate = !isIntergate;
    notifyListeners();
  }

  onChangeVehicleType(v) {
    if (v != null) {
      validateTrans = null;
      transTypeValue = v;
      notifyListeners();
    }
    if (v == 'BICYCLE') {
      isShowLicense = false;
      notifyListeners();
    } else {
      isShowLicense = true;
      notifyListeners();
    }
  }

  onChangeExpire(v) {
    if (v != null) {
      expiredValue = v;
      validateExpire = null;
      notifyListeners();
    }
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

  onSelectBackPhoto(BuildContext context) async {
    await Utils.selectImage(context, false).then((value) {
      if (value != null) {
        final list = value.map<File>((e) => File(e.path)).toList();
        imageFileBack.addAll(list);

        notifyListeners();
      }
    });
  }

  onSelectOtherPhoto(BuildContext context) async {
    await Utils.selectImage(context, false).then((value) {
      if (value != null) {
        final list = value.map<File>((e) => File(e.path)).toList();
        otherImages.addAll(list);

        notifyListeners();
      }
    });
  }

  onRemoveFront(int index) {
    imageFileFront.removeAt(index);
    notifyListeners();
  }

  onRemoveBack(int index) {
    imageFileBack.removeAt(index);
    notifyListeners();
  }

  onRemoveOther(int index) {
    otherImages.removeAt(index);
    notifyListeners();
  }

  onRemoveExistFront(int index) {
    frontExistedImages.removeAt(index);
    notifyListeners();
  }

  onRemoveExistBack(int index) {
    backExistedImages.removeAt(index);
    notifyListeners();
  }

  onRemoveExistOther(int index) {
    otherExistedImages.removeAt(index);
    notifyListeners();
  }

  Future uploadFront() async {
    await APIAuth.uploadSingleFile(
      files: imageFileFront,
    ).then((v) {
      if (v.isNotEmpty) {
        for (var e in v) {
          frontUploadedImages.add(
            FileUploadModel(id: e.data, name: e.name),
          );
        }
      }
    }).catchError((e) {
      throw (e);
    });
  }

  Future uploadOther() async {
    await APIAuth.uploadSingleFile(
      files: otherImages,
    ).then((v) {
      if (v.isNotEmpty) {
        for (var e in v) {
          otherUploadedImages.add(
            FileUploadModel(id: e.data, name: e.name),
          );
        }
      }
    }).catchError((e) {
      throw (e);
    });
  }

  Future uploadBack() async {
    await APIAuth.uploadSingleFile(
      files: imageFileBack,
    ).then((v) {
      if (v.isNotEmpty) {
        for (var e in v) {
          backUploadedImages.add(
            FileUploadModel(id: e.data, name: e.name),
          );
        }
      }
    }).catchError((e) {
      throw (e);
    });
  }

  clearAddForm() {
    // formKey.currentState.initState();
    validateLicene = null;
    validateReg = null;
    validateSeat = null;
    validateLicene = null;
    validateExpire = null;

    transTypeValue = null;
    expiredValue = null;

    regNumController.clear();
    seatNumController.clear();
    liceneController.clear();
    isShowLicense = true;
    notifyListeners();
  }

  genValidString() {
    if (regNumController.text.trim().isEmpty) {
      validateReg = S.current.not_blank;
    } else {
      validateReg = null;
    }
    if (seatNumController.text.trim().isEmpty) {
      validateSeat = S.current.not_blank;
    } else {
      validateSeat = null;
    }
    if (expiredValue == null) {
      validateExpire = S.current.not_blank;
    } else {
      validateExpire = null;
    }
    if (transTypeValue == null) {
      validateTrans = S.current.not_blank;
    } else {
      validateTrans = null;
    }
    if (liceneController.text.trim().isEmpty) {
      validateLicene = S.current.not_blank;
    } else {
      validateLicene = null;
    }
    notifyListeners();
  }

  onAddTransport(BuildContext context) async {
    try {
      var residentId = context.read<ResidentInfoPrv>().residentId;
      var apartmentId =
          context.read<ResidentInfoPrv>().selectedApartment?.apartmentId;

      await uploadFront();
      await uploadBack();
      await uploadOther();
      autoValid = true;
      isAddTransLoading = true;
      notifyListeners();

      if (formKey.currentState!.validate()) {
        genValidString();
        var vehicleTypeId = transTypeList
            .firstWhere((element) => element.code == transTypeValue)
            .id;
        TransportItem transportItem = TransportItem(
          residentId: residentId,
          apartmentId: apartmentId,
          number_plate: liceneController.text.trim(),
          shelfLifeId: expiredValue,
          vehicleTypeId: vehicleTypeId,
          registration_number: regNumController.text.trim(),
          registration_image: frontUploadedImages +
              frontExistedImages +
              backUploadedImages +
              backUploadedImages,
          registration_image_front: frontUploadedImages + frontExistedImages,
          registration_image_back: backUploadedImages + backUploadedImages,
          seats: int.parse(seatNumController.text.trim()),
        );

        transportList.add(transportItem);
        notifyListeners();
      } else {
        genValidString();
      }
      autoValid = false;
      isAddTransLoading = false;
      clearAddForm();
      backStepScreen();
    } catch (e) {
      autoValid = false;
      isAddTransLoading = false;
      notifyListeners();
      Utils.showErrorMessage(context, e.toString());
    }
  }

  onSendSubmit(BuildContext context, bool isSend) async {
    var apartmentId =
        context.read<ResidentInfoPrv>().selectedApartment?.apartmentId;
    var residentId = context.read<ResidentInfoPrv>().residentId;
    var residentInfo = context.read<ResidentInfoPrv>().userInfo;
    isSend ? isSendApproveLoading = true : isAddNewLoading = true;
    notifyListeners();
    try {
      TransportCard letter = TransportCard(
        apartmentId: apartmentId,
        residentId: residentId,
        phone_number: residentInfo?.account?.phone_number,
        confirmation: isObey,
        integrated: isIntergate,
        isMobile: true,
        name_resident: residentInfo?.info_name,
        ticket_status: isSend ? "WAIT" : "NEW",
        transports_list: transportList,
        name: residentInfo?.account?.fullName,
      );

      await APITransport.saveTransportLetter(letter.toMap()).then((v) {
        isSend ? isSendApproveLoading = true : isAddNewLoading = true;
        notifyListeners();
        Utils.showSuccessMessage(
          context: context,
          e: isSend
              ? S.of(context).success_send_letter
              : S.of(context).success_cr_new,
          onClose: () => Navigator.pushNamedAndRemoveUntil(
            context,
            TransportCardScreen.routeName,
            (route) => route.isFirst,
          ),
        );
      });
    } catch (e) {
      Utils.showErrorMessage(context, e.toString());
      isSend ? isSendApproveLoading = true : isAddNewLoading = true;
      notifyListeners();
    }
  }
}
