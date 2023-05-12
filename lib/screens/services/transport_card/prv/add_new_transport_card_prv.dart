// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:app_cudan/constants/regex_text.dart';
import 'package:app_cudan/models/file_upload.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../../../../models/transportation_card.dart';
import '../../../../services/api_auth.dart';
import '../../../../services/api_rules.dart';
import '../../../../services/api_transport.dart';
import '../../../../utils/utils.dart';
import '../transport_card_screen.dart.dart';

class AddNewTransportCardPrv extends ChangeNotifier {
  AddNewTransportCardPrv({this.existedTransport}) {
    if (existedTransport != null) {
      id = existedTransport?.id;
      isIntergate = existedTransport?.integrated ?? false;
      isObey = existedTransport?.confirmation ?? true;
      transportList = existedTransport?.transports_list ?? [];
      code = existedTransport?.code;
      cAddressController.text = existedTransport?.address ?? '';
      cIdentityController.text = existedTransport?.identity ?? "";
    }
  }
  int activeStep = 0;
  final PageController pageController = PageController();
  bool isDisableCroll = true;
  bool isAddNewLoading = false;
  bool isSendApproveLoading = false;
  bool isAddTransLoading = false;
  bool isIntergate = false;
  bool isObey = true;
  bool autoValid = false;
  bool autoValidCustomer = false;
  bool isShowLicense = true;
  final formKey = GlobalKey<FormState>();
  final formKeyCustomer = GlobalKey<FormState>();
  List<FileUploadModel> rulesFiles = [];
  TransportCard? existedTransport;
  String? id;
  String? code;

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

  List<File> cusIdentity = [];
  List<FileUploadModel> cusExistedIdentity = [];
  List<FileUploadModel> cusUploadedIdentity = [];

  List<VehicleType> transTypeList = [];
  List<ShelfLife> shelfLifeList = [];

  List<TransportItem> transportList = [];
  TransportItem? itemEdit;
  int? indexEdit;

  final TextEditingController cAddressController = TextEditingController();
  final TextEditingController cIdentityController = TextEditingController();
  final TextEditingController cPhoneController = TextEditingController();

  String? cValidateAddress;
  String? cValidateIdentity;
  String? cValidatePhone;

  genCValidate() {
    if (cAddressController.text.trim().isEmpty) {
      cValidateAddress = S.current.not_blank;
    } else {
      cValidateAddress = null;
    }
    if (cIdentityController.text.trim().isEmpty) {
      cValidateIdentity = S.current.not_blank;
    } else if (cIdentityController.text.trim().length < 9) {
      cValidateIdentity = S.current.cmnd_length_9;
    } else {
      cValidateIdentity = null;
    }
    if (cPhoneController.text.trim().isEmpty) {
      cValidatePhone = S.current.not_blank;
    } else {
      cValidatePhone = null;
    }
    notifyListeners();
  }

  clearCValidate() {
    cValidateAddress = null;
    cValidateIdentity = null;
    cValidatePhone = null;

    notifyListeners();
  }

  getRuleFiles() async {
    await APIRule.getListRulesFiles('transportcard').then((v) {
      if (v != null) {
        rulesFiles.clear();
        for (var i in v) {
          rulesFiles.add(FileUploadModel.fromMap(i));
        }
        rulesFiles.sort(
          (a, b) => a.id!.compareTo(b.id!),
        );
      }
    });
  }

  genExpireDate() {
    DateTime expireDate;
    DateTime now = DateTime.now();
    var shelf =
        shelfLifeList.firstWhere((element) => element.id == expiredValue);

    if (shelf.type_time?.toLowerCase() == 'tháng') {
      expireDate = DateTime(
        now.year,
        now.month + (shelf.use_time ?? 0),
        now.day,
      );
    } else if (shelf.type_time?.toLowerCase() == 'năm') {
      expireDate = DateTime(
        now.year + (shelf.use_time ?? 0),
        now.month,
        now.day,
      );
    } else if (shelf.type_time?.toLowerCase() == 'ngày') {
      expireDate = DateTime(
        now.year,
        now.month,
        now.day + (shelf.use_time ?? 0),
      );
    } else {
      expireDate = now;
    }
    var text = expireDate.toIso8601String();

    return text;
  }

  formValidation() {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      clearValidStringStep();
    } else {
      genValidString();
    }
  }

  formValidationCustomer() {
    if (formKeyCustomer.currentState != null &&
        (formKey.currentState?.validate() ?? false)) {
      clearCValidate();
    } else {
      genCValidate();
    }
    notifyListeners();
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
    cusExistedIdentity = List<FileUploadModel>.from(item.identity_image ?? []);
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
    } else if (RegexText.onlyZero(seatNumController.text.trim())) {
      return '';
    }
    return null;
  }

  String? regValidate(String? v) {
    if (regNumController.text.trim().isEmpty) {
      return '';
    } else if (RegexText.onlyZero(regNumController.text.trim())) {
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

  onChangedIdentity(String? v) {
    if (v != null) {
      cIdentityController.text = Utils.replaceInputVietChar(v).toUpperCase();

      cIdentityController.selection =
          TextSelection.collapsed(offset: cIdentityController.text.length);
    }
  }

  onPageChanged(v) {
    activeStep = v;
    notifyListeners();
  }

  Future getInitData(BuildContext context) async {
    await getShelfLife().then((v) {
      return getTransportType();
    }).then((v) {
      return getRuleFiles();
    });
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

  onSelectCusIdentityPhoto(BuildContext context) async {
    await Utils.selectImage(context, false).then((value) {
      if (value != null) {
        final list = value.map<File>((e) => File(e.path)).toList();
        cusIdentity.addAll(list);

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

  onRemoveExistedCusIdentity(int index) {
    cusExistedIdentity.removeAt(index);
    notifyListeners();
  }

  onRemoveCusIdentity(int index) {
    cusIdentity.removeAt(index);
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

  Future uploadCusIdentity() async {
    await APIAuth.uploadSingleFile(
      files: cusIdentity,
    ).then((v) {
      if (v.isNotEmpty) {
        for (var e in v) {
          cusUploadedIdentity.add(
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
    imageFileRes.clear();
    resUploadedImages.clear();
    cusExistedIdentity.clear();
    cusUploadedIdentity.clear();
    cusIdentity.clear();
    formKey.currentState!.reset();

    regNumController.clear();
    seatNumController.clear();
    liceneController.clear();
    notifyListeners();
  }

  genValidString() {
    if (regNumController.text.trim().isEmpty) {
      validateReg = S.current.not_blank;
    } else if (RegexText.onlyZero(regNumController.text.trim())) {
      validateReg = S.current.not_zero;
    } else {
      validateReg = null;
    }
    if (seatNumController.text.trim().isEmpty) {
      validateSeat = S.current.not_blank;
    } else if (int.tryParse(seatNumController.text.trim()) != null &&
        int.parse(seatNumController.text.trim()) == 0) {
      validateSeat = S.current.num_seat_not_zero;
    } else if (RegexText.onlyZero(seatNumController.text.trim())) {
      validateSeat = S.current.not_zero;
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
    var isResident = context.read<ResidentInfoPrv>().residentId != null &&
        context.read<ResidentInfoPrv>().selectedApartment != null;
    try {
      var residentId = context.read<ResidentInfoPrv>().residentId;
      var apartmentId =
          context.read<ResidentInfoPrv>().selectedApartment?.apartmentId;

      if (formKey.currentState!.validate()) {
        clearValidStringStep();

        var listError = [];
        var vehicleImages = otherExistedImages + otherUploadedImages;
        var regImages = resExistedImages + resUploadedImages;
        var cusImages = cusExistedIdentity + cusUploadedIdentity;
        if (regImages.length < 2 && transTypeValue != "BICYCLE") {
          listError.add(S.of(context).reg_images_not_empty);
        }
        if (cusImages.length < 2 && !isResident) {
          listError.add(S.of(context).cmnd_images_not_less_2);
        }
        if (vehicleImages.isEmpty) {
          listError.add(S.of(context).trans_images_not_empty);
        }

        if (listError.isNotEmpty) {
          var textError = listError.join('. ');
          throw (textError);
        }
        await uploadResImages();
        await uploadOther();
        await uploadCusIdentity();

        var vehicleTypeId = transTypeList
            .firstWhere((element) => element.code == transTypeValue)
            .id;
        // var shelf =
        //     shelfLifeList.firstWhere((element) => element.id == expiredValue);

        TransportItem transportItem = TransportItem(
          expire_date: genExpireDate(),
          residentId: residentId,
          apartmentId: apartmentId,
          number_plate: liceneController.text.trim(),
          shelfLifeId: expiredValue,
          vehicleTypeId: vehicleTypeId,
          registration_number: regNumController.text.trim(),
          registration_image: resExistedImages + resUploadedImages,
          seats: int.tryParse(seatNumController.text.trim()) != null
              ? int.parse(seatNumController.text.trim())
              : null,
          vehicle_image: otherExistedImages + otherUploadedImages,
          identity_image: cusExistedIdentity + cusUploadedIdentity,
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
      cusUploadedIdentity.clear();
      resUploadedImages.clear();
      otherUploadedImages.clear();
      notifyListeners();
      Utils.showErrorMessage(context, e.toString());
    }
  }

  onSendSubmit(BuildContext context, bool isSend, bool isEdit) async {
    var apartment = context.read<ResidentInfoPrv>().selectedApartment;
    var residentId = context.read<ResidentInfoPrv>().residentId;
    var residentInfo = context.read<ResidentInfoPrv>().userInfo;
    isSend ? isSendApproveLoading = true : isAddNewLoading = true;
    autoValidCustomer = true;
    notifyListeners();
    try {
      if (formKeyCustomer.currentState != null &&
          (formKeyCustomer.currentState?.validate() ?? false)) {
        clearCValidate();

        TransportCard letter = TransportCard(
          address_apartment:
              "${apartment?.apartment?.name ?? ""}-${apartment?.floor?.name}-${apartment?.building?.name}",
          id: id,
          code: code,
          apartmentId: apartment?.apartmentId,
          residentId: residentId,
          phone_number: residentId != null
              ? residentInfo?.phone_required
              : residentInfo?.account?.phone_number ??
                  residentInfo?.account?.userName,
          confirmation: isObey,
          integrated: isIntergate,
          isMobile: true,
          name_resident: residentInfo?.info_name,
          ticket_status: isSend ? "WAIT" : "NEW",
          transports_list: transportList,
          card_type: residentId != null ? "RESIDENT" : "CUSTOMER",
          name: residentInfo?.info_name ?? residentInfo?.account?.fullName,
          registration_date: existedTransport?.registration_date ??
              DateTime.now()
                  .subtract(const Duration(hours: 7))
                  .toIso8601String(),
          identity: residentId == null
              ? cIdentityController.text.trim()
              : residentInfo?.identity_card_required,
          address: residentId != null
              ? "${apartment?.apartment?.name ?? ""}-${apartment?.floor?.name}-${apartment?.building?.name}"
              : cAddressController.text.trim(),
        );

        await APITransport.saveTransportLetter(
          letter.toMap(),
          false,
          id != null,
        ).then((v) {
          isSend ? isSendApproveLoading = false : isAddNewLoading = false;
          notifyListeners();
          Utils.showSuccessMessage(
            context: context,
            e: isSend
                ? S.of(context).success_send_letter
                : isEdit
                    ? S.of(context).success_update
                    : S.of(context).success_cr_new,
            onClose: () => Navigator.pushNamedAndRemoveUntil(
              context,
              TransportCardScreen.routeName,
              (route) => route.isFirst,
              arguments: 1,
            ),
          );
        });
      } else {
        isSend ? isSendApproveLoading = false : isAddNewLoading = false;
        genCValidate();
      }
    } catch (e) {
      Utils.showErrorMessage(context, e.toString());
      isSend ? isSendApproveLoading = false : isAddNewLoading = false;
      notifyListeners();
    }
  }
}
