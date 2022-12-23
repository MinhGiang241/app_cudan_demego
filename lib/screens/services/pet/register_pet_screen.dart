import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_dropdown.dart';
import 'package:app_cudan/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../widgets/dropdown_textField.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_screen.dart';
import '../../../widgets/select_file_widget.dart';
import '../../../widgets/select_media_widget.dart';
import 'prv/register_pet_prv.dart';

class RegisterPetScreen extends StatelessWidget {
  const RegisterPetScreen({super.key});
  static const routeName = '/pet/register';

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    var isEdit = arg['isEdit'];
    return ChangeNotifierProvider(
      create: (context) => RegisterPetPrv(),
      builder: (context, builder) {
        var listPetSex = [
          DropdownMenuItem(
            value: "MALE",
            child: Text(S.of(context).pet_male),
          ),
          DropdownMenuItem(
            value: "FEMALE",
            child: Text(S.of(context).pet_female),
          ),
          DropdownMenuItem(
            value: "Other",
            child: Text(S.of(context).other),
          ),
        ];
        var listPetTypes = [
          DropdownMenuItem(
            value: "DOG",
            child: Text(S.of(context).dog),
          ),
          DropdownMenuItem(
            value: "CAT",
            child: Text(S.of(context).cat),
          ),
          DropdownMenuItem(
            value: "Other",
            child: Text(S.of(context).other),
          ),
        ];
        return PrimaryScreen(
          appBar: PrimaryAppbar(
            title: isEdit ? S.of(context).edit_reg_pet : S.of(context).reg_pet,
          ),
          body: SafeArea(
            child: Form(
              key: context.watch<RegisterPetPrv>().formKey,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  DropDownTextFiled(),
                  vpad(20),
                  Row(
                    children: [
                      Expanded(
                        child: DropDownTextFiled(
                          label: "ksks",
                          isRequired: true,
                        ),
                      ),
                      hpad(24),
                      Expanded(
                        child: DropDownTextFiled(
                          label: "ksks",
                          isRequired: true,
                        ),
                      )
                    ],
                  ),
                  vpad(20),
                  Text(
                    S.of(context).pet_info,
                    style: txtMedium(14, grayScaleColorBase),
                  ),
                  vpad(16),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryTextField(
                          controller:
                              context.read<RegisterPetPrv>().nameController,
                          validateString:
                              context.watch<RegisterPetPrv>().validateName,
                          isRequired: true,
                          label: S.of(context).pet_name,
                          hint: S.of(context).pet_name,
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
                        child: PrimaryDropDown(
                          // controller:
                          //     context.read<RegisterPetPrv>().nameController,
                          // validateString:
                          //     context.watch<RegisterPetPrv>().validateName,
                          isRequired: true,
                          label: S.of(context).pet_type,
                          selectList: listPetTypes,
                          // validator: (v) {
                          //   // if (v!.isEmpty) {
                          //   //   return '';
                          //   // }
                          //   return '';
                          // },
                        ),
                      ),
                    ],
                  ),
                  vpad(16),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryTextField(
                          controller:
                              context.read<RegisterPetPrv>().colorController,
                          validateString:
                              context.watch<RegisterPetPrv>().validateColor,
                          isRequired: true,
                          label: S.of(context).color,
                          hint: S.of(context).color,
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
                          controller:
                              context.read<RegisterPetPrv>().originController,
                          validateString:
                              context.watch<RegisterPetPrv>().validateOrigin,
                          isRequired: true,
                          label: S.of(context).pet_origin,
                          hint: S.of(context).pet_origin,
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
                  vpad(16),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryDropDown(
                          isRequired: true,
                          label: S.of(context).sex,
                          selectList: listPetSex,
                        ),
                      ),
                      hpad(24),
                      Expanded(
                        child: PrimaryTextField(
                          controller:
                              context.read<RegisterPetPrv>().weightController,
                          validateString:
                              context.watch<RegisterPetPrv>().validateWeight,
                          isRequired: true,
                          label: '${S.of(context).weight} (kg)',
                          hint: S.of(context).weight,
                          keyboardType: TextInputType.number,
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
                  vpad(16),
                  PrimaryTextField(
                    controller:
                        context.read<RegisterPetPrv>().descriptionController,
                    label: S.of(context).description,
                    hint: S.of(context).description,
                    maxLines: 2,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return '';
                      }
                      return null;
                    },
                  ),
                  vpad(16),
                  SelectMediaWidget(
                    title: S.of(context).photos,
                    existImages: context.watch<RegisterPetPrv>().existedImage,
                    images: context.watch<RegisterPetPrv>().imagesPet,
                    onRemove: context.read<RegisterPetPrv>().onRemoveImagePet,
                    onRemoveExist:
                        context.read<RegisterPetPrv>().removeExistedImages,
                    onSelect: () => context
                        .read<RegisterPetPrv>()
                        .onSelectImagePet(context),
                  ),
                  vpad(16),
                  SelectFileWidget(
                    existFiles:
                        context.watch<RegisterPetPrv>().exitedCertificateFiles,
                    onRemoveExist: context
                        .read<RegisterPetPrv>()
                        .removeExistedCertificateFile,
                    onRemove:
                        context.read<RegisterPetPrv>().onRemoveCertificate,
                    files: context.watch<RegisterPetPrv>().certificateFiles,
                    isRequired: true,
                    title: S.of(context).cer_vacxin_doc,
                    onSelect: () => context
                        .read<RegisterPetPrv>()
                        .onSelectCertificate(context),
                  ),
                  vpad(16),
                  SelectFileWidget(
                    existFiles:
                        context.watch<RegisterPetPrv>().existedReportFiles,
                    onRemoveExist:
                        context.read<RegisterPetPrv>().removeExistedReportFile,
                    onRemove: context.read<RegisterPetPrv>().onRemoveReport,
                    files: context.watch<RegisterPetPrv>().reportFiles,
                    isRequired: true,
                    title: S.of(context).minutes,
                    onSelect: () =>
                        context.read<RegisterPetPrv>().onSelectReport(context),
                  ),
                  vpad(16),
                  Row(
                    children: [
                      SizedBox(
                        width: 22.0,
                        height: 22.0,
                        child: Checkbox(
                          fillColor:
                              MaterialStateProperty.all(primaryColorBase),
                          value: context.watch<RegisterPetPrv>().isAgree,
                          onChanged: (v) {
                            context.read<RegisterPetPrv>().onAgree();
                          },
                        ),
                      ),
                      hpad(12),
                      Expanded(
                          child: InkWell(
                        onTap: context.read<RegisterPetPrv>().onAgree,
                        child: RichText(
                          text: TextSpan(
                              style: txtBodyMediumRegular(
                                  color: grayScaleColorBase),
                              children: [
                                TextSpan(text: S.of(context).i_agree),
                                TextSpan(
                                    text: " ${S.of(context).regulations}",
                                    style: txtBodyMediumRegular(
                                        color: primaryColor6)),
                                TextSpan(
                                    text:
                                        " ${S.of(context).of_building_management}"),
                              ]),
                        ),
                      )),
                    ],
                  ),
                  vpad(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      PrimaryButton(
                        isLoading:
                            context.watch<RegisterPetPrv>().isAddNewLoading,
                        buttonSize: ButtonSize.medium,
                        text: isEdit
                            ? S.of(context).update
                            : S.of(context).add_new,
                        onTap: () => context
                            .read<RegisterPetPrv>()
                            .onSendSummitPet(context, false),
                      ),
                      PrimaryButton(
                        isLoading: context
                            .watch<RegisterPetPrv>()
                            .isSendApproveLoading,
                        buttonType: ButtonType.green,
                        buttonSize: ButtonSize.medium,
                        text: S.of(context).send_request,
                        onTap: () => context
                            .read<RegisterPetPrv>()
                            .onSendSummitPet(context, true),
                      ),
                    ],
                  ),
                  vpad(24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
