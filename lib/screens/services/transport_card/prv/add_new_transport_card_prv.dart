// ignore_for_file: use_build_context_synchronously

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
  AddNewTransportCardPrv({this.existedTransport}) {
    if (existedTransport != null) {
      id = existedTransport?.id;
      isIntergate = existedTransport?.integrated ?? false;
      isObey = existedTransport?.confirmation ?? false;
      transportList = existedTransport?.transports_list ?? [];
    }
  }
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

  TransportCard? existedTransport;
  String? id;

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

  List<File> imageFileRes = [];
  List<File> otherImages = [];
  List<FileUploadModel> otherExistedImages = [];
  List<FileUploadModel> resExistedImages = [];
  List<FileUploadModel> otherUploadedImages = [];
  List<FileUploadModel> resUploadedImages = [];

  List<VehicleType> transTypeList = [];
  List<ShelfLife> shelfLifeList = [];

  List<TransportItem> transportList = [];
  TransportItem? itemEdit;
  int? indexEdit;

  formValidation() {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      clearValidStringStep();
    } else {
      genValidString();
    }
  }

  clearValidStringStep() {
    validateLicene = null;
    validateSeat = null;
    validateTrans = null;
    validateReg = null;
    validateExpire = null;
    notifyListeners();
  }

  onTapEditTransport(TransportItem item, int index) {
    itemEdit = item;
    indexEdit = index;
    notifyListeners();
    addTransport();
    transTypeValue = transTypeList
        .firstWhere(
          (i) => i.id == item.vehicleTypeId,
        )
        .code;
    if (transTypeValue == "BICYCLE") {
      isShowLicense = false;
      regNumController.clear();
      liceneController.clear();
      notifyListeners();
    }

    resExistedImages =
        List<FileUploadModel>.from(item.registration_image ?? []);
    otherExistedImages = List<FileUploadModel>.from(item.vehicle_image ?? []);
    seatNumController.text = item.seats != null ? item.seats.toString() : '';
    liceneController.text = item.number_plate ?? '';
    regNumController.text = item.registration_number ?? "";
    expiredValue = item.shelfLifeId;
    notifyListeners();
  }

  String? numSeatValidate(String? v) {
    if (seatNumController.text.trim().isEmpty) {
      return '';
    } else if (int.tryParse(seatNumController.text.trim()) != null &&
        int.parse(seatNumController.text.trim()) == 0) {
      return '';
    }
    return null;
  }

  onChangedLicenseNum(String? v) {
    if (v != null) {
      liceneController.text = Utils.replaceInputVietChar(v).toUpperCase();

      liceneController.selection =
          TextSelection.collapsed(offset: liceneController.text.length);
    }
  }

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
      if (itemEdit == null) {
        clearAddForm();
      }
      clearValidStringStep();
      isDisableCroll = true;
      notifyListeners();
    });
  }

  backStepScreen(BuildContext context) {
    FocusScope.of(context).unfocus();

    clearAddForm();
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

  onSelectResPhoto(BuildContext context) async {
    await Utils.selectImage(context, false).then((value) {
      if (value != null) {
        final list = value.map<File>((e) => File(e.path)).toList();
        imageFileRes.addAll(list);

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

  onRemoveResImage(int index) {
    imageFileRes.removeAt(index);
    notifyListeners();
  }

  onRemoveOther(int index) {
    otherImages.removeAt(index);
    notifyListeners();
  }

  onRemoveExistRes(int index) {
    resExistedImages.removeAt(index);
    notifyListeners();
  }

  onRemoveExistOther(int index) {
    otherExistedImages.removeAt(index);
    notifyListeners();
  }

  Future uploadResImages() async {
    await APIAuth.uploadSingleFile(
      files: imageFileRes,
    ).then((v) {
      if (v.isNotEmpty) {
        for (var e in v) {
          resUploadedImages.add(
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

  clearAddForm() {
    // formKey.currentState.initState();
    validateLicene = null;
    validateReg = null;
    validateSeat = null;
    validateLicene = null;
    validateExpire = null;
    validateTrans = null;

    transTypeValue = null;
    expiredValue = null;

    isShowLicense = true;
    autoValid = false;
    isAddTransLoading = false;

    indexEdit = null;
    itemEdit = null;
    otherExistedImages.clear();
    otherImages.clear();
    otherUploadedImages.clear();
    resExistedImages.clear();
    resUploadedImages.clear();
    imageFileRes.clear();
    formKey.currentState!.reset();

    regNumController.clear();
    seatNumController.clear();
    liceneController.clear();
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
    } else if (int.tryParse(seatNumController.text.trim()) != null &&
        int.parse(seatNumController.text.trim()) == 0) {
      validateSeat = S.current.num_seat_not_zero;
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
    autoValid = true;
    isAddTransLoading = true;
    notifyListeners();

    try {
      var residentId = context.read<ResidentInfoPrv>().residentId;
      var apartmentId =
          context.read<ResidentInfoPrv>().selectedApartment?.apartmentId;

      if (formKey.currentState!.validate()) {
        await uploadResImages();
        await uploadOther();
        clearValidStringStep();
        var vehicleTypeId = transTypeList
            .firstWhere((element) => element.code == transTypeValue)
            .id;
        // var shelf =
        //     shelfLifeList.firstWhere((element) => element.id == expiredValue);

        TransportItem transportItem = TransportItem(
          residentId: residentId,
          apartmentId: apartmentId,
          number_plate: liceneController.text.trim(),
          shelfLifeId: expiredValue,
          vehicleTypeId: vehicleTypeId,
          registration_number: regNumController.text.trim(),
          registration_image:
              resExistedImages + resUploadedImages + otherExistedImages,
          seats: int.parse(seatNumController.text.trim()),
          vehicle_image: otherExistedImages + otherUploadedImages,
        );
        if (indexEdit != null) {
          transportList[indexEdit!] = transportItem;
        } else {
          transportList.add(transportItem);
        }

        autoValid = false;
        isAddTransLoading = false;
        notifyListeners();

        backStepScreen(context);
      } else {
        isAddTransLoading = false;
        notifyListeners();
        genValidString();
      }
    } catch (e) {
      autoValid = false;
      isAddTransLoading = false;
      notifyListeners();
      Utils.showErrorMessage(context, e.toString());
    }
  }

  onSendSubmit(BuildContext context, bool isSend, bool isEdit) async {
    var apartment = context.read<ResidentInfoPrv>().selectedApartment;
    var residentId = context.read<ResidentInfoPrv>().residentId;
    var residentInfo = context.read<ResidentInfoPrv>().userInfo;
    isSend ? isSendApproveLoading = true : isAddNewLoading = true;
    notifyListeners();
    try {
      TransportCard letter = TransportCard(
        address_apartment:
            "${apartment?.apartment?.name ?? ""}-${apartment?.floor?.name}-${apartment?.building?.name}",
        id: id,
        apartmentId: apartment?.apartmentId,
        residentId: residentId,
        phone_number: residentInfo?.account?.phone_number,
        confirmation: isObey,
        integrated: isIntergate,
        isMobile: true,
        name_resident: residentInfo?.info_name,
        ticket_status: isSend ? "WAIT" : "NEW",
        transports_list: transportList,
        card_type: residentId != null ? "RESIDENT" : "CUSTOMER",
        name: residentInfo?.info_name ?? residentInfo?.account?.fullName,
        registration_date: existedTransport?.registration_date ??
            DateTime.now().subtract(const Duration(hours: 7)).toIso8601String(),
        address:
            "${apartment?.apartment?.name ?? ""}-${apartment?.floor?.name}-${apartment?.building?.name}",
      );

      await APITransport.saveTransportLetter(letter.toMap(), false).then((v) {
        isSend ? isSendApproveLoading = false : isAddNewLoading = false;
        notifyListeners();
        Utils.showSuccessMessage(
          context: context,
          e: isSend
              ? S.of(context).success_send_letter
              : isEdit
                  ? S.of(context).success_edit
                  : S.of(context).success_cr_new,
          onClose: () => Navigator.pushNamedAndRemoveUntil(
            context,
            TransportCardScreen.routeName,
            (route) => route.isFirst,
            arguments: 1,
          ),
        );
      });
    } catch (e) {
      Utils.showErrorMessage(context, e.toString());
      isSend ? isSendApproveLoading = false : isAddNewLoading = false;
      notifyListeners();
    }
  }
}
