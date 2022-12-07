import 'dart:io';

import 'package:app_cudan/constants/constants.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/screens/services/delivery/delivery_list_screen.dart';
import 'package:app_cudan/services/api_delivery.dart';
import 'package:app_cudan/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../constants/regex_text.dart';
import '../../../../generated/l10n.dart';
import '../../../../models/delivery.dart';
import '../../../../services/api_auth.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/primary_button.dart';

class RegisterDeliveryPrv extends ChangeNotifier {
  RegisterDeliveryPrv(
      {this.id,
      this.code,
      this.helpCheck = false,
      this.packageItems = const [],
      this.existedImage = const [],
      this.type = 1,
      this.startDate,
      this.endDate});
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
  final TextEditingController noteController = TextEditingController();
  bool helpCheck = false;
  String? id;
  String? code;
  String? validateStartDate;
  String? validateEndDate;
  String? validateType;
  String? validatePackageName;
  String? validateWeight;
  String? validateDimention;
  DateTime? startDate;
  DateTime? endDate;
  bool isAddNewLoading = false;
  bool isSendApproveLoading = false;

  List<File> imagesDelivery = [];
  List<ImageDelivery> existedImage = [];
  List<ItemDeliver> packageItems = [];
  List<ImageDelivery> submitImageDelivery = [];

  onSendSummitDelivery(BuildContext context, bool isRequest) {
    FocusScope.of(context).unfocus();

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
            DateTime.now().year, DateTime.now().month, DateTime.now().day);
        // throw (endDate!.compareTo(startDate!) < 0);
        if (startDate == null) {
          listError.add(S.of(context).start_date_not_empty);
        } else if (startDate!.compareTo(now) < 0) {
          listError.add(S.of(context).start_date_after_now);
        }
        if (endDate == null) {
          listError.add(S.of(context).end_date_not_empty);
        } else if (endDate!.compareTo(now) < 0) {
          listError.add(S.of(context).end_date_after_now);
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
          var newDelivery = Delivery(
            code: code,
            phone_number:
                context.read<ResidentInfoPrv>().userInfo!.phone_required,
            describe: noteController.text.trim(),
            item_added_list: (packageItems.isNotEmpty) ? packageItems : null,
            start_time: startDate!.toIso8601String(),
            end_time: endDate!.toIso8601String(),
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
            status: isRequest ? "WAIT" : "NEW",
            type_transfer: type == 1 ? "OUT" : "IN",
            apartmentId:
                context.read<ResidentInfoPrv>().selectedApartment!.apartmentId,
          );

          var data = newDelivery.toJson();
          return APIDelivery.saveNewDelivery(data);
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

                Navigator.pushNamedAndRemoveUntil(context,
                    DeliveryListScreen.routeName, (route) => route.isFirst);
              });
          isSendApproveLoading = false;
          isAddNewLoading = false;
          notifyListeners();
        }).catchError((e) {
          isSendApproveLoading = false;
          isAddNewLoading = false;
          validateStartDate = null;
          validateEndDate = null;
          validateType = null;
          validatePackageName = null;
          validateDimention = null;
          notifyListeners();
          Utils.showErrorMessage(context, e.toString());
        });
      } catch (e) {
        isSendApproveLoading = false;
        isAddNewLoading = false;
        validateStartDate = null;
        validateEndDate = null;
        validateType = null;
        validatePackageName = null;
        validateDimention = null;
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
      notifyListeners();
    }
  }

  toggleHelpCheck() {
    helpCheck = !helpCheck;
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
      dimension: dimentionController.text.trim(),
    );

    packageItems[index] = newItem;

    weightController.text = '';
    packageNameController.text = '';
    dimentionController.text = '';
    validateDimention = null;
    validateWeight = null;
    validatePackageName = null;
    notifyListeners();
  }

  onAddPackage(BuildContext context) {
    packageItems.add(ItemDeliver(
      weight: double.tryParse(weightController.text.trim()) != null
          ? double.parse(weightController.text.trim())
          : 0,
      item_name: packageNameController.text.trim(),
      dimension: dimentionController.text.trim(),
    ));
    weightController.text = '';
    packageNameController.text = '';
    dimentionController.text = '';
    validateDimention = null;
    validateWeight = null;
    validatePackageName = null;
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
    await Utils.selectImage(context, true).then((value) {
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
      initDate: DateTime.now(),
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
        startDateController.text = Utils.dateFormat(v.toIso8601String(), 0);
        startDate = v;
      }
    });
  }

  pickStartHour(BuildContext context) {
    showTimePicker(
            context: context, initialTime: const TimeOfDay(hour: 0, minute: 0))
        .then((v) {
      if (v != null) {
        startHourController.text = v.format(context);
      }
    });
  }

  pickEndDate(BuildContext context) {
    Utils.showDatePickers(
      context,
      initDate: DateTime.now(),
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
      }
    });
  }

  pickEndHour(BuildContext context) {
    showTimePicker(
            context: context, initialTime: const TimeOfDay(hour: 0, minute: 0))
        .then((v) {
      if (v != null) {
        endHourController.text = v.format(context);
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

  addPackage(BuildContext context, MapEntry<int, ItemDeliver>? item) async {
    if (item != null) {
      weightController.text = item.value.weight.toString();
      packageNameController.text = item.value.item_name.toString();
      dimentionController.text = item.value.dimension.toString();
      validateDimention = null;
      validateWeight = null;
      validatePackageName = null;
      notifyListeners();
    }

    await showModalBottomSheet(
      isScrollControlled: true,
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      // ),
      context: context,
      builder: (context) => Form(
        key: formKey1,
        child: StatefulBuilder(
          builder: (context, setState) {
            return Column(
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
                          validateDimention = null;
                          validateWeight = null;
                          validatePackageName = null;
                          notifyListeners();
                        });

                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      item != null
                          ? S.of(context).edit_package
                          : S.of(context).add_package,
                      style: txtBodyLargeBold(color: grayScaleColorBase),
                      textAlign: TextAlign.center,
                    ),
                    hpad(50)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    // padding: const EdgeInsets.symmetric(horizontal: 24),
                    children: [
                      vpad(16),
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
                      vpad(16),
                      PrimaryTextField(
                        maxLength: 100,
                        blockSpace: true,
                        validateString: validateWeight,
                        controller: weightController,
                        label: '${S.of(context).weight} (kg)',
                        isRequired: true,
                        hint: '${S.of(context).weight} (kg)',
                        keyboardType: TextInputType.number,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return '';
                          } else if (!RegexText.onlyZero(v.trim())) {
                            return '';
                          }
                          return null;
                        },
                      ),
                      vpad(16),
                      PrimaryTextField(
                        maxLength: 100,
                        blockSpace: true,
                        validateString: validateDimention,
                        controller: dimentionController,
                        label: '${S.of(context).dimention} (cm)',
                        isRequired: true,
                        hint: S.of(context).l_w_e,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return '';
                          } else if (!RegexText.onlyZero(v.trim())) {
                            return '';
                          } else if (RegexText.vietNameseChar(v.trim())) {
                            return '';
                          }
                          return null;
                        },
                      ),
                      vpad(30),
                      PrimaryButton(
                        width: dvWidth(context) - 48,
                        text: S.of(context).add_package,
                        onTap: () {
                          if (formKey1.currentState!.validate()) {
                            if (item != null) {
                              onEditPackage(context, item.key);
                            } else {
                              onAddPackage(context);
                            }

                            // formKey1.currentState!.dispose();
                            Navigator.pop(context);
                          } else {
                            if (packageNameController.text.trim().isEmpty) {
                              validatePackageName = S.of(context).not_blank;
                            } else {
                              validatePackageName = null;
                            }
                            if (weightController.text.trim().isEmpty) {
                              validateWeight = S.of(context).not_blank;
                            } else if (!RegexText.onlyZero(
                                weightController.text.trim())) {
                              validateWeight = S.of(context).not_zero;
                            } else {
                              validateWeight = null;
                            }
                            if (dimentionController.text.trim().isEmpty) {
                              validateDimention = S.of(context).not_blank;
                            } else if (!RegexText.onlyZero(
                                dimentionController.text.trim())) {
                              validateDimention = S.of(context).not_dimention;
                            } else if (RegexText.vietNameseChar(
                                dimentionController.text.trim())) {
                              validateDimention = S.of(context).not_vietnamese;
                            } else {
                              validateDimention = null;
                            }
                            setState(() {});
                            notifyListeners();
                          }
                        },
                      ),
                      vpad(16),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
