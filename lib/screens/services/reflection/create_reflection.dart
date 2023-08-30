import 'package:app_cudan/models/info_content_view.dart';
import 'package:app_cudan/models/reflection.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_dropdown.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:app_cudan/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/select_media_widget.dart';
import 'prv/create_reflection_prv.dart';

class CreateReflection extends StatelessWidget {
  const CreateReflection({super.key});
  static const routeName = '/reflection/add';

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    var isEdit = arg['isEdit'] ?? false;
    var status = arg['status'];
    Reflection? ref = arg['ref'];
    return ChangeNotifierProvider(
      create: (context) => CreateReflectionPrv(context, ref),
      builder: (context, child) {
        var isUpdate = context.watch<CreateReflectionPrv>().isUpdate;

        return PrimaryScreen(
          appBar: PrimaryAppbar(
            title: isEdit
                ? isUpdate
                    ? S.of(context).edit_reflection
                    : S.of(context).reflection_details
                : S.of(context).add_reflection,
          ),
          body: FutureBuilder(
            future: context
                .read<CreateReflectionPrv>()
                .getReflectionReason(context),
            builder: (context, state) {
              // var listChoiceReason =
              //     context.read<CreateReflectionPrv>().listReasons.map((e) {
              //   return DropdownMenuItem(
              //     value: e.id,
              //     child: Text(e.content ?? ""),
              //   );
              // }).toList();
              var listChoiceOpinion =
                  context.read<CreateReflectionPrv>().listOpinion.map((e) {
                return DropdownMenuItem(
                  value: e.id,
                  child: Text(e.content ?? ''),
                );
              }).toList();

              var listType = [
                DropdownMenuItem(
                  value: 'COMPLAIN',
                  child: Text(S.of(context).complain),
                ),
                DropdownMenuItem(
                  value: 'FEEDBACK',
                  child: Text(S.of(context).feedback),
                ),
              ];
              var listAreaType = [
                DropdownMenuItem(
                  value: 'PIN',
                  child: Text(S.of(context).pin),
                ),
                DropdownMenuItem(
                  value: 'BUILDING',
                  child: Text(S.of(context).building),
                ),
              ];

              return SafeArea(
                child: Form(
                  onChanged: context.watch<CreateReflectionPrv>().autoValid
                      ? () => context
                          .read<CreateReflectionPrv>()
                          .onChangeFormValid(context)
                      : null,
                  autovalidateMode:
                      context.watch<CreateReflectionPrv>().autoValid
                          ? AutovalidateMode.onUserInteraction
                          : null,
                  key: context.read<CreateReflectionPrv>().formKey,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    children: [
                      vpad(12),
                      if (isEdit)
                        PrimaryTextField(
                          label: S.of(context).letter_num,
                          initialValue: ref?.code,
                          enable: !isEdit,
                        ),
                      if (isEdit) vpad(12),
                      if (isEdit && ref?.date != null)
                        PrimaryTextField(
                          label: S.of(context).date_send,
                          initialValue: Utils.dateFormat(ref!.date ?? '', 1),
                          enable: !isEdit,
                        ),
                      if (isEdit) vpad(12),
                      PrimaryDropDown(
                        enable: isUpdate,
                        isRequired: true,
                        validateString:
                            context.read<CreateReflectionPrv>().validateType,
                        controller:
                            context.read<CreateReflectionPrv>().typeController,
                        label: S.of(context).reflection_type,
                        selectList: listType,
                        validator: Utils.emptyValidatorDropdown,
                        onChange:
                            context.read<CreateReflectionPrv>().onSelectType,
                      ),
                      vpad(12),
                      PrimaryDropDown(
                        enable: isUpdate,
                        isRequired: true,
                        validateString:
                            context.read<CreateReflectionPrv>().validateReason,
                        label: S.of(context).reflection_reason,
                        selectList: listChoiceOpinion,
                        controller: context
                            .read<CreateReflectionPrv>()
                            .reasonController,
                        validator: Utils.emptyValidatorDropdown,
                        onChange:
                            context.read<CreateReflectionPrv>().onSelectReason,
                      ),
                      vpad(12),
                      PrimaryTextField(
                        isRequired: true,
                        validator: Utils.emptyValidator,
                        validateString: context
                            .watch<CreateReflectionPrv>()
                            .validateDescrible,
                        maxLength: 550,
                        enable: isUpdate,
                        label: S.of(context).description,
                        hint: (isEdit && !isUpdate)
                            ? ""
                            : S.of(context).description,
                        maxLines: 3,
                        controller: context
                            .read<CreateReflectionPrv>()
                            .describeController,
                      ),
                      vpad(12),
                      PrimaryDropDown(
                        enable: isUpdate,
                        validator: Utils.emptyValidatorDropdown,
                        isRequired: true,
                        validateString: context
                            .watch<CreateReflectionPrv>()
                            .validateZoneType,
                        onChange: (v) => context
                            .read<CreateReflectionPrv>()
                            .onSelectZoneType(context, v),
                        selectList: listAreaType,
                        label: S.of(context).zone_type,
                        hint: S.of(context).zone_type,
                        controller: context
                            .read<CreateReflectionPrv>()
                            .zoneTypeController,
                      ),
                      vpad(12),
                      PrimaryDropDown(
                        isMultiple: true,
                        selectMultileList:
                            context.watch<CreateReflectionPrv>().isFloor
                                ? context.read<CreateReflectionPrv>().floorList
                                : context.read<CreateReflectionPrv>().listZone,
                        enable: isUpdate,
                        validator: (v) {
                          if (context
                              .read<CreateReflectionPrv>()
                              .zoneValueList
                              .isEmpty) {
                            return '';
                          }
                          return null;
                        },
                        validateString:
                            context.watch<CreateReflectionPrv>().validateZone,
                        isRequired: true,
                        onSelectMulti:
                            context.read<CreateReflectionPrv>().onSelectMulti,

                        dropKey:
                            context.read<CreateReflectionPrv>().dropdownKey,
                        // selectList: listZone,
                        label: context.watch<CreateReflectionPrv>().isFloor
                            ? S.of(context).floor
                            : S.of(context).zone,
                        hint: context.watch<CreateReflectionPrv>().isFloor
                            ? S.of(context).floor
                            : S.of(context).zone,
                      ),
                      vpad(12),
                      SelectMediaWidget(
                        enable: isUpdate || !isEdit,
                        title: S.of(context).photos,
                        existImages:
                            context.watch<CreateReflectionPrv>().existedImage,
                        images: context.watch<CreateReflectionPrv>().images,
                        onRemove:
                            context.read<CreateReflectionPrv>().onRemoveImage,
                        onRemoveExist: context
                            .read<CreateReflectionPrv>()
                            .removeExistedImages,
                        onSelect: () => context
                            .read<CreateReflectionPrv>()
                            .onSelectImage(context),
                      ),
                      vpad(12),
                      if (isEdit)
                        PrimaryTextField(
                          textColor: genStatusColor(ref!.status ?? ''),
                          label: S.of(context).status,
                          enable: !isEdit,
                          initialValue: ref.s!.name,
                          textStyle: txtBold(14, genStatusColor(status)),
                        ),
                      // if (isEdit &&
                      //     ref!.cancel_reason != null &&
                      //     ref.r != null)
                      //   vpad(12),
                      // if (isEdit &&
                      //     ref!.cancel_reason != null &&
                      //     ref.r != null)
                      //   PrimaryTextField(
                      //     label: S.of(context).cancel_reason,
                      //     enable: !isEdit,
                      //     initialValue: ref.r!.name ?? '',
                      //   ),
                      vpad(20),
                      if (status == 'NEW' || !isEdit)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              flex: 10,
                              child: PrimaryButton(
                                buttonType: isEdit
                                    ? isUpdate
                                        ? ButtonType.cyan
                                        : isEdit
                                            ? ButtonType.yellow
                                            : ButtonType.yellow
                                    : null,
                                isLoading: context
                                    .watch<CreateReflectionPrv>()
                                    .isAddNewLoading,
                                buttonSize: ButtonSize.medium,
                                text: !isEdit
                                    ? S.of(context).add_new
                                    : isUpdate
                                        ? S.of(context).update
                                        : S.of(context).edit,

                                // isUpdate
                                //     ? S.of(context).update
                                //     : isEdit
                                //         ? S.of(context).edit
                                //         : S.of(context).add_new,
                                onTap: () {
                                  if (isUpdate) {
                                    context
                                        .read<CreateReflectionPrv>()
                                        .onSubmit(context, false);
                                  } else {
                                    context
                                        .read<CreateReflectionPrv>()
                                        .enableUpdate();
                                  }
                                },
                              ),
                            ),
                            Expanded(flex: 1, child: hpad(0)),
                            Expanded(
                              flex: 10,
                              child: PrimaryButton(
                                isLoading: context
                                    .watch<CreateReflectionPrv>()
                                    .isSendApproveLoading,
                                buttonSize: ButtonSize.medium,
                                buttonType: ButtonType.green,
                                text: S.of(context).send_reflection,
                                onTap: () {
                                  context
                                      .read<CreateReflectionPrv>()
                                      .onSubmit(context, true);
                                },
                              ),
                            ),
                          ],
                        ),
                      if (status == 'WAIT_PROGRESS')
                        PrimaryButton(
                          buttonType: ButtonType.red,
                          isLoading: context
                              .watch<CreateReflectionPrv>()
                              .isCancelLoading,
                          text: S.of(context).cancel_reflection,
                          onTap: () => context
                              .read<CreateReflectionPrv>()
                              .cancelLetter(context),
                        ),
                      vpad(40),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
