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

class AddNewProjRegScreen extends StatelessWidget {
  const AddNewProjRegScreen({super.key});
  static const routeName = '/project-register';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CreateNewProjRegistrationPrv(),
      builder: (context, state) {
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
                  onChange: context
                      .read<CreateNewProjRegistrationPrv>()
                      .onChangeProject,
                  isRequired: true,
                  label: S.of(context).project,
                  hint: S.of(context).choose_a_project,
                  validator: Utils.emptyValidatorDropdown,
                  validateString: context
                      .watch<CreateNewProjRegistrationPrv>()
                      .validateProject,
                ),
                vpad(12),
                PrimaryDropDownSearch(
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
                vpad(12),
                PrimaryDropDown(
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
                vpad(12),
                PrimaryTextField(
                  controller: context
                      .read<CreateNewProjRegistrationPrv>()
                      .contractNumController,
                  isRequired: true,
                  hint: S.of(context).enter_sell_contract_num,
                  label: S.of(context).sell_contract_num,
                  validator: Utils.emptyValidator,
                  validateString: context
                      .watch<CreateNewProjRegistrationPrv>()
                      .validateContractNum,
                ),
                vpad(40),
                PrimaryButton(
                  onTap: context.read<CreateNewProjRegistrationPrv>().onSubmit,
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
