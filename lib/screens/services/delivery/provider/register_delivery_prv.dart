import 'dart:io';

import 'package:app_cudan/constants/constants.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/screens/services/delivery/delivery_list_screen.dart';
import 'package:app_cudan/services/api_delivery.dart';
import 'package:app_cudan/services/api_rules.dart';
import 'package:app_cudan/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/regex_text.dart';
import '../../../../generated/l10n.dart';
import '../../../../models/delivery.dart';
import '../../../../models/file_upload.dart';
import '../../../../services/api_auth.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/primary_button.dart';
import '../../../../widgets/primary_screen.dart';

class RegisterDeliveryPrv extends ChangeNotifier {
  RegisterDeliveryPrv({
    this.id,
    this.code,
    this.helpCheck = false,
    this.useElevator = false,
    this.packageItems = const [],
    this.existedImage = const [],
    this.type = 1,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.delivery,
  }) {
    if (delivery != null) {
      noteController.text = delivery?.note_reason ?? '';
      startDateController.text =
          Utils.dateFormat(delivery!.start_time ?? '', 1);
      endDateController.text = Utils.dateFormat(delivery!.end_time ?? '', 1);
      describleController.text = delivery!.describe ?? '';
      if (delivery!.start_hour != null) {
        startHourController.text = delivery!.start_hour!.substring(0, 5);
      }
      if (delivery!.end_hour != null) {
        endHourController.text = delivery!.end_hour!.substring(0, 5);
      }
    }
  }
  Delivery? delivery;

  final formKey = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  int type = 1;
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  TextEditingController startHourController = TextEditingController();
  TextEditingController endHourController = TextEditingController();
  TextEditingController packageNameController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController dimentionController = TextEditingController();
  TextEditingController longController = TextEditingController();
  TextEditingController widthController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController describleController = TextEditingController();

  final TextEditingController noteController = TextEditingController();
  bool helpCheck = false;
  bool useElevator = false;
  String? id;
  String? code;
  String? validateStartDate;
  String? validateEndDate;
  String? validateType;
  String? validatePackageName;
  String? validateWeight;
  String? validateDimention;
  String? validateLong;
  String? validateWidth;
  String? validateHeight;
  String? validateStartHour;
  String? validateEndHour;

  String? validateQuantity;

  DateTime? startDate;
  DateTime? endDate;
  bool isAddNewLoading = false;
  bool isSendApproveLoading = false;

  TimeOfDay? startTime;
  TimeOfDay? endTime;

  List<File> imagesDelivery = [];
  List<ImageDelivery> existedImage = [];
  List<ItemDeliver> packageItems = [];
  List<ImageDelivery> submitImageDelivery = [];
  bool autoValid = false;
  List<FileUploadModel> rulesFiles = [];
  Future getRule(BuildContext context) async {
    await APIRule.getListRulesFiles("transferitems").then((v) {
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

  validate(BuildContext context) {
    if (formKey.currentState!.validate()) {
      validateStartDate = null;
      validateEndDate = null;
      validateType = null;
      validatePackageName = null;
      validateDimention = null;
      validateLong = null;
      validateWidth = null;
      validateHeight = null;
      validateStartHour = null;
      validateEndHour = null;
    } else {
      if (startDateController.text.isEmpty) {
        validateStartDate = "${S.of(context).date}: ${S.of(context).not_blank}";
      } else {
        validateStartDate = null;
      }
      if (endDateController.text.isEmpty) {
        validateEndDate = "${S.of(context).date}: ${S.of(context).not_blank}";
      } else {
        validateEndDate = null;
      }
      if (startHourController.text.isEmpty) {
        validateStartHour = "${S.of(context).hour}: ${S.of(context).not_blank}";
      } else {
        validateStartHour = null;
      }
      if (endHourController.text.isEmpty) {
        validateEndHour = "${S.of(context).hour}: ${S.of(context).not_blank}";
      } else {
        validateEndHour = null;
      }
    }

    notifyListeners();
  }

  onSendSummitDelivery(BuildContext context, bool isRequest) {
    autoValid = true;
    FocusScope.of(context).unfocus();
    var selectedApartment = context.read<ResidentInfoPrv>().selectedApartment;

    if (formKey.currentState!.validate()) {
      if (isRequest) {
        isSendApproveLoading = true;
      } else {
        isAddNewLoading = true;
      }
      notifyListeners();
      try {
        var listError = [];
        var now = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          0,
        );
        // throw (endDate!.compareTo(startDate!) < 0);
        if (startDate == null) {
          listError.add(S.of(context).start_date_not_empty);
        } else if (startDate!.compareTo(now) < 0) {
          listError.add(S.of(context).start_date_after_now_equal);
        }
        if (endDate == null) {
          listError.add(S.of(context).end_date_not_empty);
        }
        if (startDate != null && endDate != null) {
          if (endDate!.compareTo(startDate!) < 0) {
            listError.add(S.of(context).end_date_after_start_date);
          }
        }

        if (listError.isNotEmpty) {
          throw (listError.join(',  '));
        }
        if (packageItems.isEmpty) {
          throw (S.of(context).package_items_not_empty);
        }

        uploadDeliveryImage(context).then((v) {
          var st = startDate!
              .subtract(const Duration(hours: 0))
              .toUtc()
              .toIso8601String();
          var et =
              endDate!.subtract(const Duration(hours: 0)).toIso8601String();
          var newDelivery = Delivery(
            elevator: useElevator,
            code: code,
            phone_number:
                context.read<ResidentInfoPrv>().userInfo!.phone_required,
            describe: describleController.text.trim(),
            item_added_list: (packageItems.isNotEmpty) ? packageItems : null,
            start_time: st,
            end_time: et,
            start_hour: startHourController.text.isNotEmpty
                ? '${startHourController.text}:00'
                : null,
            end_hour: endHourController.text.isNotEmpty
                ? '${endHourController.text}:00'
                : null,
            id: id,
            isMobile: true,
            help_check: helpCheck,
            image: submitImageDelivery + existedImage,
            residentId: context.read<ResidentInfoPrv>().residentId,
            status: isRequest
                ? (selectedApartment?.type == "BUY" ||
                        selectedApartment?.type == "RENT")
                    ? "WAIT_MANAGER"
                    : "WAIT_OWNER"
                : "NEW",
            type_transfer: type == 1 ? "OUT" : "IN",
            apartmentId:
                context.read<ResidentInfoPrv>().selectedApartment!.apartmentId,
          );

          var data = newDelivery.toJson();
          return APIDelivery.saveNewDelivery(data, id != null);
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
                DeliveryListScreen.routeName,
                (route) => route.isFirst,
              );
            },
          );
          isSendApproveLoading = false;
          isAddNewLoading = false;
          notifyListeners();
        }).catchError((e) {
          submitImageDelivery.clear();
          isSendApproveLoading = false;
          isAddNewLoading = false;
          validateStartDate = null;
          validateEndDate = null;
          validateType = null;
          validatePackageName = null;
          validateDimention = null;
          validateLong = null;
          validateWidth = null;
          validateHeight = null;
          validateStartHour = null;
          validateEndHour = null;
          notifyListeners();
          Utils.showErrorMessage(context, e.toString());
        });
      } catch (e) {
        submitImageDelivery.clear();
        isSendApproveLoading = false;
        isAddNewLoading = false;
        validateStartDate = null;
        validateEndDate = null;
        validateType = null;
        validatePackageName = null;
        validateDimention = null;
        validateLong = null;
        validateWidth = null;
        validateHeight = null;
        validateStartHour = null;
        validateEndHour = null;
        notifyListeners();
        Utils.showErrorMessage(context, e.toString());
      }
    } else {
      if (startDateController.text.isEmpty) {
        validateStartDate = "${S.of(context).date}: ${S.of(context).not_blank}";
      } else {
        validateStartDate = null;
      }
      if (endDateController.text.isEmpty) {
        validateEndDate = "${S.of(context).date}: ${S.of(context).not_blank}";
      } else {
        validateEndDate = null;
      }
      if (startHourController.text.isEmpty) {
        validateStartHour = "${S.of(context).hour}: ${S.of(context).not_blank}";
      } else {
        validateStartHour = null;
      }
      if (endHourController.text.isEmpty) {
        validateEndHour = "${S.of(context).hour}: ${S.of(context).not_blank}";
      } else {
        validateEndHour = null;
      }
      notifyListeners();
    }
  }

  toggleHelpCheck() {
    helpCheck = !helpCheck;
    notifyListeners();
  }

  toggleUseElevator() {
    useElevator = !useElevator;
    notifyListeners();
  }

  uploadDeliveryImage(BuildContext context) async {
    notifyListeners();
    await APIAuth.uploadSingleFile(context: context, files: imagesDelivery)
        .then((v) {
      notifyListeners();
      if (v.isNotEmpty) {
        for (var element in v) {
          submitImageDelivery
              .add(ImageDelivery(id: element.data, name: element.name));
        }
      }
    }).catchError((e) {
      throw (e);
    });
  }

  removeItemPackage(int index) {
    packageItems.removeAt(index);
    notifyListeners();
  }

  onEditPackage(BuildContext context, int index) {
    var newItem = ItemDeliver(
      weight: double.tryParse(weightController.text.trim()) != null
          ? double.parse(weightController.text.trim())
          : 0,
      item_name: packageNameController.text.trim(),
      color: colorController.text.trim(),
      describe: noteController.text.trim(),
      amount: int.tryParse(quantityController.text.trim()) != null
          ? int.parse(quantityController.text.trim())
          : null,
      dimension:
          "${longController.text}x${widthController.text}x${heightController.text}",
    );

    packageItems[index] = newItem;

    weightController.text = '';
    packageNameController.text = '';
    dimentionController.text = '';
    longController.text = '';
    widthController.text = '';
    heightController.text = '';
    quantityController.text = '';
    describleController.text = '';
    noteController.text = '';
    colorController.text = '';
    validateDimention = null;
    validateLong = null;
    validateWidth = null;
    validateHeight = null;
    validateWeight = null;
    validatePackageName = null;
    validateQuantity = null;
    notifyListeners();
  }

  onAddPackage(BuildContext context) {
    packageItems.add(
      ItemDeliver(
        weight: double.tryParse(weightController.text.trim()) != null
            ? double.parse(weightController.text.trim())
            : 0,
        item_name: packageNameController.text.trim(),
        color: colorController.text.trim(),
        describe: noteController.text.trim(),
        amount: int.tryParse(quantityController.text.trim()) != null
            ? int.parse(quantityController.text.trim())
            : null,
        dimension:
            "${longController.text}x${widthController.text}x${heightController.text}",
      ),
    );
    weightController.text = '';
    packageNameController.text = '';
    noteController.text = '';
    dimentionController.text = '';
    longController.text = '';
    widthController.text = '';
    heightController.text = '';
    quantityController.text = '';
    describleController.text = '';
    colorController.text = '';
    validateDimention = null;
    validateLong = null;
    validateWidth = null;
    validateHeight = null;
    validateWeight = null;
    validatePackageName = null;
    validateQuantity = null;
    notifyListeners();
  }

  onRemoveImageDelivery(int index) {
    imagesDelivery.removeAt(index);
    notifyListeners();
  }

  removeExistedImages(int index) {
    existedImage.removeAt(index);
    notifyListeners();
  }
  // List<File> imagesRelated = [];

  onSelectImageDelivery(BuildContext context) async {
    await Utils.selectImage(context, false).then((value) {
      if (value != null) {
        final list = value.map<File>((e) => File(e.path)).toList();
        imagesDelivery.addAll(list);
        notifyListeners();
      }
    });
  }

  pickStartDate(BuildContext context) {
    Utils.showDatePickers(
      context,
      initDate: startDate ?? DateTime.now(),
      startDate: DateTime(DateTime.now().year - 10, 1, 1),
      endDate: DateTime(DateTime.now().year + 10, 1, 1),
    )
        // showDatePicker(
        //   context: context,
        //   initialDate: DateTime.now(),
        //   firstDate: DateTime(DateTime.now().year - 10, 1, 1),
        //   lastDate: DateTime(DateTime.now().year + 10, 1, 1),
        // )
        .then((v) {
      if (v != null) {
        startDate = v;
        startDateController.text =
            Utils.dateFormat(startDate!.toIso8601String(), 0);
        validateStartDate = null;
        notifyListeners();
      }
    });
  }

  pickStartHour(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: startTime ?? const TimeOfDay(hour: 0, minute: 0),
    ).then((v) {
      if (v != null) {
        startTime = v;
        validateStartHour = null;
        var a = v.format(context);
        startHourController.text = a;
        print(startHourController.text);
        notifyListeners();
      }
    });
    notifyListeners();
  }

  pickEndDate(BuildContext context) {
    Utils.showDatePickers(
      context,
      initDate: endDate ?? DateTime.now(),
      startDate: DateTime(DateTime.now().year - 10, 1, 1),
      endDate: DateTime(DateTime.now().year + 10, 1, 1),
    )
        // showDatePicker(
        //   context: context,
        //   initialDate: DateTime.now(),
        //   firstDate: DateTime(DateTime.now().year - 10, 1, 1),
        //   lastDate: DateTime(DateTime.now().year + 10, 1, 1),
        // )
        .then((v) {
      if (v != null) {
        endDateController.text = Utils.dateFormat(v.toIso8601String(), 0);
        endDate = v;
        validateEndDate = null;
        notifyListeners();
      }
    });
  }

  pickEndHour(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: endTime ?? const TimeOfDay(hour: 0, minute: 0),
    ).then((v) {
      if (v != null) {
        endTime = v;
        endHourController.text = v.format(context);
        validateEndHour = null;
        notifyListeners();
      }
    });
  }

  selectTransferType(int choice) {
    if (choice == 1) {
      type = 1;
    } else if (choice == 2) {
      type = 2;
    }
    notifyListeners();
  }

  bool autoValid1 = false;
  validate1() {
    if (formKey1.currentState!.validate()) {
      validatePackageName = null;
      validateWeight = null;
      validateLong = null;
      validateWidth = null;
      validateHeight = null;
      validateQuantity = null;
    } else {
      if (packageNameController.text.trim().isEmpty) {
        validatePackageName = S.current.not_blank;
      } else {
        validatePackageName = null;
      }
      if (weightController.text.trim().isEmpty) {
        validateWeight = S.current.not_blank;
      } else if (RegexText.onlyZero(weightController.text.trim())) {
        validateWeight = S.current.not_zero;
      } else {
        validateWeight = null;
      }
      if (longController.text.trim().isEmpty) {
        validateLong = S.current.not_blank;
      } else {
        validateLong = null;
      }
      if (widthController.text.trim().isEmpty) {
        validateWidth = S.current.not_blank;
      } else {
        validateWidth = null;
      }
      if (heightController.text.trim().isEmpty) {
        validateHeight = S.current.not_blank;
      } else {
        validateHeight = null;
      }
      if (quantityController.text.trim().isEmpty) {
        validateQuantity = S.current.not_blank;
      } else if (RegexText.onlyZero(
        quantityController.text.trim(),
      )) {
        validateQuantity = S.current.not_zero;
      } else {
        validateQuantity = null;
      }
      // if (dimentionController.text.trim().isEmpty) {
      //   validateDimention = S.of(context).not_blank;
      // } else if (!RegexText.onlyZero(
      //     dimentionController.text.trim())) {
      //   validateDimention = S.of(context).not_dimention;
      // } else if (RegexText.vietNameseChar(
      //     dimentionController.text.trim())) {
      //   validateDimention = S.of(context).not_vietnamese;
      // } else {
      //   validateDimention = null;
      // }

      notifyListeners();
    }
  }

  addPackage(BuildContext context, MapEntry<int, ItemDeliver>? item) async {
    if (item != null) {
      weightController.text = item.value.weight.toString();

      colorController.text = item.value.color.toString();
      quantityController.text = item.value.amount.toString();
      noteController.text = item.value.describe.toString();

      packageNameController.text = item.value.item_name.toString();
      dimentionController.text = item.value.dimension.toString();
      longController.text = item.value.dimension.toString().split('x')[0];
      widthController.text = item.value.dimension.toString().split('x')[1];
      heightController.text = item.value.dimension.toString().split('x')[2];
      validateDimention = null;
      validateLong = null;
      validateWidth = null;
      validateHeight = null;
      validateWeight = null;
      validatePackageName = null;
      validateQuantity = null;
      autoValid1 = false;
      notifyListeners();
    }

    await showModalBottomSheet(
      isScrollControlled: true,
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      // ),
      context: context,
      builder: (context) {
        // autoValid1 = false;
        return StatefulBuilder(
          builder: (context, setState) => PrimaryScreen(
            isPadding: false,
            body: Column(
              children: [
                vpad(40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BackButton(
                      onPressed: () {
                        setState(() {
                          weightController.text = '';
                          packageNameController.text = '';
                          dimentionController.text = '';
                          longController.text = '';
                          widthController.text = '';
                          heightController.text = '';
                          colorController.text = '';
                          quantityController.text = '';
                          describleController.text = '';
                          noteController.text = '';
                          validateQuantity = null;
                          validateDimention = null;
                          validateDimention = null;
                          validateLong = null;
                          validateWidth = null;
                          validateHeight = null;
                          validateWeight = null;
                          validatePackageName = null;
                          validateQuantity = null;
                          autoValid1 = false;
                          notifyListeners();
                        });

                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                      child: Text(
                        item != null
                            ? S.of(context).edit_package
                            : S.of(context).add_package_need_transfer,
                        style: txtBold(15, grayScaleColorBase),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    hpad(30)
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      onChanged: autoValid1
                          ? () {
                              validate1();
                              setState(() {});
                            }
                          : null,
                      autovalidateMode: autoValid1
                          ? AutovalidateMode.onUserInteraction
                          : null,
                      key: formKey1,
                      child: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Column(
                                // padding: const EdgeInsets.symmetric(horizontal: 24),
                                children: [
                                  vpad(12),
                                  PrimaryTextField(
                                    blockSpecial: true,
                                    maxLength: 100,
                                    validateString: validatePackageName,
                                    controller: packageNameController,
                                    label: S.of(context).package_name,
                                    isRequired: true,
                                    hint: S.of(context).package_name,
                                    validator: (v) {
                                      if (v!.trim().isEmpty) {
                                        return '';
                                      }

                                      return null;
                                    },
                                  ),
                                  vpad(12),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: PrimaryTextField(
                                          label: S.of(context).color,
                                          hint: S.of(context).color,
                                          maxLength: 20,
                                          controller: colorController,
                                        ),
                                      ),
                                      hpad(24),
                                      Expanded(
                                        child: PrimaryTextField(
                                          maxLength: 9,
                                          isRequired: true,
                                          keyboardType: TextInputType.number,
                                          onlyNum: true,
                                          label: S.of(context).amount,
                                          hint: S.of(context).amount,
                                          controller: quantityController,
                                          validateString: validateQuantity,
                                          validator: (v) {
                                            if (v!.trim().isEmpty) {
                                              return '';
                                            } else if (RegexText.onlyZero(
                                              v.trim(),
                                            )) {
                                              return '';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  vpad(12),
                                  PrimaryTextField(
                                    onlyNum: true,
                                    maxLength: 100,
                                    blockSpace: true,
                                    validateString: validateWeight,
                                    controller: weightController,
                                    label: '${S.of(context).weight} (kg)',
                                    isRequired: true,
                                    hint: '${S.of(context).weight} (kg)',
                                    keyboardType: TextInputType.number,
                                    validator: (v) {
                                      if (v!.trim().isEmpty) {
                                        return '';
                                      } else if (RegexText.onlyZero(v.trim())) {
                                        return '';
                                      }
                                      return null;
                                    },
                                  ),
                                  vpad(12),
                                  Row(
                                    children: [
                                      Text('${S.of(context).dimention} (cm)'),
                                      Text(
                                        '*',
                                        style: txtBodySmallRegular(
                                          color: redColorBase,
                                        ),
                                      )
                                    ],
                                  ),
                                  vpad(12),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: PrimaryTextField(
                                          onlyNum: true,
                                          isRequired: true,
                                          isShow: false,
                                          validateString: validateLong,
                                          keyboardType: TextInputType.number,
                                          controller: longController,
                                          label: S.of(context).long,
                                          maxLength: 100,
                                          blockSpace: true,
                                          validator: (v) {
                                            if (v!.isEmpty) {
                                              return '';
                                            }

                                            return null;
                                          },
                                        ),
                                      ),
                                      hpad(24),
                                      Expanded(
                                        child: PrimaryTextField(
                                          onlyNum: true,
                                          isRequired: true,
                                          isShow: false,
                                          validateString: validateWidth,
                                          keyboardType: TextInputType.number,
                                          controller: widthController,
                                          label: S.of(context).width,
                                          maxLength: 100,
                                          blockSpace: true,
                                          validator: (v) {
                                            if (v!.isEmpty) {
                                              return '';
                                            }

                                            return null;
                                          },
                                        ),
                                      ),
                                      hpad(24),
                                      Expanded(
                                        child: PrimaryTextField(
                                          onlyNum: true,
                                          isRequired: true,
                                          isShow: false,
                                          validateString: validateHeight,
                                          keyboardType: TextInputType.number,
                                          controller: heightController,
                                          label: S.of(context).height,
                                          maxLength: 100,
                                          blockSpace: true,
                                          validator: (v) {
                                            if (v!.isEmpty) {
                                              return '';
                                            }

                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  vpad(12),
                                  PrimaryTextField(
                                    maxLines: 3,
                                    maxLength: 250,
                                    label: S.of(context).description,
                                    hint: S.of(context).description,
                                    controller: noteController,
                                  ),
                                  vpad(30),
                                  PrimaryButton(
                                    width: dvWidth(context) - 48,
                                    text: item != null
                                        ? S.of(context).edit
                                        : S.of(context).add,
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      autoValid1 = true;
                                      if (formKey1.currentState!.validate()) {
                                        if (item != null) {
                                          onEditPackage(context, item.key);
                                        } else {
                                          onAddPackage(context);
                                        }
                                        autoValid1 = false;
                                        // formKey1.currentState!.dispose();
                                        Navigator.pop(context);
                                      } else {
                                        if (packageNameController.text
                                            .trim()
                                            .isEmpty) {
                                          validatePackageName =
                                              S.of(context).not_blank;
                                        } else {
                                          validatePackageName = null;
                                        }
                                        if (weightController.text
                                            .trim()
                                            .isEmpty) {
                                          validateWeight =
                                              S.of(context).not_blank;
                                        } else if (RegexText.onlyZero(
                                          weightController.text.trim(),
                                        )) {
                                          validateWeight =
                                              S.of(context).not_zero;
                                        } else {
                                          validateWeight = null;
                                        }
                                        if (longController.text
                                            .trim()
                                            .isEmpty) {
                                          validateLong =
                                              S.of(context).not_blank;
                                        } else {
                                          validateLong = null;
                                        }
                                        if (widthController.text
                                            .trim()
                                            .isEmpty) {
                                          validateWidth =
                                              S.of(context).not_blank;
                                        } else {
                                          validateWidth = null;
                                        }
                                        if (heightController.text
                                            .trim()
                                            .isEmpty) {
                                          validateHeight =
                                              S.of(context).not_blank;
                                        } else {
                                          validateHeight = null;
                                        }
                                        if (quantityController.text
                                            .trim()
                                            .isEmpty) {
                                          validateQuantity =
                                              S.of(context).not_blank;
                                        } else if (RegexText.onlyZero(
                                          quantityController.text.trim(),
                                        )) {
                                          validateQuantity =
                                              S.of(context).not_zero;
                                        } else {
                                          validateQuantity = null;
                                        }
                                        // if (dimentionController.text.trim().isEmpty) {
                                        //   validateDimention = S.of(context).not_blank;
                                        // } else if (!RegexText.onlyZero(
                                        //     dimentionController.text.trim())) {
                                        //   validateDimention = S.of(context).not_dimention;
                                        // } else if (RegexText.vietNameseChar(
                                        //     dimentionController.text.trim())) {
                                        //   validateDimention = S.of(context).not_vietnamese;
                                        // } else {
                                        //   validateDimention = null;
                                        // }
                                        setState(() {});
                                      }
                                    },
                                  ),
                                  vpad(16),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
