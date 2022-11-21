import 'package:app_cudan/widgets/primary_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_screen.dart';
import '../../../widgets/primary_text_field.dart';
import '../../../widgets/select_media_widget.dart';
import 'providers/register_transportation_card_prv.dart';

class RegisterTransportationCard extends StatefulWidget {
  const RegisterTransportationCard({Key? key}) : super(key: key);
  static const routeName = '/transportation-card/register';

  @override
  State<RegisterTransportationCard> createState() =>
      _RegisterTransportationCardState();
}

class _RegisterTransportationCardState
    extends State<RegisterTransportationCard> {
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;

    var isEdit = arg['isEdit'];
    return ChangeNotifierProvider(
      create: (context) => RegisterTransportationCardPrv(),
      builder: (context, state) {
        return PrimaryScreen(
          appBar: PrimaryAppbar(
              title: isEdit
                  ? S.of(context).edit_trans_card
                  : S.of(context).register_trans_card),
          body: ListView(
            padding: EdgeInsets.only(
                top: appbarHeight(context) + topSafePad(context) + 24,
                left: 12,
                right: 12),
            children: [
              Text(S.of(context).resident_info),
              vpad(12),
              PrimaryDropDown(
                label: S.of(context).apartment,
                // selectList: context.of,
              ),
              vpad(12),
              PrimaryTextField(
                  controller: context
                      .read<RegisterTransportationCardPrv>()
                      .vTypeController,
                  label: 'S.of(context).vehicle_type',
                  hint: 'S.of(context).vehicle_type',
                  isReadOnly: true,
                  isRequired: true,
                  suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                  onTap: () {
                    context
                        .read<RegisterTransportationCardPrv>()
                        .selectVehicleType(context);
                  }),
              vpad(16),
              PrimaryTextField(
                  controller: context
                      .read<RegisterTransportationCardPrv>()
                      .memberController,
                  label: 'S.of(context).member',
                  hint: 'S.of(context).member',
                  isReadOnly: true,
                  isRequired: true,
                  suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                  onTap: () {
                    context
                        .read<RegisterTransportationCardPrv>()
                        .selectMember(context);
                  }),
              vpad(16),
              PrimaryTextField(
                controller: context
                    .read<RegisterTransportationCardPrv>()
                    .vComController,
                label: 'S.of(context).vehicle_com',
                hint: 'S.of(context).enter_vehicle_com',
                isRequired: true,
              ),
              vpad(16),
              PrimaryTextField(
                controller:
                    context.read<RegisterTransportationCardPrv>().lpController,
                label: 'S.of(context).license_plates',
                hint: 'S.of(context).enter_license_plates',
                isRequired: true,
              ),
              vpad(16),
              PrimaryTextField(
                controller: context
                    .read<RegisterTransportationCardPrv>()
                    .colorController,
                label: 'S.of(context).vehicle_color',
                hint: 'S.of(context).enter_vehicle_color',
                isRequired: true,
              ),
              vpad(16),
              PrimaryTextField(
                controller: context
                    .read<RegisterTransportationCardPrv>()
                    .rNumController,
                label: 'S.of(context).registration_num',
                hint: 'S.of(context).enter_registration_num',
                isRequired: true,
              ),
              vpad(8),
              Row(
                children: [
                  Checkbox(
                    value:
                        context.watch<RegisterTransportationCardPrv>().isOwner,
                    side: const BorderSide(color: secondaryColor3, width: 2),
                    onChanged: context
                        .read<RegisterTransportationCardPrv>()
                        .onChangeOwnerOfV,
                    activeColor: secondaryColor2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                  hpad(8),
                  Text('S.of(context).owner_of_vehicle',
                      style: txtBodySmallBold(color: grayScaleColor2))
                ],
              ),
              vpad(8),
              PrimaryTextField(
                controller: context
                    .read<RegisterTransportationCardPrv>()
                    .noteController,
                label: 'S.of(context).note',
                hint: 'S.of(context).enter_note',
                maxLines: 4,
              ),
              vpad(16),
              SelectMediaWidget(
                images: context.watch<RegisterTransportationCardPrv>().images,
                title: 'S.of(context).vehicle_photo',
                onRemove: context
                    .read<RegisterTransportationCardPrv>()
                    .onRemoveImageV,
                onSelect: () {
                  context
                      .read<RegisterTransportationCardPrv>()
                      .onSelectImageVehicle(context);
                },
              ),
              vpad(36),
              PrimaryButton(
                text: 'S.of(context).register',
                onTap: () {},
              ),
              vpad(MediaQuery.of(context).padding.bottom + 24)
            ],
          ),
        );
      },
    );
  }
}
