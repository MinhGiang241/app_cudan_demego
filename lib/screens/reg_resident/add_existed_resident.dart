import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/services/api_resident_add_apartment.dart';
import 'package:app_cudan/widgets/primary_button.dart';
import 'package:app_cudan/widgets/primary_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../../models/dependence_sign_up.dart';
import '../../models/file_upload.dart';
import '../../models/relationship.dart';
import '../../models/resident_info.dart';
import '../../models/response_resident_own.dart';
import '../../services/api_relation.dart';
import '../../utils/utils.dart';
import 'register_resident_screen.dart';

class AddExistedResident extends StatefulWidget {
  final BuildContext ctx;
  const AddExistedResident({super.key, required this.ctx});
  @override
  State<AddExistedResident> createState() => _AddExistedResidentState();
}

class _AddExistedResidentState extends State<AddExistedResident> {
  ResponseResidentOwn? apartmentValue;
  ResponseResidentInfo? residentValue;
  String? relationValue;
  String? apartmentValidate;
  String? residentValidate;
  List<ResponseResidentInfo> listRes = [];
  List<RelationShip> relations = [];
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var residentId = context.read<ResidentInfoPrv>().residentId;

    var listApartment = context
        .read<ResidentInfoPrv>()
        .listOwn
        .where((i) => (i.type == "BUY" || i.type == 'RENT'))
        .map(
          (e) => DropdownMenuItem(
            value: e,
            child: Text(
              "${e.apartment!.name} - ${e.floor!.name} - ${e.building!.name}",
            ),
          ),
        )
        .toList();

    return FutureBuilder(
      future: () async {
        await APIResidentAddApartment.getDependentResident(residentId)
            .then((v) {
          listRes.clear();
          for (var i in v) {
            listRes.add(ResponseResidentInfo.fromJson(i));
          }
        });
        await APIRelation.preFetchDataRelation().then((v) {
          relations.clear();
          for (var i in v) {
            relations.add(RelationShip.fromMap(i));
          }
        });
      }(),
      builder: (context, snapshot) {
        var listRelationChoice = relations.map((v) {
          return DropdownMenuItem(
            value: v.id,
            child: Text(v.name ?? ""),
          );
        }).toList();
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
              vpad(12),
              PrimaryDropDown(
                onChange: (v) {
                  if (v != null) {
                    relationValue = v;
                  }
                },
                selectList: listRelationChoice,
                isRequired: true,
                label: S.of(context).relation_with_owner,
              ),
              vpad(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: PrimaryButton(
                      buttonSize: ButtonSize.small,
                      text: S.of(context).close,
                      buttonType: ButtonType.secondary,
                      secondaryBackgroundColor: redColor4,
                      textColor: redColor,
                      onTap: () async {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  hpad(3),
                  Expanded(
                    child: PrimaryButton(
                      isLoading: isLoading,
                      buttonSize: ButtonSize.small,
                      text: S.of(context).confirm,
                      onTap: () async {
                        Navigator.pop(context);
                        await onSubmit(context);
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

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
      if (relationValue == null) {
        listError.add(S.current.relation_not_empty);
      }
      if (listError.isNotEmpty) {
        throw (listError.join(', '));
      }

      DependenceSignUp formAddResident = DependenceSignUp(
        full_name: residentValue?.info_name,
        apartmentId: apartmentValue?.apartmentId,
        buildingId: apartmentValue?.buildingId,
        floorId: apartmentValue?.floorId,
        date_birth: residentValue?.date_birth,
        provinceId: residentValue?.provinceId,
        districtId: residentValue?.districtId,
        wardsId: residentValue?.wardsId,
        residentId: residentValue?.id,
        material_status: residentValue?.material_status,
        education: residentValue?.education,
        email: residentValue?.email,
        info_name: residentValue?.info_name,
        ethnicId: residentValue?.ethnicId,
        identity_card_required: residentValue?.identity_card,
        job: residentValue?.job,
        nationalId: residentValue?.nationalId,
        relationshipId: relationValue,
        qualification: residentValue?.qualification,
        phone_required: residentValue?.phone_required,
        dependentId: residentId,
        sent_date: DateTime.now().toIso8601String(),
        type:
            apartmentValue?.type == "BUY" ? "DEPENDENT_HOST" : "DEPENDENT_RENT",
        avatar: residentValue?.avatar != null
            ? residentValue?.avatar.runtimeType.toString() == "List<dynamic>"
                ? residentValue?.avatar
                    .map<FileUploadModel>((v) => FileUploadModel.fromMap(v))
                    .toList()
                : [
                    FileUploadModel(
                      id: residentValue?.avatar!,
                      name: residentValue?.avatar!,
                    )
                  ]
            : null,
        // identity_images: existedIdentityImages + uploadedIdentityImages,
        // upload: existedDoccuments + uploadedDocuments,
        place_of_issue: residentValue?.place_of_issue_required,
        residence_type: residentValue?.residence_type,
        sex: residentValue?.sex,
        // facebook: facebookController.text.trim(),
        // zalo: zaloController.text.trim(),
        // instagram: instagramController.text.trim(),
        // linkedin: linkedinController.text.trim(),
        // tiktok: tiktokController.text.trim(),
        status: "WAIT",
      );
      await APIResidentAddApartment.saveFormResidentAddApartment(
        formAddResident.toMap(),
      ).then((v) {
        Utils.showSuccessMessage(
          context: widget.ctx,
          e: S.of(widget.ctx).success_register_dependence,
          onClose: () {
            Navigator.pushNamedAndRemoveUntil(
              widget.ctx,
              RegisterResidentScreen.routeName,
              (route) => route.isFirst,
            );
          },
        );
      }).catchError((e) {
        Utils.showErrorMessage(widget.ctx, e.toString());
      });
    } catch (e) {
      Utils.showErrorMessage(widget.ctx, e.toString());
    }
  }
}
