import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timeago/timeago.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../constants/api_constant.dart';
import '../constants/constants.dart';
import '../generated/l10n.dart';
import '../models/selection_model.dart';
import '../screens/auth/sign_in_screen.dart';
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
      barrierDismissible: false,
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
        context,
        MaterialPageRoute(builder: (c) => widget),
      );

  static Future<T?> pushAndRemoveUntil<T>(
    BuildContext context,
    Widget widget,
    bool Function(Route<dynamic>) predicate,
  ) =>
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (c) => widget),
        predicate,
      );

  static Future<T?> pushRemoveAll<T>(BuildContext context, Widget widget) =>
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (c) => widget),
        (route) => false,
      );

  static pop<T extends Object?>(BuildContext context, [T? result]) =>
      Navigator.pop(context, result);

  static Future<T?> showBottomSheet<T>({
    required BuildContext context,
    required Widget child,
  }) {
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

  static String dateTimeFormat(String date, int choice, [String? format]) {
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
    // String formattedDate = DateFormat(format ?? 'dd/MM/yyyy').format(d);
    return "${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')} ${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}";
    // return formattedDate;
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

  static Future<T?> showBottomSelection<T>({
    required BuildContext context,
    required List<SelectionModel> selections,
    String? title,
    Function(int)? onSelection,
  }) async {
    return showBottomSheet(
      context: context,
      child: StatefulBuilder(
        builder: (context, setState) {
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
                        if (title != null)
                          Text(
                            title,
                            style: txtLinkSmall(color: grayScaleColor1),
                          ),
                        ...List.generate(
                          selections.length,
                          (index) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ItemSelected(
                                text: selectionString(
                                  context,
                                  selections[index].title,
                                ),
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
                  ),
                );
              },
            ),
          );
        },
      ),
    );
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

  static Future<List<XFile?>?> selectFile(
    BuildContext context,
    bool isMulti, {
    bool isFile = false,
  }) async {
    final bool p = await requestPermistion(context, [
      Permission.storage,
    ]);
    if (p) {
      List<XFile?>? value = await filePicker(false, false).catchError((e) {
        showErrorMessage(context, e);
        return null;
      });
      return value;
    } else {
      return null;
    }
  }

  static Future<List<XFile>?> selectImage(
    BuildContext context,
    bool isMulti, {
    bool isFile = false,
  }) async {
    final bool p = await requestPermistion(
      context,
      [Permission.camera, Permission.photos],
    );
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
                  icons: PrimaryIcons.camera,
                  color: grayScaleColor2,
                ),
                onTap: () async {
                  await imagePicker(isMulti, ImageSource.camera).then((value) {
                    if (value != null) {
                      pop(context, value);
                    }
                  });
                },
              ),
              ItemSelected(
                text: S.current.gallery,
                icon: const PrimaryIcon(
                  icons: PrimaryIcons.image,
                  color: grayScaleColor2,
                ),
                onTap: () async {
                  await imagePicker(isMulti, ImageSource.gallery).then((value) {
                    if (value != null) {
                      pop(context, value);
                    }
                  }).catchError((e) {
                    Utils.showErrorMessage(context, e);
                  });
                },
              ),
              if (Platform.isIOS && isFile)
                ItemSelected(
                  text: S.current.file_selection,
                  icon: const PrimaryIcon(
                    icons: PrimaryIcons.folder_open,
                    color: grayScaleColor2,
                  ),
                  onTap: () async {
                    await filePicker(false, true).then((value) {
                      if (value != null) {
                        pop(context, value);
                      }
                    }).catchError((e) {
                      Utils.showErrorMessage(context, e);
                    });
                  },
                ),
              vpad(bottomSafePad(context) + 24)
            ],
          ),
        ),
      );
    } else {
      return null;
    }
  }

  static Future<List<XFile?>?> filePicker(bool isMultiple, bool isImage) async {
    var allows = [
      'jpg',
      'jpeg',
      'png',
      'pdf',
      'doc',
      'docx',
      'xls',
      'xlsx',
    ];
    var allowsImage = [
      'jpg',
      'jpeg',
      'png',
    ];
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: isMultiple,
      allowedExtensions: allows,
    );
    if (result != null) {
      final files = result.files.map<XFile>((e) => XFile(e.path!)).toList();
      if (!isImage && !allows.contains(files[0].path.split(".").last)) {
        throw (S.current.pick_file_error);
      }
      if (isImage && !allowsImage.contains(files[0].path.split(".").last)) {
        throw (S.current.pick_image_error);
      }
      var ffiles = files.where((v) {
        var a = (v.path.split('.').last);
        if (isImage) {
          if (!allowsImage.contains(a)) {
            return false;
          } else {
            return true;
          }
        } else {
          if (!allows.contains(a)) {
            return false;
          } else {
            return true;
          }
        }
        // if (allows.contains(a)) {
        //   return true;
        // } else {
        //   return false;
        // }
      }).toList();

      return ffiles;
    } else {
      return null;
    }
  }

  static Future<List<XFile>?> imagePicker(
    bool isMulti,
    ImageSource source,
  ) async {
    final picker = ImagePicker();
    var allows = [
      'jpg',
      'jpeg',
      'png',
    ];

    if (isMulti && source == ImageSource.gallery) {
      return await picker.pickMultiImage();
    }
    final image = await picker.pickImage(source: source);

    if (image != null) {
      var a = (image.path.split('.').last);
      if (!allows.contains(a)) {
        throw (S.current.pick_image_error);
      } else {
        return [image];
      }
    } else {
      return null;
    }
  }

  static Future<bool> requestPermistion(
    BuildContext context,
    List<Permission> permissions,
  ) async {
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
        ),
      );
      return false;
    } else {
      return true;
    }
  }

  static showDatePickers(
    BuildContext context, {
    Function(DateTime)? onChange,
    Function(DateTime)? onDone,
    DateTime? initDate,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    FocusScope.of(context).unfocus();
    if (Platform.isIOS) {
      return await showDatePicker(
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        context: context,
        firstDate: startDate ?? DateTime(1900),
        lastDate: endDate ?? DateTime.now(),
        initialDate: initDate ?? DateTime(2000),
      )
          // return showCupertinoModalPopup(
          //     context: context,
          //     builder: (BuildContext context) => Container(
          //           height: 286,
          //           padding: const EdgeInsets.only(top: 6.0),
          //           margin: EdgeInsets.only(
          //               bottom: MediaQuery.of(context).viewInsets.bottom),
          //           color: CupertinoColors.systemBackground.resolveFrom(context),
          //           child: Column(
          //             mainAxisSize: MainAxisSize.min,
          //             children: [
          //               Padding(
          //                 padding: const EdgeInsets.symmetric(horizontal: 16),
          //                 child: Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   children: [
          //                     vpad(0),
          //                     CupertinoButton(
          //                         padding: EdgeInsets.zero,
          //                         child: Text(S.of(context).done),
          //                         onPressed: () {
          //                           Utils.pop(context);
          //                         }),
          //                   ],
          //                 ),
          //               ),
          //               Expanded(
          //                 child: SafeArea(
          //                   top: false,
          //                   child: CupertinoDatePicker(
          //                     mode: CupertinoDatePickerMode.date,
          //                     initialDateTime: initDate ?? DateTime(2000),
          //                     maximumDate: endDate ?? DateTime.now(),
          //                     minimumDate: startDate ?? DateTime(1900),
          //                     maximumYear: endDate != null
          //                         ? endDate.year
          //                         : DateTime.now().year,
          //                     minimumYear:
          //                         startDate != null ? startDate.year : 1900,
          //                     onDateTimeChanged: (d) {
          //                       onChange?.call(d);
          //                     },
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ))
          .then((value) {
        if (value != null) {
          onDone?.call(value);
        }
        return value;
      });
    } else {
      return await showDatePicker(
        context: context,
        firstDate: startDate ?? DateTime(1900),
        lastDate: endDate ?? DateTime.now(),
        initialDate: initDate ?? DateTime(2000),
      ).then((value) {
        if (value != null) {
          onDone?.call(value);
        }
        return value;
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
      ),
    );
  }

  static showErrorMessage(BuildContext context, String e) {
    if (e == 'RELOGIN') {
      Utils.showDialog(
        context: context,
        dialog: PrimaryDialog.error(
          msg: S.of(context).err_x(S.of(context).expired_login),
          onClose: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              SignInScreen.routeName,
              ((route) => route.isCurrent),
              arguments: {},
            );
          },
        ),
      );
    } else {
      Utils.showDialog(
        context: context,
        dialog: PrimaryDialog.error(
          msg: S.of(context).err_x(e),
        ),
      );
    }
  }

  static showSuccessMessage(
      // BuildContext context, String e, Function()? onClose
      {
    required BuildContext context,
    required String e,
    Function()? onClose,
  }) {
    Utils.showDialog(
      context: context,
      dialog: PrimaryDialog.success(
        msg: e,
        onClose: onClose,
      ),
    );
  }

  static showConfirmMessage({
    required BuildContext context,
    String title = '',
    String content = '',
    Function()? onConfirm,
    Widget? child,
  }) {
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
            if (child != null) child,
            vpad(24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 8,
                  child: PrimaryButton(
                    text: S.of(context).cancel,
                    buttonSize: ButtonSize.small,
                    buttonType: ButtonType.red,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Expanded(flex: 1, child: hpad(0)),
                Expanded(
                  flex: 8,
                  child: PrimaryButton(
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
                  ),
                ),
              ],
            ),
            vpad(12),
          ],
        ),
      ),
    );
  }

  static String? emptyValidator(v) {
    if (v.trim()!.isEmpty) {
      return '';
    }
    return null;
  }

  static String? emptyValidatorDropdown(v) {
    if (v == null) {
      return '';
    }
    return null;
  }

  static showSnackBar(BuildContext context, String title) {
    showTopSnackBar(
      Overlay.of(context),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
        ),
        child: DefaultTextStyle(
          style: txtRegular(14, Colors.white),
          child: Text(
            title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      animationDuration: const Duration(milliseconds: 1000),
      displayDuration: const Duration(milliseconds: 1500),
    );

    // ScaffoldMessenger.of(context).hideCurrentSnackBar();
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     behavior: SnackBarBehavior.floating,
    //     margin: EdgeInsets.only(
    //         bottom: MediaQuery.of(context).size.height - 100,
    //         right: 20,
    //         left: 20),
    //     duration: const Duration(seconds: 1),
    //     backgroundColor: primaryColorBase,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(12),
    //     ),
    //     content: Text(title),
    //   ),
    // );
  }

  static downloadFile({
    String? url,
    String? id,
    Map<String, String>? headers,
    BuildContext? context,
  }) async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      showSnackBar(context!, S.current.file_downloading);
      final baseStorage = await getExternalStorageDirectory();

      var taskId = await FlutterDownloader.enqueue(
        url: url ?? "${ApiConstants.uploadURL}?load=$id ",
        headers: headers ??
            {
              'Accept':
                  'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/jpg,image/jpeg,image/png,image/webp,file/pdf,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9',
              // 'Host': ApiConstants.host,
            }, // optional: header send with url (auth token etc)
        savedDir: baseStorage!.path,
        showNotification:
            true, // show download progress in status bar (for Android)
        saveInPublicStorage: true,
        openFileFromNotification:
            true, // click on notification to open downloaded file (for Android)
      );
      await FlutterDownloader.open(taskId: taskId!);
    }
  }

  static String replaceInputVietChar(String v) {
    v = v.replaceAll(RegExp('[à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ]'), 'a');
    v = v.replaceAll(RegExp('[è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ]'), 'e');
    v = v.replaceAll(RegExp('[ì|í|ị|ỉ|ĩ]'), 'i');
    v = v.replaceAll(RegExp('[ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ]'), 'o');
    v = v.replaceAll(RegExp('[ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ]'), 'u');
    v = v.replaceAll(RegExp('[ỳ|ý|ỵ|ỷ|ỹ]'), 'y');
    v = v.replaceAll(RegExp('[đ]'), 'd');
    v = v.replaceAll(RegExp('[À|Á|Ạ|Ả|Ã|Â|Ầ|Ấ|Ậ|Ẩ|Ẫ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ]'), 'A');
    v = v.replaceAll(RegExp('[È|É|Ẹ|Ẻ|Ẽ|Ê|Ề|Ế|Ệ|Ể|Ễ]'), 'E');
    v = v.replaceAll(RegExp('[Ì|Í|Ị|Ỉ|Ĩ]'), 'I');
    v = v.replaceAll(RegExp('[Ò|Ó|Ọ|Ỏ|Õ|Ô|Ồ|Ố|Ộ|Ổ|Ỗ|Ơ|Ờ|Ớ|Ợ|Ở|Ỡ]'), 'O');
    v = v.replaceAll(RegExp('[Ù|Ú|Ụ|Ủ|Ũ|Ư|Ừ|Ứ|Ự|Ử|Ữ]'), 'U');
    v = v.replaceAll(RegExp('[Ỳ|Ý|Ỵ|Ỷ|Ỹ]'), 'Y');
    v = v.replaceAll(RegExp('[Đ]'), 'D');
    return v;
  }
}
