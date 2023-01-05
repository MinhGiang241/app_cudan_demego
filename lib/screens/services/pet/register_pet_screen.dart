import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_dropdown.dart';
import 'package:app_cudan/widgets/primary_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/constants.dart';

import '../../../constants/regulation.dart';
import '../../../generated/l10n.dart';
import '../../../models/pet.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_screen.dart';
import '../../../widgets/select_file_widget.dart';
import '../../../widgets/select_media_widget.dart';
import 'prv/register_pet_prv.dart';

class RegisterPetScreen extends StatefulWidget {
  const RegisterPetScreen({super.key});
  static const routeName = '/pet/register';

  @override
  State<RegisterPetScreen> createState() => _RegisterPetScreenState();
}

class _RegisterPetScreenState extends State<RegisterPetScreen> {
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    var isEdit = arg['isEdit'];
    Pet pet = Pet();
    if (isEdit) {
      pet = arg['data'];
    }

    return ChangeNotifierProvider(
      create: (context) => RegisterPetPrv(existedPet: pet),
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
            value: "OTHER",
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
              onChanged: context.watch<RegisterPetPrv>().autoValid
                  ? () => context.read<RegisterPetPrv>().validate(context)
                  : null,
              autovalidateMode: context.watch<RegisterPetPrv>().autoValid
                  ? AutovalidateMode.onUserInteraction
                  : null,
              key: context.read<RegisterPetPrv>().formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    vpad(20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        S.of(context).pet_info,
                        style: txtBold(14, grayScaleColorBase),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    vpad(16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: PrimaryTextField(
                            maxLength: 255,
                            controller:
                                context.read<RegisterPetPrv>().nameController,
                            validateString:
                                context.watch<RegisterPetPrv>().validateName,
                            isRequired: true,
                            label: S.of(context).pet_name,
                            validator: (v) {
                              if (v!.isEmpty) {
                                return '';
                              }
                              return null;
                            },
                            hint: S.of(context).pet_name,
                          ),
                        ),
                        hpad(24),
                        Expanded(
                          child: PrimaryDropDown(
                            onChange:
                                context.read<RegisterPetPrv>().changeTypePet,
                            controller:
                                context.read<RegisterPetPrv>().typeController,
                            validateString:
                                context.watch<RegisterPetPrv>().validateType,
                            isRequired: true,
                            label: S.of(context).pet_type,
                            selectList: listPetTypes,
                            validator: (v) {
                              if (v == null) {
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: PrimaryTextField(
                            maxLength: 100,
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
                            maxLength: 100,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: PrimaryDropDown(
                            onChange:
                                context.read<RegisterPetPrv>().changeSexPet,
                            controller:
                                context.read<RegisterPetPrv>().sexController,
                            isRequired: true,
                            label: S.of(context).sex,
                            selectList: listPetSex,
                            validateString:
                                context.watch<RegisterPetPrv>().validateSex,
                            validator: (v) {
                              if (v == null) {
                                return '';
                              }

                              return null;
                            },
                          ),
                        ),
                        hpad(24),
                        Expanded(
                          child: PrimaryTextField(
                            filter: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9.,]'))
                            ],
                            controller:
                                context.read<RegisterPetPrv>().weightController,
                            validateString:
                                context.watch<RegisterPetPrv>().validateWeight,
                            isRequired: true,
                            label: '${S.of(context).weight} (kg)',
                            hint: S.of(context).weight,
                            keyboardType: TextInputType.number,
                            onChanged: (v) {
                              if (((double.tryParse(context
                                                  .read<RegisterPetPrv>()
                                                  .weightController
                                                  .text) !=
                                              null &&
                                          double.parse(context
                                                  .read<RegisterPetPrv>()
                                                  .weightController
                                                  .text) >=
                                              15) ||
                                      double.tryParse(context
                                              .read<RegisterPetPrv>()
                                              .weightController
                                              .text) ==
                                          null) &&
                                  context
                                      .read<RegisterPetPrv>()
                                      .weightController
                                      .text
                                      .isNotEmpty) {
                                context
                                    .read<RegisterPetPrv>()
                                    .weightController
                                    .text = '15';
                                context
                                        .read<RegisterPetPrv>()
                                        .weightController
                                        .selection =
                                    TextSelection(
                                        baseOffset: context
                                            .read<RegisterPetPrv>()
                                            .weightController
                                            .text
                                            .length,
                                        extentOffset: context
                                            .read<RegisterPetPrv>()
                                            .weightController
                                            .text
                                            .length);

                                setState(() {});
                              } else if (context
                                      .read<RegisterPetPrv>()
                                      .weightController
                                      .text
                                      .contains('.') &&
                                  context
                                          .read<RegisterPetPrv>()
                                          .weightController
                                          .text
                                          .split('.')
                                          .last
                                          .length >
                                      2) {
                                context
                                        .read<RegisterPetPrv>()
                                        .weightController
                                        .text =
                                    ((double.parse(v) * 100).floor() / 100)
                                        .toStringAsFixed(2);
                                context
                                        .read<RegisterPetPrv>()
                                        .weightController
                                        .selection =
                                    TextSelection(
                                        baseOffset: context
                                            .read<RegisterPetPrv>()
                                            .weightController
                                            .text
                                            .length,
                                        extentOffset: context
                                            .read<RegisterPetPrv>()
                                            .weightController
                                            .text
                                            .length);
                              }
                            },
                            validator: (v) {
                              var w = context
                                  .read<RegisterPetPrv>()
                                  .weightController
                                  .text
                                  .trim();
                              if (v!.isEmpty) {
                                return '';
                              } else if (double.tryParse(w) != null &&
                                  double.parse(w) == 0) {
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
                      maxLength: 1000,
                      controller:
                          context.read<RegisterPetPrv>().descriptionController,
                      label: S.of(context).description,
                      hint: S.of(context).description,
                      maxLines: 2,
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
                      existFiles: context
                          .watch<RegisterPetPrv>()
                          .exitedCertificateFiles,
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
                      onRemoveExist: context
                          .read<RegisterPetPrv>()
                          .removeExistedReportFile,
                      onRemove: context.read<RegisterPetPrv>().onRemoveReport,
                      files: context.watch<RegisterPetPrv>().reportFiles,
                      isRequired: true,
                      title: S.of(context).minutes,
                      onSelect: () => context
                          .read<RegisterPetPrv>()
                          .onSelectReport(context),
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
                          child: RichText(
                            text: TextSpan(
                                style: txtBodyMediumBold(
                                    color: grayScaleColorBase),
                                children: [
                                  TextSpan(text: S.of(context).i_agree),
                                  TextSpan(
                                    text: " ${S.of(context).regulations}",
                                    style:
                                        txtBodyMediumBold(color: primaryColor6),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        context
                                            .read<RegisterPetPrv>()
                                            .toogleShow();
                                      },
                                  ),
                                  TextSpan(
                                      text:
                                          " ${S.of(context).of_building_management}"),
                                ]),
                          ),
                        )
                      ],
                    ),
                    if (context.watch<RegisterPetPrv>().isShow) vpad(16),

                    if (context.watch<RegisterPetPrv>().isShow)
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: HtmlWidget(
                          petRegulation,
                          buildAsync: false,
                          onTapUrl: (url) {
                            launchUrl(Uri.parse(url));
                            return false;
                          },
                          textStyle: txtBodyMediumRegular(),
                        ),
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
                    // Container(
                    //   color: Colors.white,
                    //   padding: const EdgeInsets.symmetric(horizontal: 10),
                    //   child: HtmlWidget(
                    //     petRegulation,
                    //     buildAsync: false,
                    //     onTapUrl: (url) {
                    //       launchUrl(Uri.parse(url));
                    //       return false;
                    //     },
                    //     textStyle: txtBodyMediumRegular(),
                    //   ),
                    // ),
                    vpad(24),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
