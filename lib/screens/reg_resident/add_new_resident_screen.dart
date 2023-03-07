import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_button.dart';
import 'package:app_cudan/widgets/primary_dropdown.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:app_cudan/widgets/primary_text_field.dart';
import 'package:app_cudan/widgets/select_file_widget.dart';
import 'package:app_cudan/widgets/select_media_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:horizontal_blocked_scroll_physics/horizontal_blocked_scroll_physics.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../../utils/utils.dart';
import '../../widgets/primary_icon.dart';
import '../auth/prv/resident_info_prv.dart';
import 'prv/add_new_resident_prv.dart';

class AddNewResidentScreen extends StatefulWidget {
  const AddNewResidentScreen({super.key});
  static const routeName = '/reg_resident/add';

  @override
  State<AddNewResidentScreen> createState() => _AddNewResidentScreenState();
}

class _AddNewResidentScreenState extends State<AddNewResidentScreen>
    with AutomaticKeepAliveClientMixin<AddNewResidentScreen> {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddNewResidentPrv(),
      builder: (context, child) {
        var activeStep = context.watch<AddNewResidentPrv>().activeStep;
        var listApartmentChoice =
            context.read<ResidentInfoPrv>().listOwn.map((e) {
          return DropdownMenuItem(
            value: e.apartmentId,
            child: Text(e.apartment?.name! != null
                ? '${e.apartment?.name} - ${e.floor?.name} - ${e.building?.name}'
                : e.apartmentId!),
          );
        }).toList();

        var listSex = [
          DropdownMenuItem(
            value: "MALE",
            child: Text(S.of(context).male),
          ),
          DropdownMenuItem(
            value: "FEMALE",
            child: Text(S.of(context).female),
          ),
          DropdownMenuItem(
            value: "OTHER",
            child: Text(S.of(context).other),
          ),
        ];
        var listResType = [
          DropdownMenuItem(
            value: "RESIDENT",
            child: Text(S.of(context).per_res),
          ),
          DropdownMenuItem(
            value: "STAYING",
            child: Text(S.of(context).temp_res),
          ),
          DropdownMenuItem(
            value: "STAYINGFOREIGN",
            child: Text(S.of(context).temp_res_foreigner),
          ),
        ];

        return PrimaryScreen(
            isPadding: false,
            appBar: PrimaryAppbar(
              title: S.of(context).add_dependent_person,
            ),
            body: SafeArea(
              child: FutureBuilder(
                future: context.read<AddNewResidentPrv>().preFetchData(context),
                builder: (context, snapshot) {
                  var listRelationChoice =
                      context.watch<AddNewResidentPrv>().relations.map((v) {
                    return DropdownMenuItem(
                      value: v.id,
                      child: Text(v.name ?? ""),
                    );
                  }).toList();
                  var listProvinceChoice =
                      context.read<AddNewResidentPrv>().provinces.map((e) {
                    return DropdownMenuItem(
                      value: e.code,
                      child: Text(e.name ?? ""),
                    );
                  }).toList();
                  var listDistricChoice =
                      context.watch<AddNewResidentPrv>().districs.map((e) {
                    return DropdownMenuItem(
                      value: e.code,
                      child: Text(e.name ?? ""),
                    );
                  }).toList();
                  var listWardChoice =
                      context.watch<AddNewResidentPrv>().wards.map((e) {
                    return DropdownMenuItem(
                      value: e.code,
                      child: Text(e.name ?? ""),
                    );
                  }).toList();
                  return Column(children: [
                    Row(
                      children: [
                        Container(
                          color: Colors.white,
                          width: dvWidth(context) / 2,
                          height: 50,
                          child: Center(
                            child: Text(
                              S.of(context).base_info,
                              style: txtBold(
                                  14,
                                  activeStep == 0
                                      ? grayScaleColorBase
                                      : activeStep > 0
                                          ? greenColorBase
                                          : grayScaleColor4),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          width: dvWidth(context) / 2,
                          height: 50,
                          child: Center(
                            child: Text(
                              S.of(context).other_info,
                              style: txtBold(
                                14,
                                activeStep == 1
                                    ? grayScaleColorBase
                                    : activeStep > 2
                                        ? greenColorBase
                                        : grayScaleColor4,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    vpad(2),
                    LinearProgressIndicator(
                      backgroundColor: primaryColorBase.withOpacity(0.1),
                      color: primaryColorBase,
                      value:
                          (context.watch<AddNewResidentPrv>().activeStep + 1) /
                              2,
                    ),
                    Expanded(
                        child: PageView(
                      physics:
                          context.watch<AddNewResidentPrv>().isDisableRightCroll
                              ? const LeftBlockedScrollPhysics()
                              : null,
                      controller: context.read<AddNewResidentPrv>().controller,
                      onPageChanged:
                          context.read<AddNewResidentPrv>().onPageChanged,
                      children: <Widget>[
                        Form(
                          onChanged:
                              context.watch<AddNewResidentPrv>().autoValidStep1
                                  ? () => context
                                      .read<AddNewResidentPrv>()
                                      .validate1(context)
                                  : null,
                          autovalidateMode:
                              context.watch<AddNewResidentPrv>().autoValidStep1
                                  ? AutovalidateMode.onUserInteraction
                                  : null,
                          key: context.read<AddNewResidentPrv>().formKey1,
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.only(
                              left: 24,
                              right: 24,
                            ),
                            child: Column(
                              children: [
                                vpad(12),
                                PrimaryDropDown(
                                  onChange: context
                                      .read<AddNewResidentPrv>()
                                      .onSellectApartment,
                                  validator: Utils.emptyValidatorDropdown,
                                  value: context
                                      .watch<AddNewResidentPrv>()
                                      .apartmentAddValue,
                                  isDense: false,
                                  selectList: listApartmentChoice,
                                  validateString: context
                                      .watch<AddNewResidentPrv>()
                                      .apartmentAddValidate,
                                  label: S.of(context).apartment_add_resident,
                                  isRequired: true,
                                ),
                                vpad(12),
                                PrimaryTextField(
                                  validator: Utils.emptyValidator,
                                  controller: context
                                      .read<AddNewResidentPrv>()
                                      .nameController,
                                  validateString: context
                                      .watch<AddNewResidentPrv>()
                                      .nameValidate,
                                  label: S.of(context).full_name,
                                  isRequired: true,
                                  hint: S.of(context).full_name,
                                ),
                                vpad(12),
                                PrimaryDropDown(
                                  onChange: context
                                      .read<AddNewResidentPrv>()
                                      .onSellectRelation,
                                  validator: Utils.emptyValidatorDropdown,
                                  value: context
                                      .watch<AddNewResidentPrv>()
                                      .relationValue,
                                  selectList: listRelationChoice,
                                  validateString: context
                                      .watch<AddNewResidentPrv>()
                                      .relationValidate,
                                  label: S.of(context).relation_with_owner,
                                  isRequired: true,
                                ),
                                vpad(12),
                                PrimaryDropDown(
                                  onChange: context
                                      .read<AddNewResidentPrv>()
                                      .onSellectSex,
                                  validator: Utils.emptyValidatorDropdown,
                                  value: context
                                      .watch<AddNewResidentPrv>()
                                      .sexValue,
                                  selectList: listSex,
                                  validateString: context
                                      .watch<AddNewResidentPrv>()
                                      .sexValidate,
                                  label: S.of(context).sex,
                                  isRequired: true,
                                ),
                                vpad(12),
                                PrimaryTextField(
                                  onTap: () => context
                                      .read<AddNewResidentPrv>()
                                      .pickBirthDay(context),
                                  isReadOnly: true,
                                  hint: "dd/mm/yyyy",
                                  suffixIcon: const PrimaryIcon(
                                      icons: PrimaryIcons.calendar),
                                  validator: Utils.emptyValidator,
                                  controller: context
                                      .read<AddNewResidentPrv>()
                                      .birthController,
                                  validateString: context
                                      .watch<AddNewResidentPrv>()
                                      .birthValidate,
                                  label: S.of(context).dob,
                                  isRequired: true,
                                ),
                                vpad(12),
                                PrimaryTextField(
                                  validator: Utils.emptyValidator,
                                  controller: context
                                      .read<AddNewResidentPrv>()
                                      .identityController,
                                  validateString: context
                                      .watch<AddNewResidentPrv>()
                                      .identityValidate,
                                  label: S.of(context).cmnd,
                                  hint: S.of(context).cmnd,
                                  isRequired: true,
                                ),
                                vpad(12),
                                PrimaryTextField(
                                  validator: Utils.emptyValidator,
                                  controller: context
                                      .read<AddNewResidentPrv>()
                                      .issuePlaceController,
                                  label: S.of(context).place_issue,
                                  hint: S.of(context).place_issue,
                                ),
                                vpad(12),
                                PrimaryTextField(
                                  validator: Utils.emptyValidator,
                                  controller: context
                                      .read<AddNewResidentPrv>()
                                      .nationalityController,
                                  validateString: context
                                      .watch<AddNewResidentPrv>()
                                      .nationalityValidate,
                                  label: S.of(context).nationality,
                                  hint: S.of(context).nationality,
                                  isRequired: true,
                                ),
                                vpad(12),
                                PrimaryDropDown(
                                  onChange: context
                                      .read<AddNewResidentPrv>()
                                      .onSellectType,
                                  validator: Utils.emptyValidatorDropdown,
                                  value: context
                                      .watch<AddNewResidentPrv>()
                                      .resTypeValue,
                                  selectList: listResType,
                                  validateString: context
                                      .watch<AddNewResidentPrv>()
                                      .resTypeValidate,
                                  label: S.of(context).resident_type,
                                  isRequired: true,
                                ),
                                vpad(12),
                                PrimaryDropDown(
                                  isFull: true,
                                  validator: Utils.emptyValidatorDropdown,
                                  value: context
                                      .watch<AddNewResidentPrv>()
                                      .provinceValue,
                                  onChange: context
                                      .read<AddNewResidentPrv>()
                                      .onChangeProvince,
                                  selectList: listProvinceChoice,
                                  validateString: context
                                      .watch<AddNewResidentPrv>()
                                      .provValidate,
                                  label: S.of(context).prov_city,
                                  isRequired: true,
                                ),
                                vpad(12),
                                PrimaryDropDown(
                                  validator: Utils.emptyValidatorDropdown,
                                  value: context
                                      .watch<AddNewResidentPrv>()
                                      .districtValue,
                                  isFull: true,
                                  onChange: context
                                      .read<AddNewResidentPrv>()
                                      .onChangeDistrict,
                                  selectList: listDistricChoice,
                                  validateString: context
                                      .watch<AddNewResidentPrv>()
                                      .districtValidate,
                                  label: S.of(context).ward,
                                  isRequired: true,
                                ),
                                vpad(12),
                                PrimaryDropDown(
                                  onChange: context
                                      .read<AddNewResidentPrv>()
                                      .onSellectWard,
                                  validator: Utils.emptyValidatorDropdown,
                                  value: context
                                      .watch<AddNewResidentPrv>()
                                      .wardValue,
                                  isFull: true,
                                  selectList: listWardChoice,
                                  validateString: context
                                      .watch<AddNewResidentPrv>()
                                      .wardValidate,
                                  label: S.of(context).block,
                                  isRequired: true,
                                ),
                                vpad(12),
                                SelectMediaWidget(
                                  onSelect: () => context
                                      .read<AddNewResidentPrv>()
                                      .onSelectResImages(context),
                                  existImages: context
                                      .watch<AddNewResidentPrv>()
                                      .existedResImages,
                                  images: context
                                      .watch<AddNewResidentPrv>()
                                      .resImages,
                                  onRemove: context
                                      .read<AddNewResidentPrv>()
                                      .onRemoveResImages,
                                  onRemoveExist: context
                                      .read<AddNewResidentPrv>()
                                      .onRemoveExistedResImages,
                                  isRequired: true,
                                  title: S.of(context).res_photo,
                                ),
                                vpad(12),
                                SelectMediaWidget(
                                  onSelect: () => context
                                      .read<AddNewResidentPrv>()
                                      .onSelectIdentityImages(context),
                                  existImages: context
                                      .watch<AddNewResidentPrv>()
                                      .existedIdentityImages,
                                  images: context
                                      .watch<AddNewResidentPrv>()
                                      .identityImages,
                                  onRemove: context
                                      .read<AddNewResidentPrv>()
                                      .onRemoveIdentityImage,
                                  onRemoveExist: context
                                      .read<AddNewResidentPrv>()
                                      .onRemoveExistedIdentityImage,
                                  title: S.of(context).identity_photo,
                                ),
                                vpad(12),
                                SelectFileWidget(
                                  onSelect: () => context
                                      .read<AddNewResidentPrv>()
                                      .onSelectDocuments(context),
                                  existFiles: context
                                      .watch<AddNewResidentPrv>()
                                      .existedDoccuments,
                                  files: context
                                      .watch<AddNewResidentPrv>()
                                      .documents,
                                  onRemove: context
                                      .read<AddNewResidentPrv>()
                                      .onRemoveDocuments,
                                  onRemoveExist: context
                                      .read<AddNewResidentPrv>()
                                      .onRemoveExistedDocuments,
                                  title: S.of(context).attachment_file,
                                ),
                                vpad(20),
                                PrimaryButton(
                                  width: double.infinity,
                                  text: S.of(context).next,
                                  onTap: () {
                                    context
                                        .read<AddNewResidentPrv>()
                                        .onStep1Next(context);
                                  },
                                ),
                                vpad(50)
                              ],
                            ),
                          ),
                        ),
                        Form(
                          onChanged:
                              context.watch<AddNewResidentPrv>().autoValidStep1
                                  ? () => context
                                      .read<AddNewResidentPrv>()
                                      .validate2(context)
                                  : null,
                          autovalidateMode:
                              context.watch<AddNewResidentPrv>().autoValidStep2
                                  ? AutovalidateMode.onUserInteraction
                                  : null,
                          key: context.read<AddNewResidentPrv>().formKey2,
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.only(
                              left: 24,
                              right: 24,
                            ),
                            child: Column(children: [
                              vpad(12),
                              PrimaryTextField(
                                label: S.of(context).phone_num,
                                hint: S.of(context).phone_num,
                              ),
                              vpad(12),
                              PrimaryTextField(
                                label: S.of(context).email,
                                hint: S.of(context).email,
                              ),
                              vpad(12),
                              PrimaryTextField(
                                label: S.of(context).education_level,
                                hint: S.of(context).education_level,
                              ),
                              vpad(12),
                              PrimaryTextField(
                                label: S.of(context).job,
                                hint: S.of(context).job,
                              ),
                              vpad(12),
                              PrimaryDropDown(
                                label: S.of(context).ethnic,
                                hint: S.of(context).ethnic,
                              ),
                              vpad(20),
                              Text(S.of(context).social_media),
                              vpad(16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Align(
                                      alignment: Alignment.center,
                                      child: PrimaryIcon(
                                          icons: PrimaryIcons.facebook)),
                                  hpad(12),
                                  Expanded(
                                      child: PrimaryTextField(
                                    label: "",
                                  ))
                                ],
                              )
                            ]),
                          ),
                        ),
                      ],
                    )),
                  ]);
                },
              ),
            ));
      },
    );
  }
}
