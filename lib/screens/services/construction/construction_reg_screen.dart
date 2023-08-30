import 'package:app_cudan/constants/regex_text.dart';
import 'package:app_cudan/models/construction.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_button.dart';
import 'package:app_cudan/widgets/primary_dropdown.dart';
import 'package:app_cudan/widgets/primary_text_field.dart';
import 'package:app_cudan/widgets/select_file_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:horizontal_blocked_scroll_physics/horizontal_blocked_scroll_physics.dart';
import 'package:provider/provider.dart';
import '../../../constants/constants.dart';
import '../../../constants/regulation.dart';
import '../../../generated/l10n.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_icon.dart';
import '../../../widgets/primary_screen.dart';
import '../../auth/prv/resident_info_prv.dart';
import 'prv/construction_reg_prv.dart';

class ConstructionRegScreen extends StatefulWidget {
  const ConstructionRegScreen({Key? key}) : super(key: key);
  static const routeName = '/construction/create';

  @override
  _ConstructionRegScreenState createState() => _ConstructionRegScreenState();
}

class _ConstructionRegScreenState extends State<ConstructionRegScreen>
    with AutomaticKeepAliveClientMixin<ConstructionRegScreen> {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final arg = ModalRoute.of(context)!.settings.arguments as Map?;
    var isEdit = false;
    ConstructionRegistration? data;
    if (arg != null) {
      isEdit = arg['isEdit'] ?? false;
      data = arg['data'];
    }

    return ChangeNotifierProvider(
      create: (context) => ConstructionRegPrv(existedConReg: data),
      builder: (context, state) {
        var activeStep = context.watch<ConstructionRegPrv>().activeStep;

        return PrimaryScreen(
          isPadding: false,
          appBar: PrimaryAppbar(
            title:
                isEdit ? S.of(context).edit_reg_const : S.of(context).reg_const,
          ),
          body: SafeArea(
            child: FutureBuilder(
              future: context
                  .read<ConstructionRegPrv>()
                  .getConstructionTypeList(context),
              builder: (context, snapshot) {
                var listApartmentChoice =
                    context.read<ResidentInfoPrv>().listOwn.map((e) {
                  return DropdownMenuItem(
                    value: e.apartmentId,
                    child: Text(
                      e.apartment?.name! != null
                          ? '${e.apartment?.name} - ${e.floor?.name} - ${e.building?.name}'
                          : e.apartmentId!,
                    ),
                  );
                }).toList();
                var listType = context
                    .read<ConstructionRegPrv>()
                    .listConstructionType
                    .map((e) {
                  return DropdownMenuItem(
                    value: e.id,
                    child: Text(e.name ?? e.code ?? ""),
                  );
                }).toList();
                return Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          color: Colors.white,
                          width: dvWidth(context) / 3,
                          height: 50,
                          child: Center(
                            child: Text(
                              S.of(context).step1,
                              style: txtBold(
                                14,
                                activeStep == 0
                                    ? grayScaleColorBase
                                    : activeStep > 0
                                        ? greenColorBase
                                        : grayScaleColor4,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          width: dvWidth(context) / 3,
                          height: 50,
                          child: Center(
                            child: Text(
                              S.of(context).step2,
                              style: txtBold(
                                14,
                                activeStep == 1
                                    ? grayScaleColorBase
                                    : activeStep > 1
                                        ? greenColorBase
                                        : grayScaleColor4,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          width: dvWidth(context) / 3,
                          height: 50,
                          child: Center(
                            child: Text(
                              S.of(context).step3,
                              style: txtBold(
                                14,
                                activeStep == 2
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
                          (context.watch<ConstructionRegPrv>().activeStep + 1) /
                              3,
                    ),
                    Expanded(
                      child: PageView(
                        physics: context
                                .watch<ConstructionRegPrv>()
                                .isDisableRightCroll
                            ? const LeftBlockedScrollPhysics()
                            : null,
                        controller:
                            context.read<ConstructionRegPrv>().controller,
                        onPageChanged:
                            context.read<ConstructionRegPrv>().onPageChanged,
                        children: <Widget>[
                          Form(
                            onChanged: context
                                    .watch<ConstructionRegPrv>()
                                    .autoValidStep1
                                ? () => context
                                    .read<ConstructionRegPrv>()
                                    .validate1(context)
                                : null,
                            autovalidateMode: context
                                    .watch<ConstructionRegPrv>()
                                    .autoValidStep1
                                ? AutovalidateMode.onUserInteraction
                                : null,
                            key: context.read<ConstructionRegPrv>().formKey1,
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.only(
                                left: 24,
                                right: 24,
                              ),
                              child: Column(
                                children: [
                                  vpad(12),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      S.of(context).cons_info,
                                      style: txtBold(14, grayScaleColorBase),
                                    ),
                                  ),
                                  vpad(16),
                                  PrimaryDropDown(
                                    value: context
                                        .watch<ConstructionRegPrv>()
                                        .selectedApartment,
                                    validator: Utils.emptyValidatorDropdown,
                                    onChange: context
                                        .read<ConstructionRegPrv>()
                                        .onChangeApartment,
                                    hint: S.of(context).select_surface,
                                    isDense: false,
                                    isRequired: true,
                                    label: S.of(context).surface,
                                    selectList: listApartmentChoice,
                                    controller: context
                                        .read<ConstructionRegPrv>()
                                        .surfaceController,
                                    validateString: context
                                        .watch<ConstructionRegPrv>()
                                        .validateSurface,
                                  ),
                                  vpad(16),
                                  PrimaryDropDown(
                                    value: context
                                        .watch<ConstructionRegPrv>()
                                        .selectedConstype,
                                    validator: Utils.emptyValidatorDropdown,
                                    onChange: context
                                        .read<ConstructionRegPrv>()
                                        .onChangeConsType,
                                    hint: S.of(context).select_cons_type,
                                    isRequired: true,
                                    label: S.of(context).cons_type,
                                    selectList: listType,
                                    controller: context
                                        .read<ConstructionRegPrv>()
                                        .consTypeController,
                                    validateString: context
                                        .watch<ConstructionRegPrv>()
                                        .validateConsType,
                                  ),
                                  vpad(16),
                                  PrimaryTextField(
                                    validator: Utils.emptyValidator,
                                    label: S.of(context).reg_date,
                                    enable: false,
                                    isRequired: true,
                                    isReadOnly: true,
                                    hint: "dd/mm/yyyy",
                                    background: grayScaleColor4,
                                    onTap: () {
                                      // context
                                      //     .read<ConstructionRegPrv>()
                                      //     .pickRegDate(context);
                                    },
                                    suffixIcon: const PrimaryIcon(
                                      icons: PrimaryIcons.calendar,
                                    ),
                                    controller: context
                                        .read<ConstructionRegPrv>()
                                        .regDateController,
                                    validateString: context
                                        .watch<ConstructionRegPrv>()
                                        .validateRegDate,
                                  ),
                                  vpad(16),
                                  PrimaryTextField(
                                    validator: (v) {
                                      var now = DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day,
                                        0,
                                      );
                                      if (v!.isEmpty) {
                                        return '';
                                      } else if (context
                                                  .read<ConstructionRegPrv>()
                                                  .startTime !=
                                              null &&
                                          context
                                                  .read<ConstructionRegPrv>()
                                                  .startTime!
                                                  .compareTo(now) <
                                              0) {
                                        return '';
                                      } else if (context
                                                  .read<ConstructionRegPrv>()
                                                  .startTime !=
                                              null &&
                                          context
                                                  .read<ConstructionRegPrv>()
                                                  .endTime !=
                                              null &&
                                          context
                                                  .read<ConstructionRegPrv>()
                                                  .endTime!
                                                  .compareTo(
                                                    context
                                                        .read<
                                                            ConstructionRegPrv>()
                                                        .startTime!,
                                                  ) <
                                              0) {
                                        return "";
                                      }
                                      return null;
                                    },
                                    label: S.of(context).start_time,
                                    isRequired: true,
                                    isReadOnly: true,
                                    hint: "dd/mm/yyyy",
                                    onTap: () async {
                                      await context
                                          .read<ConstructionRegPrv>()
                                          .pickStartTime(context)
                                          .then((_) {
                                        context
                                            .read<ConstructionRegPrv>()
                                            .countDate();
                                        context
                                            .read<ConstructionRegPrv>()
                                            .calculateFee();
                                      });
                                    },
                                    suffixIcon: const PrimaryIcon(
                                      icons: PrimaryIcons.calendar,
                                    ),
                                    controller: context
                                        .read<ConstructionRegPrv>()
                                        .startTimeController,
                                    validateString: context
                                        .watch<ConstructionRegPrv>()
                                        .validateStartTime,
                                  ),
                                  vpad(16),
                                  PrimaryTextField(
                                    validator: (v) {
                                      if (v!.isEmpty) {
                                        return '';
                                      } else if (context
                                                  .read<ConstructionRegPrv>()
                                                  .startTime !=
                                              null &&
                                          context
                                                  .read<ConstructionRegPrv>()
                                                  .endTime !=
                                              null &&
                                          context
                                                  .read<ConstructionRegPrv>()
                                                  .endTime!
                                                  .compareTo(
                                                    context
                                                        .read<
                                                            ConstructionRegPrv>()
                                                        .startTime!,
                                                  ) <
                                              0) {
                                        return "";
                                      }
                                      return null;
                                    },
                                    label: S.of(context).end_time,
                                    isRequired: true,
                                    isReadOnly: true,
                                    hint: "dd/mm/yyyy",
                                    onTap: () async {
                                      await context
                                          .read<ConstructionRegPrv>()
                                          .pickEndTime(context)
                                          .then((v) {
                                        context
                                            .read<ConstructionRegPrv>()
                                            .countDate();
                                        context
                                            .read<ConstructionRegPrv>()
                                            .calculateFee();
                                      });
                                    },
                                    suffixIcon: const PrimaryIcon(
                                      icons: PrimaryIcons.calendar,
                                    ),
                                    controller: context
                                        .read<ConstructionRegPrv>()
                                        .endTimeController,
                                    validateString: context
                                        .watch<ConstructionRegPrv>()
                                        .validateEndTime,
                                  ),
                                  vpad(16),
                                  PrimaryTextField(
                                    controller: context
                                        .watch<ConstructionRegPrv>()
                                        .consFeeController,
                                    label: S.of(context).cons_fee,
                                    isReadOnly: true,
                                    enable: false,
                                    background: grayScaleColor4,
                                  ),
                                  vpad(16),
                                  // Row(
                                  //   children: [
                                  //     SizedBox(
                                  //       width: 22.0,
                                  //       height: 22.0,
                                  //       child: Checkbox(
                                  //         fillColor:
                                  //             MaterialStateProperty.all(
                                  //                 primaryColorBase),
                                  //         value: context
                                  //             .watch<ConstructionRegPrv>()
                                  //             .isPaidFee,
                                  //         onChanged: (v) {
                                  //           context
                                  //               .read<
                                  //                   ConstructionRegPrv>()
                                  //               .toggleFee();
                                  //         },
                                  //       ),
                                  //     ),
                                  //     hpad(12),
                                  //     Expanded(
                                  //       child: Text(
                                  //         S.of(context).fee_paid,
                                  //         style: txtBold(
                                  //             14, grayScaleColorBase),
                                  //       ),
                                  //     )
                                  //   ],
                                  // ),
                                  // vpad(16),
                                  PrimaryTextField(
                                    controller: context
                                        .read<ConstructionRegPrv>()
                                        .depositController,
                                    label: S.of(context).deposit,
                                    isReadOnly: true,
                                    enable: false,
                                    background: grayScaleColor4,
                                  ),
                                  vpad(16),
                                  // Row(
                                  //   children: [
                                  //     SizedBox(
                                  //       width: 22.0,
                                  //       height: 22.0,
                                  //       child: Checkbox(
                                  //         fillColor:
                                  //             MaterialStateProperty.all(
                                  //                 primaryColorBase),
                                  //         value: context
                                  //             .watch<ConstructionRegPrv>()
                                  //             .isPaidDeposit,
                                  //         onChanged: (v) {
                                  //           context
                                  //               .read<
                                  //                   ConstructionRegPrv>()
                                  //               .toggleDeposit();
                                  //         },
                                  //       ),
                                  //     ),
                                  //     hpad(12),
                                  //     Expanded(
                                  //       child: Text(
                                  //         S.of(context).fee_paid,
                                  //         style: txtBold(
                                  //             14, grayScaleColorBase),
                                  //       ),
                                  //     )
                                  //   ],
                                  // ),
                                  // vpad(16),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: PrimaryTextField(
                                          enable: false,
                                          isReadOnly: true,
                                          keyboardType: TextInputType.number,
                                          controller: context
                                              .read<ConstructionRegPrv>()
                                              .workDayController,
                                          label: S.of(context).cons_day,
                                          background: grayScaleColor4,
                                        ),
                                      ),
                                      hpad(30),
                                      Expanded(
                                        child: PrimaryTextField(
                                          enable: false,
                                          isReadOnly: true,
                                          controller: context
                                              .read<ConstructionRegPrv>()
                                              .offDayController,
                                          keyboardType: TextInputType.number,
                                          label: S.of(context).off_day,
                                          background: grayScaleColor4,
                                        ),
                                      ),
                                    ],
                                  ),
                                  vpad(16),
                                  PrimaryTextField(
                                    maxLength: 1000,
                                    validator: Utils.emptyValidator,
                                    controller: context
                                        .read<ConstructionRegPrv>()
                                        .describeController,
                                    isRequired: true,
                                    label: S.of(context).work_description,
                                    hint: S.of(context).work_description,
                                    maxLines: 3,
                                    validateString: context
                                        .watch<ConstructionRegPrv>()
                                        .validateDescribe,
                                  ),
                                  vpad(30),
                                  PrimaryButton(
                                    width: double.infinity,
                                    isLoading: context
                                        .watch<ConstructionRegPrv>()
                                        .isStep1Loading,
                                    onTap: () => context
                                        .read<ConstructionRegPrv>()
                                        .onStep1Next(context),
                                    text: S.of(context).next,
                                  ),
                                  vpad(40),
                                ],
                              ),
                            ),
                          ),
                          Form(
                            onChanged: context
                                    .watch<ConstructionRegPrv>()
                                    .autoValidStep2
                                ? () => context
                                    .read<ConstructionRegPrv>()
                                    .validate2(context)
                                : null,
                            autovalidateMode: context
                                    .watch<ConstructionRegPrv>()
                                    .autoValidStep2
                                ? AutovalidateMode.onUserInteraction
                                : null,
                            key: context.read<ConstructionRegPrv>().formKey2,
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.only(
                                left: 24,
                                right: 24,
                                bottom: 12,
                              ),
                              child: Column(
                                children: [
                                  vpad(12),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      S.of(context).cons_unit_info,
                                      style: txtBold(
                                        14,
                                        grayScaleColorBase,
                                      ),
                                    ),
                                  ),
                                  vpad(16),
                                  PrimaryTextField(
                                    maxLength: 225,
                                    validator: Utils.emptyValidator,
                                    controller: context
                                        .read<ConstructionRegPrv>()
                                        .consUnitController,
                                    validateString: context
                                        .watch<ConstructionRegPrv>()
                                        .validateConsUnit,
                                    label: S.of(context).cons_unit,
                                    isRequired: true,
                                    hint: S.of(context).enter_cons_unit_name,
                                  ),
                                  vpad(16),
                                  PrimaryTextField(
                                    maxLength: 225,
                                    validator: Utils.emptyValidator,
                                    controller: context
                                        .read<ConstructionRegPrv>()
                                        .addressController,
                                    validateString: context
                                        .watch<ConstructionRegPrv>()
                                        .validateAddress,
                                    label: S.of(context).address,
                                    isRequired: true,
                                    hint: S.of(context).enter_address,
                                  ),
                                  vpad(16),
                                  PrimaryTextField(
                                    isRequired: true,
                                    isShow: false,
                                    maxLength: 255,
                                    blockSpace: true,
                                    validator: (v) {
                                      if (v!.isNotEmpty &&
                                          !RegexText.isEmail(v)) {
                                        return '';
                                      }
                                      return null;
                                    },
                                    controller: context
                                        .read<ConstructionRegPrv>()
                                        .emailController,
                                    validateString: context
                                        .watch<ConstructionRegPrv>()
                                        .validateEmail,
                                    label: S.of(context).email,
                                    hint: S.of(context).enter_email,
                                  ),
                                  vpad(16),
                                  PrimaryTextField(
                                    maxLength: 100,
                                    validator: Utils.emptyValidator,
                                    controller: context
                                        .read<ConstructionRegPrv>()
                                        .deputyController,
                                    validateString: context
                                        .watch<ConstructionRegPrv>()
                                        .validateDeputy,
                                    label: S.of(context).deputy,
                                    isRequired: true,
                                    hint: S.of(context).enter_deputy_name,
                                  ),
                                  vpad(16),
                                  PrimaryTextField(
                                    blockSpace: true,
                                    blockSpecial: true,
                                    onlyNum: true,
                                    maxLength: 10,
                                    validator: (v) {
                                      if (v!.isEmpty || v.length < 10) {
                                        return "";
                                      }
                                      return null;
                                    },
                                    controller: context
                                        .read<ConstructionRegPrv>()
                                        .phoneController,
                                    validateString: context
                                        .watch<ConstructionRegPrv>()
                                        .validatePhone,
                                    keyboardType: TextInputType.number,
                                    label: S.of(context).deputy_phone,
                                    isRequired: true,
                                    hint: S.of(context).enter_phone,
                                  ),
                                  vpad(16),
                                  PrimaryTextField(
                                    maxLength: 12,
                                    filter: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9a-zA-Z]'),
                                      ),
                                    ],
                                    blockSpace: true,
                                    blockSpecial: true,
                                    validator: (v) {
                                      if (v!.isEmpty) {
                                        return '';
                                      } else if (v.length < 9) {
                                        return '';
                                      }
                                      return null;
                                    },
                                    controller: context
                                        .read<ConstructionRegPrv>()
                                        .identityController,
                                    validateString: context
                                        .watch<ConstructionRegPrv>()
                                        .validateIdentity,
                                    label: S.of(context).cmnd,
                                    isRequired: true,
                                    hint: S.of(context).enter_identity,
                                  ),
                                  vpad(16),
                                  PrimaryTextField(
                                    keyboardType: TextInputType.number,
                                    maxLength: 3,
                                    onlyNum: true,
                                    //validator: Utils.emptyValidator,
                                    controller: context
                                        .read<ConstructionRegPrv>()
                                        .workerNumController,
                                    // validateString: context
                                    //     .watch<ConstructionRegPrv>()
                                    //     .validateWorkerNum,
                                    label: S.of(context).worker_num,
                                    isRequired: false,
                                    hint: S.of(context).enter_worker_num,
                                  ),
                                  vpad(30),
                                  PrimaryButton(
                                    width: double.infinity,
                                    isLoading: context
                                        .watch<ConstructionRegPrv>()
                                        .isStep2Loading,
                                    onTap: () => context
                                        .read<ConstructionRegPrv>()
                                        .onStep2Next(context),
                                    text: S.of(context).next,
                                  ),
                                  vpad(40),
                                ],
                              ),
                            ),
                          ),
                          ListView(
                            padding: const EdgeInsets.only(
                              left: 24,
                              right: 24,
                            ),
                            children: [
                              vpad(12),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  S.of(context).limit_15mb,
                                  style: txtRegular(14, grayScaleColorBase),
                                ),
                              ),
                              vpad(16),
                              Row(
                                children: [
                                  Text(
                                    S.of(context).cons_drawing,
                                    style: txtRegular(
                                      14,
                                      grayScaleColorBase,
                                    ),
                                  ),
                                  Text(
                                    " *",
                                    style: txtRegular(14, redColorBase),
                                  ),
                                ],
                              ),
                              vpad(16),
                              SelectFileWidget(
                                onSelect: () => context
                                    .read<ConstructionRegPrv>()
                                    .onSelectCurentDrawing(context),
                                existFiles: context
                                    .watch<ConstructionRegPrv>()
                                    .existedCurrentDrawings,
                                files: context
                                    .watch<ConstructionRegPrv>()
                                    .currentDrawings,
                                onRemove: context
                                    .read<ConstructionRegPrv>()
                                    .onRemoveCurentDrawing,
                                onRemoveExist: context
                                    .read<ConstructionRegPrv>()
                                    .onRemoveExistedCurentDrawing,
                                icon: const PrimaryIcon(
                                  icons: PrimaryIcons.image_add,
                                ),
                                text: S.of(context).add_file,
                                title: S.of(context).exist_drawing,
                              ),
                              vpad(16),
                              SelectFileWidget(
                                onSelect: () => context
                                    .read<ConstructionRegPrv>()
                                    .onSelectRenewDrawing(context),
                                existFiles: context
                                    .watch<ConstructionRegPrv>()
                                    .existedRenewDrawings,
                                files: context
                                    .watch<ConstructionRegPrv>()
                                    .renewDrawings,
                                onRemove: context
                                    .read<ConstructionRegPrv>()
                                    .onRemoveRenewDrawing,
                                onRemoveExist: context
                                    .read<ConstructionRegPrv>()
                                    .onRemoveExistedRenewDrawing,
                                icon: const PrimaryIcon(
                                  icons: PrimaryIcons.image_add,
                                ),
                                text: S.of(context).add_file,
                                title: S.of(context).renewal_drawing,
                              ),
                              vpad(16),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 22.0,
                                    height: 22.0,
                                    child: Checkbox(
                                      fillColor: MaterialStateProperty.all(
                                        primaryColorBase,
                                      ),
                                      value: context
                                          .watch<ConstructionRegPrv>()
                                          .isAgree,
                                      onChanged: (v) {
                                        context
                                            .read<ConstructionRegPrv>()
                                            .toggleAgree();
                                      },
                                    ),
                                  ),
                                  hpad(12),
                                  Expanded(
                                    child: RichText(
                                      text: TextSpan(
                                        style: txtMedium(
                                          16,
                                          grayScaleColor2,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: S.of(context).i_confirm,
                                          ),
                                          TextSpan(
                                            text: " ${S.of(context).here}",
                                            style: txtMedium(
                                              16,
                                              primaryColor6,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  context: context,
                                                  builder: ((context) =>
                                                      ListView(
                                                        children: [
                                                          vpad(
                                                            40,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              BackButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                    context,
                                                                  );
                                                                },
                                                              ),
                                                              Text(
                                                                S
                                                                    .of(context)
                                                                    .cons_regulation,
                                                                style:
                                                                    txtBodyLargeBold(
                                                                  color:
                                                                      grayScaleColorBase,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                              hpad(50),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                              horizontal: 24,
                                                            ),
                                                            child: HtmlWidget(
                                                              consRe,
                                                              buildAsync: false,
                                                              onTapUrl: (url) {
                                                                return false;
                                                              },
                                                              textStyle:
                                                                  txtBodyMediumRegular(),
                                                            ),
                                                          ),
                                                          vpad(
                                                            40,
                                                          ),
                                                        ],
                                                      )),
                                                );
                                              },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              vpad(30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: PrimaryButton(
                                      isLoading: context
                                          .watch<ConstructionRegPrv>()
                                          .isAddNewLoading,
                                      buttonSize: ButtonSize.medium,
                                      text: isEdit
                                          ? S.of(context).update
                                          : S.of(context).add_new,
                                      onTap: () => context
                                          .read<ConstructionRegPrv>()
                                          .onSendSubmit(context, false),
                                    ),
                                  ),
                                  hpad(10),
                                  Expanded(
                                    child: PrimaryButton(
                                      isLoading: context
                                          .watch<ConstructionRegPrv>()
                                          .isSendApproveLoading,
                                      buttonType: ButtonType.green,
                                      buttonSize: ButtonSize.medium,
                                      text: S.of(context).send_request,
                                      onTap: () => context
                                          .read<ConstructionRegPrv>()
                                          .onSendSubmit(context, true),
                                    ),
                                  ),
                                ],
                              ),
                              vpad(40),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
