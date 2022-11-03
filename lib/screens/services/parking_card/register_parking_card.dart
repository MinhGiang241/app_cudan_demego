import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_screen.dart';
import '../../../widgets/primary_text_field.dart';
import '../../../widgets/select_media_widget.dart';
import 'providers/register_parking_card_prv.dart';

class RegisterParkingCard extends StatefulWidget {
  const RegisterParkingCard({Key? key}) : super(key: key);

  @override
  State<RegisterParkingCard> createState() => _RegisterParkingCardState();
}

class _RegisterParkingCardState extends State<RegisterParkingCard> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegisterParkingCardPrv(),
      builder: (context, state) {
        return PrimaryScreen(
          appBar: PrimaryAppbar(title: 'S.of(context).register_parking_card'),
          body: ListView(
            padding: EdgeInsets.only(
                top: appbarHeight(context) + topSafePad(context) + 24,
                left: 24,
                right: 24),
            children: [
              PrimaryTextField(
                  controller:
                      context.read<RegisterParkingCardPrv>().vTypeController,
                  label: 'S.of(context).vehicle_type',
                  hint: 'S.of(context).vehicle_type',
                  isReadOnly: true,
                  isRequired: true,
                  suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                  onTap: () {
                    context
                        .read<RegisterParkingCardPrv>()
                        .selectVehicleType(context);
                  }),
              vpad(16),
              PrimaryTextField(
                  controller:
                      context.read<RegisterParkingCardPrv>().memberController,
                  label: 'S.of(context).member',
                  hint: 'S.of(context).member',
                  isReadOnly: true,
                  isRequired: true,
                  suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                  onTap: () {
                    context
                        .read<RegisterParkingCardPrv>()
                        .selectMember(context);
                  }),
              vpad(16),
              PrimaryTextField(
                controller:
                    context.read<RegisterParkingCardPrv>().vComController,
                label: 'S.of(context).vehicle_com',
                hint: 'S.of(context).enter_vehicle_com',
                isRequired: true,
              ),
              vpad(16),
              PrimaryTextField(
                controller: context.read<RegisterParkingCardPrv>().lpController,
                label: 'S.of(context).license_plates',
                hint: 'S.of(context).enter_license_plates',
                isRequired: true,
              ),
              vpad(16),
              PrimaryTextField(
                controller:
                    context.read<RegisterParkingCardPrv>().colorController,
                label: 'S.of(context).vehicle_color',
                hint: 'S.of(context).enter_vehicle_color',
                isRequired: true,
              ),
              vpad(16),
              PrimaryTextField(
                controller:
                    context.read<RegisterParkingCardPrv>().rNumController,
                label: 'S.of(context).registration_num',
                hint: 'S.of(context).enter_registration_num',
                isRequired: true,
              ),
              vpad(8),
              Row(
                children: [
                  Checkbox(
                    value: context.watch<RegisterParkingCardPrv>().isOwner,
                    side: const BorderSide(color: secondaryColor3, width: 2),
                    onChanged:
                        context.read<RegisterParkingCardPrv>().onChangeOwnerOfV,
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
                controller:
                    context.read<RegisterParkingCardPrv>().noteController,
                label: 'S.of(context).note',
                hint: 'S.of(context).enter_note',
                maxLines: 4,
              ),
              vpad(16),
              SelectMediaWidget(
                images: context.watch<RegisterParkingCardPrv>().images,
                title: 'S.of(context).vehicle_photo',
                onRemove: context.read<RegisterParkingCardPrv>().onRemoveImageV,
                onSelect: () {
                  context
                      .read<RegisterParkingCardPrv>()
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
