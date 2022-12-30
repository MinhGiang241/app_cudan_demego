import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_button.dart';
import 'package:app_cudan/widgets/primary_dropdown.dart';
import 'package:app_cudan/widgets/primary_text_field.dart';
import 'package:app_cudan/widgets/select_file_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import '../../../constants/constants.dart';
import '../../../constants/regulation.dart';
import '../../../generated/l10n.dart';
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

class _ConstructionRegScreenState extends State<ConstructionRegScreen> {
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map?;
    var isEdit = false;
    if (arg != null) {
      isEdit = arg['isEdit'] ?? false;
    }

    return ChangeNotifierProvider(
        create: (context) => ConstructionRegPrv(),
        builder: (context, state) {
          var activeStep = context.watch<ConstructionRegPrv>().activeStep;

          return PrimaryScreen(
            isPadding: false,
            appBar: PrimaryAppbar(
              title: S.of(context).reg_const,
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
                          child: Text(e.apartment?.name! != null
                              ? '${e.apartment?.name} - ${e.floor?.name} - ${e.building?.name}'
                              : e.apartmentId!),
                        );
                      }).toList();
                      var listType = context
                          .read<ConstructionRegPrv>()
                          .listConstructionType
                          .map((e) {
                        return DropdownMenuItem(
                            value: e.code, child: Text(e.name ?? e.code ?? ""));
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
                                                : grayScaleColor4),
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
                            value: (context
                                        .watch<ConstructionRegPrv>()
                                        .activeStep +
                                    1) /
                                3,
                          ),
                          Expanded(
                            child: PageView(
                              // physics: const NeverScrollableScrollPhysics(),
                              controller:
                                  context.read<ConstructionRegPrv>().controller,
                              onPageChanged: context
                                  .read<ConstructionRegPrv>()
                                  .onPageChanged,
                              children: <Widget>[
                                Form(
                                  key: context
                                      .read<ConstructionRegPrv>()
                                      .formKey1,
                                  child: ListView(
                                    padding: const EdgeInsets.only(
                                      left: 24,
                                      right: 24,
                                    ),
                                    children: [
                                      vpad(12),
                                      Text(
                                        S.of(context).cons_info,
                                        style: txtBold(14, grayScaleColorBase),
                                      ),
                                      vpad(16),
                                      PrimaryDropDown(
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
                                        label: S.of(context).reg_date,
                                        isRequired: true,
                                        isReadOnly: true,
                                        hint: "dd/mm/yyyy",
                                        onTap: () {
                                          context
                                              .read<ConstructionRegPrv>()
                                              .pickRegDate(context);
                                        },
                                        suffixIcon: const PrimaryIcon(
                                            icons: PrimaryIcons.calendar),
                                        controller: context
                                            .read<ConstructionRegPrv>()
                                            .regDateController,
                                        validateString: context
                                            .watch<ConstructionRegPrv>()
                                            .validateRegDate,
                                      ),
                                      vpad(16),
                                      PrimaryTextField(
                                        label: S.of(context).start_time,
                                        isRequired: true,
                                        isReadOnly: true,
                                        hint: "dd/mm/yyyy",
                                        onTap: () {
                                          context
                                              .read<ConstructionRegPrv>()
                                              .pickStartTime(context);
                                        },
                                        suffixIcon: const PrimaryIcon(
                                            icons: PrimaryIcons.calendar),
                                        controller: context
                                            .read<ConstructionRegPrv>()
                                            .startTimeController,
                                        validateString: context
                                            .watch<ConstructionRegPrv>()
                                            .validateStartTime,
                                      ),
                                      vpad(16),
                                      PrimaryTextField(
                                        label: S.of(context).end_time,
                                        isRequired: true,
                                        isReadOnly: true,
                                        hint: "dd/mm/yyyy",
                                        onTap: () {
                                          context
                                              .read<ConstructionRegPrv>()
                                              .pickEndTime(context);
                                        },
                                        suffixIcon: const PrimaryIcon(
                                            icons: PrimaryIcons.calendar),
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
                                            .read<ConstructionRegPrv>()
                                            .consFeeController,
                                        label: S.of(context).cons_fee,
                                        isReadOnly: true,
                                        enable: false,
                                        background: grayScaleColor4,
                                      ),
                                      vpad(16),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 22.0,
                                            height: 22.0,
                                            child: Checkbox(
                                              fillColor:
                                                  MaterialStateProperty.all(
                                                      primaryColorBase),
                                              value: context
                                                  .watch<ConstructionRegPrv>()
                                                  .isPaidFee,
                                              onChanged: (v) {
                                                context
                                                    .read<ConstructionRegPrv>()
                                                    .toggleFee();
                                              },
                                            ),
                                          ),
                                          hpad(12),
                                          Expanded(
                                            child: Text(
                                              S.of(context).fee_paid,
                                              style: txtBold(
                                                  14, grayScaleColorBase),
                                            ),
                                          )
                                        ],
                                      ),
                                      vpad(16),
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
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 22.0,
                                            height: 22.0,
                                            child: Checkbox(
                                              fillColor:
                                                  MaterialStateProperty.all(
                                                      primaryColorBase),
                                              value: context
                                                  .watch<ConstructionRegPrv>()
                                                  .isPaidDeposit,
                                              onChanged: (v) {
                                                context
                                                    .read<ConstructionRegPrv>()
                                                    .toggleDeposit();
                                              },
                                            ),
                                          ),
                                          hpad(12),
                                          Expanded(
                                            child: Text(
                                              S.of(context).fee_paid,
                                              style: txtBold(
                                                  14, grayScaleColorBase),
                                            ),
                                          )
                                        ],
                                      ),
                                      vpad(16),
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
                                          )),
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
                                          )),
                                        ],
                                      ),
                                      vpad(16),
                                      PrimaryTextField(
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
                                        isLoading: context
                                            .watch<ConstructionRegPrv>()
                                            .isStep1Loading,
                                        onTap: context
                                            .read<ConstructionRegPrv>()
                                            .onStep1Next,
                                        text: S.of(context).next,
                                      ),
                                      vpad(40),
                                    ],
                                  ),
                                ),
                                Form(
                                  key: context
                                      .read<ConstructionRegPrv>()
                                      .formKey2,
                                  child: ListView(
                                    padding: const EdgeInsets.only(
                                      left: 24,
                                      right: 24,
                                      bottom: 12,
                                    ),
                                    children: [
                                      vpad(12),
                                      Text(S.of(context).cons_unit_info,
                                          style:
                                              txtBold(14, grayScaleColorBase)),
                                      vpad(16),
                                      PrimaryTextField(
                                        controller: context
                                            .read<ConstructionRegPrv>()
                                            .consUnitController,
                                        validateString: context
                                            .watch<ConstructionRegPrv>()
                                            .validateConsUnit,
                                        label: S.of(context).cons_unit,
                                        isRequired: true,
                                        hint:
                                            S.of(context).enter_cons_unit_name,
                                      ),
                                      vpad(16),
                                      PrimaryTextField(
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
                                        controller: context
                                            .read<ConstructionRegPrv>()
                                            .workerNumController,
                                        validateString: context
                                            .watch<ConstructionRegPrv>()
                                            .validateWorkerNum,
                                        label: S.of(context).worker_num,
                                        isRequired: true,
                                        hint: S.of(context).enter_worker_num,
                                      ),
                                      vpad(30),
                                      PrimaryButton(
                                        isLoading: context
                                            .watch<ConstructionRegPrv>()
                                            .isStep2Loading,
                                        onTap: context
                                            .read<ConstructionRegPrv>()
                                            .onStep2Next,
                                        text: S.of(context).next,
                                      ),
                                      vpad(40),
                                    ],
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
                                        style:
                                            txtRegular(14, grayScaleColorBase),
                                      ),
                                    ),
                                    vpad(16),
                                    Row(
                                      children: [
                                        Text(
                                          S.of(context).cons_drawing,
                                          style: txtRegular(
                                              14, grayScaleColorBase),
                                        ),
                                        Text(
                                          " *",
                                          style: txtRegular(14, redColorBase),
                                        ),
                                      ],
                                    ),
                                    vpad(16),
                                    SelectFileWidget(
                                      icon: const PrimaryIcon(
                                        icons: PrimaryIcons.image_add,
                                      ),
                                      text: S.of(context).add_file,
                                      title: S.of(context).exist_drawing,
                                    ),
                                    vpad(16),
                                    SelectFileWidget(
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
                                            fillColor:
                                                MaterialStateProperty.all(
                                                    primaryColorBase),
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
                                                    16, grayScaleColor2),
                                                children: [
                                                  TextSpan(
                                                      text: S
                                                          .of(context)
                                                          .i_confirm),
                                                  TextSpan(
                                                    text:
                                                        " ${S.of(context).here}",
                                                    style: txtMedium(
                                                        16, primaryColor6),
                                                    recognizer:
                                                        TapGestureRecognizer()
                                                          ..onTap = () {
                                                            showModalBottomSheet(
                                                              isScrollControlled:
                                                                  true,
                                                              context: context,
                                                              builder:
                                                                  ((context) =>
                                                                      ListView(
                                                                        children: [
                                                                          vpad(
                                                                              40),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              BackButton(onPressed: () {
                                                                                Navigator.pop(context);
                                                                              }),
                                                                              Text(
                                                                                S.of(context).cons_regulation,
                                                                                style: txtBodyLargeBold(color: grayScaleColorBase),
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                              hpad(50)
                                                                            ],
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 24),
                                                                            child:
                                                                                HtmlWidget(
                                                                              consRe,
                                                                              buildAsync: false,
                                                                              onTapUrl: (url) {
                                                                                return false;
                                                                              },
                                                                              textStyle: txtBodyMediumRegular(),
                                                                            ),
                                                                          ),
                                                                          vpad(
                                                                              40),
                                                                        ],
                                                                      )),
                                                            );
                                                          },
                                                  ),
                                                ]),
                                          ),
                                        ),
                                      ],
                                    ),
                                    vpad(30),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        PrimaryButton(
                                          // isLoading: context
                                          //     .watch<RegisterDeliveryPrv>()
                                          //     .isAddNewLoading,
                                          buttonSize: ButtonSize.medium,
                                          text: isEdit
                                              ? S.of(context).update
                                              : S.of(context).add_new,
                                          // onTap: () => context
                                          //     .read<RegisterDeliveryPrv>()
                                          //     .onSendSummitDelivery(context, false),
                                        ),
                                        PrimaryButton(
                                          // isLoading: context
                                          //     .watch<RegisterDeliveryPrv>()
                                          //     .isSendApproveLoading,
                                          buttonType: ButtonType.green,
                                          buttonSize: ButtonSize.medium,
                                          text: S.of(context).send_request,
                                          // onTap: () => context
                                          //     .read<RegisterDeliveryPrv>()
                                          //     .onSendSummitDelivery(context, true),
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
                    })),
          );
        });
  }
}
