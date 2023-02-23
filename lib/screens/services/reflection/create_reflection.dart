import 'package:app_cudan/screens/services/reflection/prv/reflection_prv.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_dropdown.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:app_cudan/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/select_file_widget.dart';
import '../../../widgets/select_media_widget.dart';
import 'prv/create_reflection_prv.dart';

class CreateReflection extends StatelessWidget {
  const CreateReflection({super.key});
  static const routeName = '/reflection/add';
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    var isEdit = arg['isEdit'] ?? false;
    return PrimaryScreen(
      appBar: PrimaryAppbar(
        title: S.of(context).add_reflection,
      ),
      body: ChangeNotifierProvider(
        create: (context) => CreateReflectionPrv(),
        builder: (context, child) {
          return FutureBuilder(
              future: context
                  .read<CreateReflectionPrv>()
                  .getReflectionReason(context),
              builder: (context, state) {
                var listZone =
                    context.read<CreateReflectionPrv>().areas.map((e) {
                  return DropdownMenuItem(
                    value: e.id,
                    child: Text(e.name ?? ""),
                  );
                }).toList();
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
                    child: Text(e.content ?? ""),
                  );
                }).toList();

                var listType = [
                  DropdownMenuItem(
                    value: "COMPLAIN",
                    child: Text(S.of(context).complain),
                  ),
                  DropdownMenuItem(
                    value: "FEEDBACK",
                    child: Text(S.of(context).feedback),
                  )
                ];
                var listAreaType = [
                  DropdownMenuItem(
                    value: "PIN",
                    child: Text(S.of(context).pin),
                  ),
                  DropdownMenuItem(
                    value: "BUILDING",
                    child: Text(S.of(context).building),
                  )
                ];
                return SafeArea(
                    child: Form(
                  autovalidateMode:
                      context.watch<CreateReflectionPrv>().autoValid
                          ? AutovalidateMode.onUserInteraction
                          : null,
                  key: context.read<CreateReflectionPrv>().formKey,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    children: [
                      vpad(12),
                      PrimaryDropDown(
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
                        label: S.of(context).note,
                        hint: S.of(context).note,
                        maxLines: 3,
                        controller:
                            context.read<CreateReflectionPrv>().noteController,
                      ),
                      vpad(12),
                      PrimaryDropDown(
                        validator: Utils.emptyValidatorDropdown,
                        isRequired: true,
                        validateString: context
                            .watch<CreateReflectionPrv>()
                            .validateZoneType,
                        onChange: context
                            .read<CreateReflectionPrv>()
                            .onSelectZoneType,
                        selectList: listAreaType,
                        label: S.of(context).zone_type,
                        hint: S.of(context).zone_type,
                        controller: context
                            .read<CreateReflectionPrv>()
                            .zoneTypeController,
                      ),
                      vpad(12),
                      PrimaryDropDown(
                        validator: Utils.emptyValidatorDropdown,
                        validateString:
                            context.watch<CreateReflectionPrv>().validateZone,
                        isRequired: true,
                        onChange:
                            context.read<CreateReflectionPrv>().onSelectZone,
                        dropKey:
                            context.read<CreateReflectionPrv>().dropdownKey,
                        selectList: listZone,
                        label: S.of(context).zone,
                        hint: S.of(context).zone,
                        controller:
                            context.read<CreateReflectionPrv>().zoneController,
                      ),
                      vpad(12),
                      SelectMediaWidget(
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
                      vpad(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          PrimaryButton(
                            isLoading: context
                                .watch<CreateReflectionPrv>()
                                .isAddNewLoading,
                            buttonSize: ButtonSize.medium,
                            text: isEdit
                                ? S.of(context).update
                                : S.of(context).add_new,
                            onTap: () {
                              context
                                  .read<CreateReflectionPrv>()
                                  .onSubmit(context, false);
                            },
                          ),
                          PrimaryButton(
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
                        ],
                      ),
                      vpad(40),
                    ],
                  ),
                ));
              });
        },
      ),
    );
  }
}
