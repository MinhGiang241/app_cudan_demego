import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timeago/timeago.dart';

import '../constants/constants.dart';
import '../generated/l10n.dart';
import '../models/selection_model.dart';
import '../widgets/item_selected.dart';
import '../widgets/primary_bottom_sheet.dart';
import '../widgets/primary_button.dart';
import '../widgets/primary_dialog.dart';
import '../widgets/primary_icon.dart';

class Utils {
  static Future<T?> showDialog<T extends Object?>({
    required BuildContext context,
    required Widget dialog,
  }) {
    return showGeneralDialog(
      context: context,
      transitionDuration: const Duration(milliseconds: 250),
      barrierDismissible: true,
      barrierLabel: "",
      transitionBuilder: (
        context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        child,
      ) {
        final CurvedAnimation curvedAnimation =
            CurvedAnimation(parent: animation, curve: Curves.easeOutBack);

        return FadeTransition(
          opacity: curvedAnimation,
          child: ScaleTransition(scale: curvedAnimation, child: child),
        );
      },
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) =>
          dialog,
    );
  }

// Old util

  static Future<T?> pushScreen<T>(BuildContext context, Widget widget) =>
      Navigator.push(context, MaterialPageRoute(builder: (c) => widget));

  static Future<T?> pushReplacement<T>(BuildContext context, Widget widget) =>
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (c) => widget));

  static Future<T?> pushAndRemoveUntil<T>(BuildContext context, Widget widget,
          bool Function(Route<dynamic>) predicate) =>
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (c) => widget), predicate);

  static Future<T?> pushRemoveAll<T>(BuildContext context, Widget widget) =>
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (c) => widget), (route) => false);

  static pop<T extends Object?>(BuildContext context, [T? result]) =>
      Navigator.pop(context, result);

  static Future<T?> showBottomSheet<T>(
      {required BuildContext context, required Widget child}) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.2),
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      builder: (context) => child,
    );
  }

  static String moneyFomat(num? c) {
    if (c == null) {
      return '';
    }
    final a = NumberFormat.currency(locale: 'vi', symbol: "VND");
    return a.format(c);
  }

  static String dateFormat(String date, int choice, [String? format]) {
    if (date.isEmpty) {
      return "";
    }
    DateTime dateTime = DateTime.parse(date);
    DateTime d = dateTime;
    if (choice == -1) {
      d = dateTime.subtract(const Duration(hours: 7));
    } else if (choice == 1) {
      d = dateTime.add(const Duration(hours: 7));
    } else {
      d = dateTime;
    }
    String formattedDate = DateFormat(format ?? 'dd/MM/yyyy').format(d);
    return formattedDate;
  }

  static String timeFormat(String time, [String? format]) {
    if (time.isEmpty) {
      return "";
    }
    DateTime pickedTime = DateTime.parse(time);
    String formattedTime = DateFormat(format ?? 'HH:mm').format(pickedTime);
    return formattedTime;
  }

  static String timeAgo(BuildContext context, String date) {
    if (date.isEmpty) {
      return "";
    }
    DateTime dateTime = DateTime.parse(date);
    return '';

    //  timeago.format(dateTime,
    //     locale: Intl.getCurrentLocale(), allowFromNow: true);
  }

  static Future<T?> showBottomSelection<T>(
      {required BuildContext context,
      required List<SelectionModel> selections,
      Function(int)? onSelection}) async {
    return showBottomSheet(
        context: context,
        child: StatefulBuilder(builder: (context, setState) {
          return RepaintBoundary(
            child: DraggableScrollableSheet(
              maxChildSize: (dvHeight(context) -
                      appbarHeight(context) -
                      topSafePad(context)) /
                  dvHeight(context),
              builder: (context, scrollController) {
                return PrimaryBottomSheet(
                    child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      vpad(24),
                      ...List.generate(
                        selections.length,
                        (index) => Column(
                          children: [
                            ItemSelected(
                              text: selectionString(
                                  context, selections[index].title),
                              icon: selections[index].icon,
                              onTap: () async {
                                onSelection?.call(index);
                                setState(() {});
                                await Future.delayed(
                                  const Duration(milliseconds: 300),
                                  () {
                                    pop(context);
                                  },
                                );
                              },
                              isSelected: selections[index].isSelected,
                            ),
                            const Divider(height: 1)
                          ],
                        ),
                      ),
                      vpad(bottomSafePad(context) + 24)
                    ],
                  ),
                ));
              },
            ),
          );
        }));
  }

  static String selectionString(BuildContext context, String title) {
    switch (title) {
      case "ChoTruongBPKyThuatDuyet":
        return "S.of(context).choTruongBPKyThuatDuyet";
      case "ChoTruongBQLDuyet":
        return "S.of(context).choTruongBQLDuyet";
      case "ChoCDTDuyet":
        return "S.of(context).choCDTDuyet";
      case "YeuCauChinhSua":
        return "S.of(context).ycChinhSua";
      case "ChoCoc":
        return "S.of(context).choCoc";
      case "ChoThiCong":
        return "S.of(context).choThiCong";
      case "DangThiCong":
        return "S.of(context).dangThiCong";
      case "DangTamDung":
        return "S.of(context).dangTamDung";
      case "ChoKiemTra":
        return "S.of(context).choKiemTra";
      case "ChoHoanCoc":
        return "S.of(context).choHoanCoc";
      case "HoanThanh":
        return "S.of(context).hoanThanh";
      default:
        return title;
    }
  }

  // static Future<T?> showDialog<T extends Object?>(
  //     {required BuildContext context, required Widget dialog}) {
  //   return showGeneralDialog(
  //       context: context,
  //       transitionDuration: const Duration(milliseconds: 250),
  //       barrierDismissible: true,
  //       barrierLabel: "",
  //       transitionBuilder: (context, Animation<double> animation,
  //           Animation<double> secondaryAnimation, child) {
  //         final CurvedAnimation a =
  //             CurvedAnimation(parent: animation, curve: Curves.easeOutBack);

  //         return FadeTransition(
  //             opacity: a, child: ScaleTransition(scale: a, child: child));
  //       },
  //       pageBuilder: (BuildContext context, Animation<double> animation,
  //               Animation<double> secondaryAnimation) =>
  //           dialog);
  // }

  static Future<List<XFile>?> selectImage(BuildContext context, bool isMulti,
      {bool isFile = false}) async {
    final bool p = await requestPermistion(
        context, [Permission.camera, Permission.photos]);
    if (p) {
      return await Utils.showBottomSheet(
          context: context,
          child: PrimaryBottomSheet(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              vpad(24),
              ItemSelected(
                  text: S.current.camera,
                  icon: const PrimaryIcon(
                      icons: PrimaryIcons.camera, color: grayScaleColor2),
                  onTap: () async {
                    await _imagePicker(isMulti, ImageSource.camera)
                        .then((value) {
                      if (value != null) {
                        pop(context, value);
                      }
                    });
                  }),
              ItemSelected(
                text: S.current.gallery,
                icon: const PrimaryIcon(
                    icons: PrimaryIcons.image, color: grayScaleColor2),
                onTap: () async {
                  await _imagePicker(isMulti, ImageSource.gallery)
                      .then((value) {
                    if (value != null) {
                      pop(context, value);
                    }
                  });
                },
              ),
              if (Platform.isIOS && isFile)
                ItemSelected(
                  text: S.current.file_selection,
                  icon: const PrimaryIcon(
                      icons: PrimaryIcons.folder_open, color: grayScaleColor2),
                  onTap: () async {
                    await _filePicker().then((value) {
                      if (value != null) {
                        pop(context, value);
                      }
                    });
                  },
                ),
              vpad(bottomSafePad(context) + 24)
            ],
          )));
    } else {
      return null;
    }
  }

  static Future<List<XFile?>?> _filePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: [
        'jpg',
        'jpeg',
        'png',
        'pdf',
        'doc',
        'docx',
        'xls',
        'xlsx'
      ],
    );
    if (result != null) {
      final files = result.files.map<XFile>((e) => XFile(e.path!)).toList();
      return files;
    } else {
      return null;
    }
  }

  static Future<List<XFile>?> _imagePicker(
      bool isMulti, ImageSource source) async {
    final picker = ImagePicker();

    if (isMulti && source == ImageSource.gallery) {
      return await picker.pickMultiImage();
    }
    final image = await picker.pickImage(source: source);
    if (image != null) {
      return [image];
    } else {
      return null;
    }
  }

  static Future<bool> requestPermistion(
      BuildContext context, List<Permission> permissions) async {
    final value = await permissions.request();
    bool permanentlyDenied = false;
    for (var element in permissions) {
      if (value[element] == PermissionStatus.permanentlyDenied) {
        permanentlyDenied = true;
      }
    }
    if (permanentlyDenied) {
      await showDialog(
          context: context,
          dialog: PrimaryDialog.custom(
            title: S.current.permission_denied,
            content: Column(
              children: [
                Text(S.current.permission_denied_msg),
                vpad(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    PrimaryButton(
                      text: S.current.cancel,
                      buttonSize: ButtonSize.medium,
                      buttonType: ButtonType.secondary,
                      textColor: primaryColorBase,
                      onTap: () {
                        pop(context);
                      },
                    ),
                    PrimaryButton(
                      text: S.current.setting,
                      buttonSize: ButtonSize.medium,
                      onTap: () {
                        openAppSettings();
                      },
                    ),
                  ],
                )
              ],
            ),
          ));
      return false;
    } else {
      return true;
    }
  }

  static showDatePickers(BuildContext context,
      {Function(DateTime)? onChange,
      Function(DateTime)? onDone,
      DateTime? initDate,
      DateTime? startDate,
      DateTime? endDate}) async {
    if (Platform.isIOS) {
      showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) => Container(
                height: 286,
                padding: const EdgeInsets.only(top: 6.0),
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                color: CupertinoColors.systemBackground.resolveFrom(context),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          vpad(0),
                          CupertinoButton(
                              padding: EdgeInsets.zero,
                              child: Text("S.of(context).done"),
                              onPressed: () {
                                Utils.pop(context);
                              }),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SafeArea(
                        top: false,
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.date,
                          initialDateTime: initDate ?? DateTime(2000),
                          maximumDate: endDate ?? DateTime.now(),
                          minimumDate: startDate ?? DateTime(1900),
                          maximumYear: endDate != null
                              ? endDate.year
                              : DateTime.now().year,
                          minimumYear:
                              startDate != null ? startDate.year : 1900,
                          onDateTimeChanged: (d) {
                            onChange?.call(d);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ));
    } else {
      await showDatePicker(
        context: context,
        firstDate: startDate ?? DateTime(1900),
        lastDate: endDate ?? DateTime.now(),
        initialDate: initDate ?? DateTime(2000),
      ).then((value) {
        if (value != null) {
          onDone?.call(value);
        }
      });
    }
  }

  static Future<String> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  static showConnectionError(BuildContext context) {
    Utils.showDialog(
        context: context,
        dialog: PrimaryDialog.error(
          msg: S.of(context).err_conn,
        ));
  }

  static showErrorMessage(BuildContext context, String e) {
    Utils.showDialog(
        context: context,
        dialog: PrimaryDialog.error(
          msg: S.of(context).err_x(e),
        ));
  }

  static showSuccessMessage(
      // BuildContext context, String e, Function()? onClose
      {required BuildContext context,
      required String e,
      Function()? onClose}) {
    Utils.showDialog(
        context: context,
        dialog: PrimaryDialog.success(
          msg: e,
          onClose: onClose,
        ));
  }

  static showConfirmMessage(
      {required BuildContext context,
      String title = '',
      String content = '',
      Function()? onConfirm}) {
    Utils.showDialog(
        context: context,
        dialog: PrimaryDialog.custom(
          // customIcons: const PrimaryIcon(
          //   icons: PrimaryIcons.alert,
          //   color: Colors.white,
          //   style: PrimaryIconStyle.gradient,
          //   gradients: PrimaryIconGradient.yellow,
          //   size: 32,
          //   padding: EdgeInsets.all(12),
          // ),
          title: title,
          content: Column(
            children: [
              Text(
                content,
                style: txtBodySmallRegular(),
                textAlign: TextAlign.center,
              ),
              vpad(24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  PrimaryButton(
                    width: 120,
                    text: S.of(context).cancel,
                    buttonSize: ButtonSize.small,
                    buttonType: ButtonType.red,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  PrimaryButton(
                    width: 120,
                    text: S.of(context).confirm,
                    buttonSize: ButtonSize.small,
                    buttonType: ButtonType.primary,
                    onTap: () {
                      if (onConfirm == null) {
                        Navigator.of(context).pop();
                      } else {
                        onConfirm();
                      }
                    },
                  )
                ],
              ),
              vpad(12),
            ],
          ),
        ));
  }
}
