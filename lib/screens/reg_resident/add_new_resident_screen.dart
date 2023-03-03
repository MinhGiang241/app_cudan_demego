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
import 'prv/add_new_resident_prv.dart';

class AddNewResidentScreen extends StatelessWidget {
  const AddNewResidentScreen({super.key});
  static const routeName = '/reg_resident/add';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddNewResidentPrv(),
      builder: (context, child) {
        var activeStep = context.watch<AddNewResidentPrv>().activeStep;
        return PrimaryScreen(
            isPadding: false,
            appBar: PrimaryAppbar(
              title: S.of(context).add_dependent_person,
            ),
            body: SafeArea(
              child: FutureBuilder(
                future: () {}(),
                builder: (context, snapshot) {
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
                                  label: S.of(context).apartment_add_resident,
                                  isRequired: true,
                                ),
                                vpad(12),
                                PrimaryTextField(
                                  label: S.of(context).full_name,
                                  isRequired: true,
                                  hint: S.of(context).full_name,
                                ),
                                vpad(12),
                                PrimaryDropDown(
                                  label: S.of(context).relation_with_owner,
                                  isRequired: true,
                                ),
                                vpad(12),
                                PrimaryDropDown(
                                  label: S.of(context).sex,
                                  isRequired: true,
                                ),
                                vpad(12),
                                PrimaryTextField(
                                  label: S.of(context).dob,
                                  hint: S.of(context).dob,
                                  isRequired: true,
                                ),
                                vpad(12),
                                PrimaryTextField(
                                  label: S.of(context).cmnd,
                                  hint: S.of(context).cmnd,
                                  isRequired: true,
                                ),
                                vpad(12),
                                PrimaryTextField(
                                  label: S.of(context).cmnd,
                                  hint: S.of(context).cmnd,
                                  isRequired: true,
                                ),
                                vpad(12),
                                PrimaryTextField(
                                  label: S.of(context).place_issue,
                                  hint: S.of(context).place_issue,
                                  isRequired: true,
                                ),
                                vpad(12),
                                PrimaryDropDown(
                                  label: S.of(context).resident_type,
                                  isRequired: true,
                                ),
                                vpad(12),
                                PrimaryDropDown(
                                  label: S.of(context).prov_city,
                                  isRequired: true,
                                ),
                                vpad(12),
                                PrimaryDropDown(
                                  label: S.of(context).ward,
                                  isRequired: true,
                                ),
                                vpad(12),
                                PrimaryDropDown(
                                  label: S.of(context).block,
                                  isRequired: true,
                                ),
                                vpad(12),
                                SelectMediaWidget(
                                  isRequired: true,
                                  title: S.of(context).res_photo,
                                ),
                                vpad(12),
                                SelectMediaWidget(
                                  isRequired: true,
                                  title: S.of(context).identity_photo,
                                ),
                                vpad(12),
                                SelectFileWidget(
                                  title: S.of(context).add_file,
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
                          child: Column(children: []),
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
