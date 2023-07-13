import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_button.dart';
import 'package:app_cudan/widgets/primary_dropdown.dart';
import 'package:app_cudan/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../../utils/utils.dart';
import '../../widgets/primary_screen.dart';
import '../../widgets/primary_dropdown_search.dart';
import 'prv/create_new_proj_registration_prv.dart';

class AddNewProjRegScreen extends StatefulWidget {
  const AddNewProjRegScreen({super.key});
  static const routeName = '/project-register';

  @override
  State<AddNewProjRegScreen> createState() => _AddNewProjRegScreenState();
}

class _AddNewProjRegScreenState extends State<AddNewProjRegScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CreateNewProjRegistrationPrv(),
      builder: (context, state) {
        var isResident =
            context.watch<CreateNewProjRegistrationPrv>().valueType ==
                "RESIDENT";
        return PrimaryScreen(
          appBar: PrimaryAppbar(
            title: S.of(context).reg_info,
          ),
          body: Form(
            onChanged: context.watch<CreateNewProjRegistrationPrv>().autoValid
                ? () => context
                    .read<CreateNewProjRegistrationPrv>()
                    .validate(context)
                : null,
            autovalidateMode:
                context.watch<CreateNewProjRegistrationPrv>().autoValid
                    ? AutovalidateMode.onUserInteraction
                    : null,
            key: context.read<CreateNewProjRegistrationPrv>().formKey,
            child: ListView(
              children: [
                vpad(12),
                PrimaryDropDown(
                  selectList: context
                      .watch<CreateNewProjRegistrationPrv>()
                      .projectListChoice,
                  onChange: (v) => context
                      .read<CreateNewProjRegistrationPrv>()
                      .onChangeProject(v, context),
                  isRequired: true,
                  label: S.of(context).project,
                  hint: S.of(context).choose_a_project,
                  validator: Utils.emptyValidatorDropdown,
                  validateString: context
                      .watch<CreateNewProjRegistrationPrv>()
                      .validateProject,
                ),
                vpad(12),
                PrimaryDropDown(
                  isRequired: true,
                  onChange:
                      context.read<CreateNewProjRegistrationPrv>().onSelectType,
                  validateString: context
                      .watch<CreateNewProjRegistrationPrv>()
                      .validateType,
                  label: S.of(context).account_type,
                  hint: S.of(context).account_type,
                  selectList: [
                    DropdownMenuItem(
                      child: Text(S.of(context).resident_account),
                      value: "RESIDENT",
                    ),
                    DropdownMenuItem(
                      child: Text(S.of(context).guest_account),
                      value: "GUEST",
                    ),
                  ],
                  validator: Utils.emptyValidatorDropdown,
                ),
                if (isResident) vpad(12),
                if (isResident)
                  PrimaryDropDownSearch(
                    key: context
                        .watch<CreateNewProjRegistrationPrv>()
                        .searchApartmentKey,
                    onSaved: context
                        .read<CreateNewProjRegistrationPrv>()
                        .onSaveApartment,
                    isAuto:
                        context.watch<CreateNewProjRegistrationPrv>().autoValid,
                    onChanged: context
                        .read<CreateNewProjRegistrationPrv>()
                        .onChangeApartment,
                    paginatedRequest: context
                        .read<CreateNewProjRegistrationPrv>()
                        .paginatedRequest,
                    isRequired: true,
                    label: S.of(context).apartment,
                    hint: S.of(context).search_apartment,
                    validator: (v) {
                      if (v == null) {
                        return S.of(context).not_blank;
                      }
                      return null;
                    },
                    validateString: context
                        .watch<CreateNewProjRegistrationPrv>()
                        .validateContractNum,
                  ),
                if (isResident) vpad(12),
                if (isResident)
                  PrimaryDropDown(
                    value: context
                        .watch<CreateNewProjRegistrationPrv>()
                        .valueRelation,
                    enable: false,
                    key: context
                        .watch<CreateNewProjRegistrationPrv>()
                        .relationKey,
                    selectList: context
                        .watch<CreateNewProjRegistrationPrv>()
                        .relationshipList,
                    onChange: context
                        .read<CreateNewProjRegistrationPrv>()
                        .onChangeRelation,
                    isRequired: true,
                    label: S.of(context).relation_owner,
                    validator: Utils.emptyValidatorDropdown,
                    validateString: context
                        .watch<CreateNewProjRegistrationPrv>()
                        .validateRelation,
                  ),
                // vpad(12),
                // PrimaryTextField(
                //   controller: context
                //       .read<CreateNewProjRegistrationPrv>()
                //       .contractNumController,
                //   isRequired: true,
                //   hint: S.of(context).enter_sell_contract_num,
                //   label: S.of(context).sell_contract_num,
                //   validator: Utils.emptyValidator,
                //   validateString: context
                //       .watch<CreateNewProjRegistrationPrv>()
                //       .validateContractNum,
                // ),
                vpad(40),
                PrimaryButton(
                  onTap: () => context
                      .read<CreateNewProjRegistrationPrv>()
                      .onSubmit(context),
                  text: S.of(context).confirm,
                ),
                vpad(40),
              ],
            ),
          ),
        );
      },
    );
  }
}
