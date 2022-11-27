import 'dart:io';

import 'package:app_cudan/constants/constants.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/screens/services/delivery/delivery_list_screen.dart';
import 'package:app_cudan/services/api_delivery.dart';
import 'package:app_cudan/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../../../../models/delivery.dart';
import '../../../../services/api_auth.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/primary_button.dart';

class RegisterDeliveryPrv extends ChangeNotifier {
  RegisterDeliveryPrv({
    this.id,
    this.helpCheck = false,
    this.packageItems = const [],
    this.existedImage = const [],
    this.type = 1,
  });
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
  String? validateStartDate;
  String? validateEndDate;
  String? validateType;
  String? validatePackageName;
  String? validateWeight;
  String? validateDimention;
  bool isLoading = false;

  List<File> imagesDelivery = [];
  List<ImageDelivery> existedImage = [];
  List<ItemDeliver> packageItems = [];
  List<ImageDelivery> submitImageDelivery = [];

  onSendSummitDelivery(BuildContext context, bool isRequest) {
    FocusScope.of(context).unfocus();

    if (formKey.currentState!.validate()) {
      uploadDeliveryImage(context).then((v) {
        var newDelivery = Delivery(
          phone_number: context.read<ResidentInfoPrv>().userInfo!.phone,
          note_reason: noteController.text.trim(),
          item_added_list: (packageItems.isNotEmpty) ? packageItems : null,
          start_time:
              '${startDateController.text.split('/').reversed.join('-')}T17:00:00',
          end_time:
              '${endDateController.text.split('/').reversed.join('-')}T17:00:00',
          start_hour: startHourController.text.isNotEmpty
              ? '${startHourController.text}:00'
              : null,
          end_hour: endHourController.text.isNotEmpty
              ? '${endHourController.text}:00'
              : null,
          id: id,
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
      }).then((v) {
        Utils.showSuccessMessage(
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
      }).catchError((e) {
        Utils.showErrorMessage(context, e.toString());
      });
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
    isLoading = true;
    notifyListeners();
    await APIAuth.uploadSingleFile(context: context, files: imagesDelivery)
        .then((v) {
      isLoading = false;
      notifyListeners();
      if (v.isNotEmpty) {
        for (var element in v) {
          submitImageDelivery
              .add(ImageDelivery(id: element.data, name: element.data));
        }
      }
    }).catchError((e) {
      isLoading = false;
      notifyListeners();
      Utils.showErrorMessage(context, e);
    });
  }

  removeItemPackage(int index) {
    packageItems.removeAt(index);
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
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 10, 1, 1),
      lastDate: DateTime(DateTime.now().year + 10, 1, 1),
    ).then((v) {
      if (v != null) {
        startDateController.text = Utils.dateFormat(v.toIso8601String());
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
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 10, 1, 1),
      lastDate: DateTime(DateTime.now().year + 10, 1, 1),
    ).then((v) {
      if (v != null) {
        endDateController.text = Utils.dateFormat(v.toIso8601String());
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

  addPackage(BuildContext context) {
    showModalBottomSheet(
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
                      S.of(context).add_package,
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
                        validateString: validatePackageName,
                        controller: packageNameController,
                        label: S.of(context).package_name,
                        isRequired: true,
                        hint: S.of(context).package_name,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return '';
                          }
                          return null;
                        },
                      ),
                      vpad(16),
                      PrimaryTextField(
                        validateString: validateWeight,
                        controller: weightController,
                        label: '${S.of(context).weight} (kg)',
                        isRequired: true,
                        hint: '${S.of(context).weight} (kg)',
                        keyboardType: TextInputType.number,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return '';
                          }
                          return null;
                        },
                      ),
                      vpad(16),
                      PrimaryTextField(
                        validateString: validateDimention,
                        controller: dimentionController,
                        label: '${S.of(context).dimention} (cm)',
                        isRequired: true,
                        hint: S.of(context).l_w_e,
                        validator: (v) {
                          if (v!.isEmpty) {
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
                            onAddPackage(context);
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
                            } else {
                              validateWeight = null;
                            }
                            if (dimentionController.text.trim().isEmpty) {
                              validateDimention = S.of(context).not_blank;
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
