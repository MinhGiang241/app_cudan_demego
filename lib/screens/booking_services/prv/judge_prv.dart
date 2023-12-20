import 'dart:io';

import 'package:app_cudan/models/booking_service.dart';
import 'package:app_cudan/models/file_upload.dart';
import 'package:app_cudan/services/api_booking_service.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../../services/api_auth.dart';
import '../../../utils/utils.dart';
import '../history_register_service_screen.dart';

class JudgePrv extends ChangeNotifier {
  JudgePrv({required this.reg, required this.isEdit}) {
    if (!isEdit) {
      commentController.text = reg?.vote_content ?? '';
      existedImages = reg?.vote_image ?? [];
    }
  }
  final bool isEdit;
  var loading = false;
  List<FileUploadModel> existedImages = [];
  List<File> images = [];
  List<FileUploadModel> uploadedImages = [];
  TextEditingController commentController = TextEditingController();
  var score = 3.0;
  final RegisterBookingService reg;

  setScore(double value) {
    score = value;
    notifyListeners();
  }

  onSelectImage(BuildContext context) async {
    await Utils.selectImage(context, false).then((value) {
      if (value != null) {
        final list = value.map<File>((e) => File(e.path)).toList();
        images.addAll(list);

        notifyListeners();
      }
    });
  }

  onRemoveImage(int index) {
    images.removeAt(index);
    notifyListeners();
  }

  onRemoveExistedImage(int index) {
    existedImages.removeAt(index);
    notifyListeners();
  }

  Future uploadImages() async {
    await APIAuth.uploadSingleFile(
      files: images,
    ).then((v) {
      if (v.isNotEmpty) {
        for (var e in v) {
          uploadedImages.add(
            FileUploadModel(id: e.data, name: e.name),
          );
        }
      }
    }).catchError((e) {
      throw (e);
    });
  }

  onSend(BuildContext context) async {
    try {
      loading = true;
      notifyListeners();
      await uploadImages();
      var regData = reg.copyWith();
      regData.vote = score.toInt();
      regData.vote_content = commentController.text.trim();
      regData.vote_image = uploadedImages;
      await APIBookingService.addCommentToRegisterService(regData.toMap())
          .then((v) {
        loading = false;
        notifyListeners();
        Utils.showSuccessMessage(
          context: context,
          e: S.of(context).success_comment,
          onClose: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              HistoryRegisterServiceScreen.routeName,
              (route) => route.isFirst,
              arguments: {
                'init': reg.registration_type == 'month' ? 1 : 0,
              },
            );
          },
        );
      });
    } catch (e) {
      Utils.showErrorMessage(context, e.toString());
      loading = false;
      notifyListeners();
    }
  }
}
