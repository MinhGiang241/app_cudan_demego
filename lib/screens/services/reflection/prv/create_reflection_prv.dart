import 'dart:io';

import 'package:app_cudan/models/area.dart';
import 'package:app_cudan/models/reflection.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/screens/services/reflection/reflection_screen.dart';
import 'package:app_cudan/services/api_reflection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../../../../services/api_auth.dart';
import '../../../../utils/utils.dart';

class CreateReflectionPrv extends ChangeNotifier {
  var existedImage = [];
  List<Area> areas = [];
  List<File> images = [];
  List<FileTicket> submitedImages = [];
  var formKey = GlobalKey<FormState>();
  // List<ComplainReason> listReasons = [];
  List<ComplainReason> listOpinion = [];
  bool autoValid = false;
  bool isAddNewLoading = false;
  bool isSendApproveLoading = false;
  final TextEditingController typeController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController zoneController = TextEditingController();
  final TextEditingController zoneTypeController = TextEditingController();
  String? validateType;
  String? validateReason;
  String? validateZone;
  String? validateZoneType;
  final GlobalKey<FormFieldState> dropdownKey = GlobalKey<FormFieldState>();

  onSubmit(BuildContext context, bool isSend) async {
    autoValid = true;
    FocusScope.of(context).unfocus();
    isSend ? isSendApproveLoading = true : isAddNewLoading = true;
    notifyListeners();
    if (formKey.currentState!.validate()) {
      var apartmentId =
          context.read<ResidentInfoPrv>().selectedApartment!.apartmentId;
      var phoneNumber =
          context.read<ResidentInfoPrv>().userInfo!.phone_required;
      var residentId = context.read<ResidentInfoPrv>().residentId;
      var resident_code = context.read<ResidentInfoPrv>().userInfo!.code;
      await uploadImage(context);
      // var newOpinion = OpinionContribute(
      //   content: noteController.text.trim(),
      //   description: noteController.text.trim(),
      // );
      // await APIReflection.saveOpinionContribute(newOpinion.toMap()).then((v) {
      var newTicket = Reflection(
        apartmentId: apartmentId,
        opinionContributeId: reasonController.text.trim(),
        // complaintReasonId: typeController.text == "COMPLAIN"
        //     ? reasonController.text.trim()
        //     : null,
        date:
            DateTime.now().subtract(const Duration(hours: 7)).toIso8601String(),
        files: submitedImages,
        isMobile: true,
        phoneNumber: phoneNumber,
        residentId: residentId,
        status: !isSend ? "NEW" : "WAIT_PROGRESS",
        resident_code: resident_code,
        ticket_type: typeController.text.trim(),
      );
      // return
      APIReflection.saveTicket(newTicket.toMap())
          // ;})
          .then((v) {
        Utils.showSuccessMessage(
            context: context,
            e: isSend
                ? S.of(context).success_send_ticket
                : S.of(context).success_add_ticket,
            onClose: () {
              Navigator.pushNamed(context, ReflectionScreen.routeName,
                  arguments: {'initTab': isSend ? 1 : 0});
            });
      }).catchError((e) {
        isSend ? isSendApproveLoading = false : isAddNewLoading = false;
        Utils.showErrorMessage(context, e);
        notifyListeners();
      });
    } else {
      isSend ? isSendApproveLoading = false : isAddNewLoading = false;
      if (typeController.text.trim().isEmpty) {
        validateType = S.of(context).not_blank;
      } else {
        validateType = null;
      }
      if (reasonController.text.trim().isEmpty) {
        validateReason = S.of(context).not_blank;
      } else {
        validateReason = null;
      }
      if (zoneController.text.trim().isEmpty) {
        validateZone = S.of(context).not_blank;
      } else {
        validateZone = null;
      }
      if (zoneTypeController.text.trim().isEmpty) {
        validateZoneType = S.of(context).not_blank;
      } else {
        validateZoneType = null;
      }
    }
    notifyListeners();
  }

  onSelectType(v) {
    if (v != null) {
      validateType = null;
      // if (typeController.text != v) {
      //   reasonController.clear();
      //   if (autoValid) {
      //     validateReason = S.current.not_blank;
      //   }
      //   typeController.text = v;
      // }
      typeController.text = v;
    }
    notifyListeners();
  }

  onSelectReason(v) {
    if (v != null) {
      validateReason = null;

      reasonController.text = v;
    }
    notifyListeners();
  }

  onSelectZoneType(v) async {
    if (v != null) {
      validateZoneType = null;
      if (zoneTypeController.text != v) {
        zoneTypeController.text = v;
        zoneController.clear();

        dropdownKey.currentState!.reset();

        areas.clear();
        if (autoValid) {
          validateZone = S.current.not_blank;
        }

        await getListAreaByType(v);
      } else {}
    }
    notifyListeners();
  }

  onSelectZone(v) {
    if (v != null) {
      zoneController.text = v;
      validateZone = null;
    }
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

  removeExistedImages(int index) {
    existedImage.removeAt(index);
    notifyListeners();
  }

  getReflectionReason(BuildContext context) async {
    // await APIReflection.getComplainReaction().then((v) {
    //   listReasons.clear();
    //   for (var i in v) {
    //     listReasons.add(ComplainReason.fromJson(i));
    //   }
    //    return APIReflection.getOpinion();
    // })
    // .then((v) {
    //   listOpinion.clear();
    //   for (var i in v) {
    //     listOpinion.add(ComplainReason.fromJson(i));
    //   }
    // })
    await APIReflection.getOpinion().then((v) {
      listOpinion.clear();
      for (var i in v) {
        listOpinion.add(ComplainReason.fromJson(i));
      }
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }

  getListAreaByType(type) async {
    await APIReflection.getListAreaByType(type).then((v) {
      areas.clear();
      for (var i in v) {
        areas.add(Area.fromMap(i));
      }
    });
  }

  uploadImage(BuildContext context) async {
    return await APIAuth.uploadSingleFile(files: images, context: context)
        .then((v) {
      if (v.isNotEmpty) {
        for (var e in v) {
          submitedImages.add(
            FileTicket(id: e.data, name: e.name),
          );
        }
      }
    }).catchError((e) {
      throw (e);
    });
  }
}