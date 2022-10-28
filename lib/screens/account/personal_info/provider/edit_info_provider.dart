// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:app_cudan/utils/convert_date_time.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../models/response_user.dart';
import '../../../../models/selection_model.dart';
import '../../../../services/api_auth.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/item_selected.dart';
import '../../../../widgets/primary_bottom_sheet.dart';
import '../../../../widgets/primary_dialog.dart';
import '../../../../widgets/primary_icon.dart';
import '../../../auth/prv/auth_prv.dart';

class EditInfoProvider extends ChangeNotifier {
  bool isSaving = false;

  late TextEditingController nameController = TextEditingController();
  late TextEditingController phoneController = TextEditingController();
  late TextEditingController idNumController = TextEditingController();
  late TextEditingController dateOfBirthController = TextEditingController();
  late TextEditingController genderController = TextEditingController();
  late TextEditingController countryController = TextEditingController();
  String? avatarLink;
  File? avatar;
  String? date;
  String? gender;

  AuthPrv authPrv;

  EditInfoProvider(ResponseUser? user, this.authPrv) {
    avatarLink = user?.avatarLink;
    date = user?.birthday;
    gender = user?.sex;
    nameController = TextEditingController(text: user?.userName ?? "");
    phoneController = TextEditingController(text: user?.phone ?? "");
    idNumController = TextEditingController(text: user?.cmnd ?? "");
    dateOfBirthController = TextEditingController(
        text: date != null ? date!.formatDateTimeHmDMY() : null);
    genderController = TextEditingController(text: _genderString(gender));
    countryController = TextEditingController(text: user?.national ?? "");
    notifyListeners();
  }

  String? _genderString(String? gen) {
    if (gen == "Male") {
      return S.current.male;
    }
    if (gen == "Female") {
      return S.current.female;
    }
    if (gen == "Other") {
      return S.current.other_gender;
    }
    return null;
  }

  save(BuildContext context) async {
    isSaving = true;
    notifyListeners();
    String? link;
    if (avatar != null) {
      //final length = await avatar!.length();
      await APIAuth.uploadImage(
              files: [avatar!],
              onSendProgress: (a, b) {
                // print(a / b);
              })
          .then((value) {
        link = value.files?[0].url;
      });
    }
    await APIAuth.updateUserInfo(
            avatarLink: link,
            birthday: date,
            cmnd: idNumController.text,
            national: countryController.text,
            sex: gender,
            userName: nameController.text)
        .then((value) async {
      // if (value.status == null) {
      //   if (value.success == true) {
      //     await authPrv.getUserInfo().then((value) {
      //       isSaving = false;
      //       notifyListeners();
      //       Utils.showDialog(
      //           context: context,
      //           dialog: PrimaryDialog.success(
      //             msg: "S.of(context).update_success",
      //           )).then((value) {
      //         // Utils.pop(context);
      //       });
      //     });
      //   } else {
      //     isSaving = false;
      //     notifyListeners();
      //     Utils.showDialog(
      //         context: context,
      //         dialog: PrimaryDialog.error(
      //           msg: "S.of(context).err_x(value.message ?? value.status)",
      //         ));
      //   }
      // } else {
      //   isSaving = false;
      //   notifyListeners();
      //   Utils.showDialog(
      //       context: context,
      //       dialog: PrimaryDialog.error(
      //         msg: "S.of(context).err_x(value.message ?? value.status)",
      //       ));
      // }
    });
  }

  Future selectImage(BuildContext context) async {
    final bool p = await Utils.requestPermistion(
        context, [Permission.camera, Permission.photos]);
    if (p) {
      Utils.showBottomSheet(
          context: context,
          child: PrimaryBottomSheet(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              vpad(24),
              ItemSelected(
                  text: "S.current.camera",
                  icon: const PrimaryIcon(
                      icons: PrimaryIcons.camera, color: grayScaleColor2),
                  onTap: () async {
                    final xfile = await _imagePicker(ImageSource.camera);
                    if (xfile != null) {
                      final file = File(xfile.path);

                      final compressFile = await _cropAndCompressImage(file);
                      if (compressFile != null) {
                        avatar = File(compressFile.path);
                        notifyListeners();
                        Utils.pop(context);
                      }
                    }
                  }),
              ItemSelected(
                text: "S.current.gallery",
                icon: const PrimaryIcon(
                    icons: PrimaryIcons.image, color: grayScaleColor2),
                onTap: () async {
                  final xfile = await _imagePicker(ImageSource.gallery);
                  if (xfile != null) {
                    final file = File(xfile.path);
                    final compressFile = await _cropAndCompressImage(file);
                    if (compressFile != null) {
                      avatar = File(compressFile.path);
                      notifyListeners();
                      Utils.pop(context);
                    }
                  }
                },
              ),
              vpad(bottomSafePad(context) + 24)
            ],
          )));
    }
  }

  Future<File?> _cropAndCompressImage(File file) async {
    final length = await file.length();
    if (kDebugMode) {
      print(length);
    }
    final path = await getApplicationDocumentsDirectory();
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      aspectRatioPresets: [CropAspectRatioPreset.square],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: primaryColorBase,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false),
        IOSUiSettings(
            title: 'Cropper',
            rectX: 300,
            rectY: 300,
            aspectRatioPickerButtonHidden: true)
      ],
    );

    final compressFile = await FlutterImageCompress.compressAndGetFile(
      croppedFile!.path,
      "${path.path}/${file.path.split('/').last}",
      minHeight: 800,
      minWidth: 800,
    );
    final length2 = await compressFile?.length();
    if (kDebugMode) {
      print(length2);
    }
    return compressFile;
  }

  Future<XFile?> _imagePicker(ImageSource source) async {
    final picker = ImagePicker();
    return await picker.pickImage(source: source);
  }

  birthDayPicker(BuildContext context) async {
    DateTime initialdate = DateTime.now();
    if (date != null) {
      initialdate = DateTime.parse(date!);
    }
    await Utils.showDatePickers(context, initDate: initialdate, onChange: (v) {
      date = v.toIso8601String();
      final d = Utils.dateFormat(v.toString());
      dateOfBirthController.text = d;
    }, onDone: (v) {
      date = v.toIso8601String();
      final d = Utils.dateFormat(v.toString());
      dateOfBirthController.text = d;
    });
  }

  selectGender(BuildContext context) async {
    final List<SelectionModel> listSelection = [
      SelectionModel(title: S.of(context).male),
      SelectionModel(title: S.of(context).female),
      SelectionModel(title: S.of(context).other_gender),
    ];
    if (gender == "Male") {
      listSelection[0].isSelected = true;
    } else if (gender == "Female") {
      listSelection[1].isSelected = true;
    } else if (gender == "Other") {
      listSelection[2].isSelected = true;
    }
    Utils.showBottomSelection(
        context: context,
        selections: listSelection,
        onSelection: (index) {
          genderController.text = listSelection[index].title;
          if (index == 0) {
            gender = "Male";
          }
          if (index == 1) {
            gender = "Female";
          }
          if (index == 2) {
            gender = "Other";
          }
          for (var i = 0; i < listSelection.length; i++) {
            if (i == index) {
              listSelection[i].isSelected = true;
            } else {
              listSelection[i].isSelected = false;
            }
          }
        });
  }
}
