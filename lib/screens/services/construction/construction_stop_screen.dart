import 'package:app_cudan/models/construction.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/screens/services/construction/prv/construction_extend_prv.dart';
import 'package:app_cudan/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_dropdown.dart';
import '../../../widgets/primary_icon.dart';
import '../../../widgets/primary_screen.dart';
import 'prv/construction_stop_prv.dart';

class ConstructionStopScreen extends StatefulWidget {
  const ConstructionStopScreen({super.key});
  static const routeName = "/construction/stop";

  @override
  State<ConstructionStopScreen> createState() => _ConstructionStopScreenState();
}

class _ConstructionStopScreenState extends State<ConstructionStopScreen> {
  @override
  Widget build(BuildContext context) {
    var arg = ModalRoute.of(context)!.settings.arguments as Map;
    var isEdit = true;
    if (arg['edit'] != null) {
      isEdit = arg['edit'];
    }
    var card = arg["letter"] as ConstructionTemporarilyStopped?;
    return PrimaryScreen(
      appBar: PrimaryAppbar(
        title: S.of(context).stop_construction,
      ),
      body: ChangeNotifierProvider(
        create: (context) => ConstructionStopPrv(exitedStop: card),
        builder: (context, state) {
          var listApartmentChoice = context
              .read<ResidentInfoPrv>()
              .listOwn
              .map(
                (i) => DropdownMenuItem(
                  value: i.apartmentId,
                  child: Text(
                    "${i.apartment?.name ?? ''} - ${i.floor?.name ?? ''} - ${i.building?.name ?? ''}",
                  ),
                ),
              )
              .toList();
          var listFileChoice = context
              .watch<ConstructionStopPrv>()
              .fileList
              .map(
                (e) =>
                    DropdownMenuItem(value: e.code, child: Text(e.code ?? '')),
              )
              .toList();
          return Form(
            key: context.read<ConstructionStopPrv>().formKey,
            onChanged: context.watch<ConstructionStopPrv>().autoValidate
                ? context.read<ConstructionStopPrv>().validate
                : null,
            autovalidateMode: context.watch<ConstructionStopPrv>().autoValidate
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
                  enable: isEdit,
                  value: context.watch<ConstructionStopPrv>().surfaceValue,
                  selectList: listApartmentChoice,
                  validator: Utils.emptyValidatorDropdown,
                  onChange: context.read<ConstructionStopPrv>().onSelectSurface,
                  validateString:
                      context.watch<ConstructionStopPrv>().validateSurface,
                  isRequired: true,
                  label: S.of(context).surface,
                ),
                vpad(12),
                PrimaryDropDown(
                  value: context.watch<ConstructionStopPrv>().fileValue,
                  enable: isEdit,
                  key: context.read<ConstructionStopPrv>().fileKey,
                  selectList: listFileChoice,
                  validator: Utils.emptyValidatorDropdown,
                  onChange: context.read<ConstructionStopPrv>().onSelectFile,
                  validateString:
                      context.watch<ConstructionStopPrv>().validateFile,
                  isRequired: true,
                  label: S.of(context).cons_file,
                ),
                vpad(12),
                PrimaryTextField(
                  key: context.read<ConstructionStopPrv>().regDateKey,
                  validator: Utils.emptyValidator,
                  validateString:
                      context.watch<ConstructionStopPrv>().validateRegDate,
                  controller:
                      context.read<ConstructionStopPrv>().regDateController,
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
                  enable: isEdit,
                  validator: Utils.emptyValidator,
                  validateString:
                      context.watch<ConstructionStopPrv>().validateStartDate,
                  onTap: () => context
                      .read<ConstructionStopPrv>()
                      .pickStartDate(context),
                  controller:
                      context.read<ConstructionStopPrv>().startDateController,
                  isRequired: true,
                  hint: 'dd/mm/yyyy',
                  isReadOnly: true,
                  label: S.of(context).start_date_stop,
                  suffixIcon: PrimaryIcon(icons: PrimaryIcons.calendar),
                ),
                vpad(12),
                PrimaryTextField(
                  enable: isEdit,
                  validator: Utils.emptyValidator,
                  validateString:
                      context.watch<ConstructionStopPrv>().validateEndDate,
                  onTap: () =>
                      context.read<ConstructionStopPrv>().pickEndDate(context),
                  controller:
                      context.read<ConstructionStopPrv>().endDateController,
                  isRequired: true,
                  hint: 'dd/mm/yyyy',
                  isReadOnly: true,
                  label: S.of(context).end_date_stop,
                  suffixIcon: PrimaryIcon(icons: PrimaryIcons.calendar),
                ),
                vpad(12),
                PrimaryTextField(
                  controller:
                      context.read<ConstructionStopPrv>().consFeeController,
                  label: S.of(context).cons_fee,
                  background: grayScaleColor4,
                  enable: false,
                ),
                vpad(12),
                Row(
                  children: [
                    Expanded(
                      child: PrimaryTextField(
                        enable: isEdit,
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        onlyNum: true,
                        controller: context
                            .read<ConstructionStopPrv>()
                            .consDateController,
                        label: S.of(context).cons_day,
                      ),
                    ),
                    hpad(12),
                    Expanded(
                      child: PrimaryTextField(
                        enable: isEdit,
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        onlyNum: true,
                        controller: context
                            .read<ConstructionStopPrv>()
                            .offDateController,
                        label: S.of(context).off_day,
                      ),
                    ),
                  ],
                ),
                vpad(12),
                PrimaryTextField(
                  enable: isEdit,
                  maxLength: 500,
                  controller:
                      context.read<ConstructionStopPrv>().reasonController,
                  validateString:
                      context.watch<ConstructionStopPrv>().validateReason,
                  validator: Utils.emptyValidator,
                  isRequired: true,
                  label: S.of(context).reason,
                  maxLines: 3,
                ),
                if (isEdit) vpad(30),
                if (isEdit)
                  PrimaryButton(
                    isLoading: context.watch<ConstructionStopPrv>().loading,
                    onTap: () =>
                        context.read<ConstructionStopPrv>().onSubmit(context),
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
