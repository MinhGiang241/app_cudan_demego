import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_dropdown.dart';
import '../../../widgets/primary_icon.dart';
import '../../../widgets/primary_screen.dart';
import '../../../widgets/primary_text_field.dart';
import '../../auth/prv/resident_info_prv.dart';
import 'prv/genneral_info_prv.dart';

class GeneralInfoScreen extends StatelessWidget {
  const GeneralInfoScreen({super.key});
  static const routeName = '/hand-over/general';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GeneralInfoPrv(),
      builder: (context, builder) {
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
        return PrimaryScreen(
          appBar: PrimaryAppbar(
            title: context.watch<GeneralInfoPrv>().initPage == 0
                ? S.of(context).general_info
                : S.of(context).hand_over_asset_list,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: PageView(
                onPageChanged: context.watch<GeneralInfoPrv>().onChangePage,
                controller: context.read<GeneralInfoPrv>().pageController,
                children: [
                  SingleChildScrollView(
                    child: Form(
                      child: Column(
                        children: [
                          vpad(16),
                          PrimaryDropDown(
                            label: S.of(context).surface,
                            selectList: listApartmentChoice,
                            isDense: false,
                          ),
                          vpad(16),
                          PrimaryTextField(
                            validator: Utils.emptyValidator,
                            label: S.of(context).hand_over_date,
                            isRequired: true,
                            isReadOnly: true,
                            hint: "dd/mm/yyyy",
                            onTap: () => context
                                .read<GeneralInfoPrv>()
                                .pickHandOverDate(context),
                            suffixIcon:
                                const PrimaryIcon(icons: PrimaryIcons.calendar),
                            controller: context
                                .read<GeneralInfoPrv>()
                                .handOverDateController,
                            validateString: context
                                .watch<GeneralInfoPrv>()
                                .validateHandOverDate,
                          ),
                          vpad(16),
                          PrimaryTextField(
                            validator: Utils.emptyValidator,
                            label: S.of(context).hand_over_time,
                            isReadOnly: true,
                            isRequired: true,
                            onTap: () => context
                                .read<GeneralInfoPrv>()
                                .pickHandOverTime(context),
                            suffixIcon:
                                const PrimaryIcon(icons: PrimaryIcons.clock),
                            hint: "hh:mm",
                            controller: context
                                .read<GeneralInfoPrv>()
                                .handOverTimeController,
                            validateString: context
                                .watch<GeneralInfoPrv>()
                                .validateHandOverTime,
                          ),
                          vpad(16),
                          PrimaryTextField(
                            hint: S.of(context).note,
                            label: S.of(context).note,
                            maxLines: 3,
                            controller:
                                context.read<GeneralInfoPrv>().noteController,
                          ),
                          vpad(30),
                          PrimaryButton(
                            width: dvWidth(context) - 36,
                            text: S.of(context).next,
                          ),
                          vpad(40)
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        vpad(12),
                        // ...context
                        //     .watch<GeneralInfoPrv>()
                        //     .dataAsset
                        //     .asMap()
                        //     .entries
                        //     .map((e) => AssetItem(
                        //           region: e.value['title'] as String,
                        //           selectPass: context
                        //               .watch<GeneralInfoPrv>()
                        //               .selectItemPass,
                        //           data: AssetItemViewModel(list: dataAsset),
                        //           index: e.key,
                        //         )),
                        vpad(30),
                        PrimaryButton(
                          width: dvWidth(context) - 36,
                          text: S.of(context).confirm,
                        ),
                        vpad(40)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
