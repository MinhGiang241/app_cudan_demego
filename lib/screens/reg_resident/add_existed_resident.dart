import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/services/api_resident_add_apartment.dart';
import 'package:app_cudan/widgets/primary_button.dart';
import 'package:app_cudan/widgets/primary_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../../models/file_upload.dart';
import '../../models/form_add_resident.dart';
import '../../models/resident_info.dart';
import '../../models/response_resident_own.dart';
import '../../utils/utils.dart';
import 'register_resident_screen.dart';

class AddExistedResident extends StatefulWidget {
  const AddExistedResident({super.key, required this.ctx});
  final BuildContext ctx;
  @override
  State<AddExistedResident> createState() => _AddExistedResidentState();
}

class _AddExistedResidentState extends State<AddExistedResident> {
  ResponseResidentOwn? apartmentValue;
  ResponseResidentInfo? residentValue;
  String? apartmentValidate;
  String? residentValidate;
  List<ResponseResidentInfo> listRes = [];
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  onSubmit(BuildContext context) async {
    var residentId = context.read<ResidentInfoPrv>().residentId;
    try {
      var listError = [];
      if (apartmentValue == null) {
        listError.add(S.current.apartment_not_empty);
      }
      if (residentValue == null) {
        listError.add(S.current.resident_not_empty);
      }
      if (listError.isNotEmpty) {
        throw (listError.join(', '));
      }

      FormAddResidence formAddResident = FormAddResidence(
        apartmentId: apartmentValue?.apartmentId,
        buildingId: apartmentValue?.buildingId,
        floorId: apartmentValue?.floorId,
        date_birth: residentValue?.date_birth,
        provinceId: residentValue?.provinceId,
        districtId: residentValue?.districtId,
        wardsId: residentValue?.wardsId,
        residentId: residentId,
        material_status: residentValue?.material_status,
        education: residentValue?.education,
        email: residentValue?.email,
        info_name: residentValue?.email,
        ethnicId: residentValue?.ethnicId,
        identity_card_required: residentValue?.identity_card,
        job: residentValue?.job,
        nationalId: residentValue?.nationalId,
        relationshipId: residentValue?.m,
        qualification: residentValue?.qualification,
        phone_required: residentValue?.phone_required,
        resident_images: residentValue?.avatar != null
            ? [
                FileUploadModel(
                    id: residentValue?.avatar!, name: residentValue?.avatar!)
              ]
            : null,
        // identity_images: existedIdentityImages + uploadedIdentityImages,
        // upload: existedDoccuments + uploadedDocuments,
        place_of_issue_required: residentValue?.place_of_issue_required,
        residence_type: residentValue?.residence_type,
        sex: residentValue?.sex,
        // facebook: facebookController.text.trim(),
        // zalo: zaloController.text.trim(),
        // instagram: instagramController.text.trim(),
        // linkedin: linkedinController.text.trim(),
        // tiktok: tiktokController.text.trim(),
        status: "NEW",
      );
      await APIResidentAddApartment.saveFormResidentAddApartment(
              formAddResident.toMap())
          .then((v) {
        Utils.showSuccessMessage(
            context: widget.ctx,
            e: S.of(widget.ctx).success_register_dependence,
            onClose: () {
              Navigator.pushNamedAndRemoveUntil(widget.ctx,
                  RegisterResidentScreen.routeName, (route) => route.isFirst);
            });
      }).catchError((e) {
        Utils.showErrorMessage(widget.ctx, e.toString());
      });
    } catch (e) {
      Utils.showErrorMessage(widget.ctx, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var residentId = context.read<ResidentInfoPrv>().residentId;

    var listApartment = context
        .read<ResidentInfoPrv>()
        .listOwn
        .where((i) => i.type == "BUY")
        .map((e) => DropdownMenuItem(
              value: e,
              child: Text(
                  "${e.apartment!.name} - ${e.floor!.name} - ${e.building!.name}"),
            ))
        .toList();

    return FutureBuilder(future: () async {
      await APIResidentAddApartment.getDependentResident(residentId).then((v) {
        listRes.clear();
        for (var i in v) {
          listRes.add(ResponseResidentInfo.fromJson(i));
        }
      });
    }(), builder: (context, snapshot) {
      var listResChoice = listRes.map((v) {
        return DropdownMenuItem(
          value: v,
          child: Text(v.info_name ?? ""),
        );
      }).toList();
      return Form(
        key: formKey,
        child: Column(
          children: [
            vpad(12),
            PrimaryDropDown(
              onChange: (v) {
                if (v != null) {
                  apartmentValue = v;
                }
              },
              isDense: false,
              isRequired: true,
              selectList: listApartment,
              label: S.of(context).apartment_add_resident,
            ),
            vpad(12),
            PrimaryDropDown(
              onChange: (v) {
                if (v != null) {
                  residentValue = v;
                }
              },
              selectList: listResChoice,
              isRequired: true,
              label: S.of(context).dependent_person,
            ),
            vpad(16),
            PrimaryButton(
              isLoading: isLoading,
              buttonSize: ButtonSize.medium,
              text: S.of(context).confirm,
              onTap: () async {
                Navigator.pop(context);
                await onSubmit(context);
              },
            )
          ],
        ),
      );
    });
  }
}
