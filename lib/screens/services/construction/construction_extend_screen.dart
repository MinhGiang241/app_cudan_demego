import 'package:app_cudan/constants/constants.dart';
import 'package:app_cudan/screens/services/construction/prv/construction_extend_prv.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_dropdown.dart';
import 'package:app_cudan/widgets/primary_icon.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:app_cudan/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_button.dart';

class ConstructionExtendScreen extends StatefulWidget {
  const ConstructionExtendScreen({super.key});
  static const routeName = "/construction/extend";

  @override
  State<ConstructionExtendScreen> createState() =>
      _ConstructionExtendScreenState();
}

class _ConstructionExtendScreenState extends State<ConstructionExtendScreen> {
  @override
  Widget build(BuildContext context) {
    var arg = ModalRoute.of(context)!.settings.arguments as Map;
    var isEdit = true;
    if (arg['edit'] != null) {
      isEdit = arg['edit'];
    }
    return PrimaryScreen(
      appBar: PrimaryAppbar(
        title: S.of(context).construction_extend,
      ),
      body: ChangeNotifierProvider(
        create: (context) => ConstructionExtendPrv(),
        builder: (context, state) {
          return Form(
            key: context.read<ConstructionExtendPrv>().formKey,
            onChanged: context.watch<ConstructionExtendPrv>().autoValidate
                ? context.read<ConstructionExtendPrv>().validate
                : null,
            autovalidateMode:
                context.watch<ConstructionExtendPrv>().autoValidate
                    ? AutovalidateMode.onUserInteraction
                    : null,
            child: ListView(
              children: [
                vpad(12),
                Text(
                  S.of(context).cons_info,
                  style: txtBold(14),
                ),
                vpad(12),
                PrimaryDropDown(
                  validator: Utils.emptyValidatorDropdown,
                  onChange:
                      context.read<ConstructionExtendPrv>().onSelectSurfce,
                  validateString:
                      context.watch<ConstructionExtendPrv>().validateSurface,
                  isRequired: true,
                  label: S.of(context).surface,
                ),
                vpad(12),
                PrimaryDropDown(
                  validator: Utils.emptyValidatorDropdown,
                  onChange: context.read<ConstructionExtendPrv>().onSelectFile,
                  validateString:
                      context.watch<ConstructionExtendPrv>().validateFile,
                  isRequired: true,
                  label: S.of(context).cons_file,
                ),
                vpad(12),
                PrimaryTextField(
                  validator: Utils.emptyValidator,
                  validateString:
                      context.watch<ConstructionExtendPrv>().validateRegDate,
                  controller:
                      context.read<ConstructionExtendPrv>().regDateController,
                  isRequired: true,
                  hint: 'dd/mm/yyyy',
                  enable: false,
                  background: grayScaleColor4,
                  label: S.of(context).reg_date,
                  isReadOnly: true,
                  suffixIcon: PrimaryIcon(icons: PrimaryIcons.calendar),
                ),
                vpad(12),
                PrimaryTextField(
                  validator: Utils.emptyValidator,
                  validateString:
                      context.watch<ConstructionExtendPrv>().validateStartDate,
                  onTap: () => context
                      .read<ConstructionExtendPrv>()
                      .pickStartDate(context),
                  controller:
                      context.read<ConstructionExtendPrv>().startDateController,
                  isRequired: true,
                  hint: 'dd/mm/yyyy',
                  isReadOnly: true,
                  label: S.of(context).start_date_extend,
                  suffixIcon: PrimaryIcon(icons: PrimaryIcons.calendar),
                ),
                vpad(12),
                PrimaryTextField(
                  validator: Utils.emptyValidator,
                  validateString:
                      context.watch<ConstructionExtendPrv>().validateEndDate,
                  onTap: () => context
                      .read<ConstructionExtendPrv>()
                      .pickEndDate(context),
                  controller:
                      context.read<ConstructionExtendPrv>().endDateController,
                  isRequired: true,
                  hint: 'dd/mm/yyyy',
                  isReadOnly: true,
                  label: S.of(context).end_date_extend,
                  suffixIcon: PrimaryIcon(icons: PrimaryIcons.calendar),
                ),
                vpad(12),
                PrimaryTextField(
                  controller:
                      context.read<ConstructionExtendPrv>().consFeeController,
                  label: S.of(context).cons_fee,
                  background: grayScaleColor4,
                  enable: false,
                ),
                vpad(12),
                Row(
                  children: [
                    Expanded(
                      child: PrimaryTextField(
                        controller: context
                            .read<ConstructionExtendPrv>()
                            .consDateController,
                        label: S.of(context).cons_day,
                      ),
                    ),
                    hpad(12),
                    Expanded(
                      child: PrimaryTextField(
                        controller: context
                            .read<ConstructionExtendPrv>()
                            .offDateController,
                        label: S.of(context).off_day,
                      ),
                    ),
                  ],
                ),
                vpad(12),
                PrimaryTextField(
                  controller:
                      context.read<ConstructionExtendPrv>().reasonController,
                  validateString:
                      context.watch<ConstructionExtendPrv>().validateReason,
                  validator: Utils.emptyValidator,
                  isRequired: true,
                  label: S.of(context).reason,
                  maxLines: 3,
                ),
                if (isEdit) vpad(30),
                if (isEdit)
                  PrimaryButton(
                    isLoading: context.watch<ConstructionExtendPrv>().loading,
                    onTap: () =>
                        context.read<ConstructionExtendPrv>().onSubmit(context),
                    text: S.of(context).send_request,
                    buttonType: ButtonType.green,
                  ),
                vpad(30),
              ],
            ),
          );
        },
      ),
    );
  }
}
