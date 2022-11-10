import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_icon.dart';
import '../../../widgets/primary_screen.dart';
import '../../../widgets/primary_text_field.dart';
import '../../../widgets/select_media_widget.dart';
import 'provider/register_r_card_prov.dart';

class RegisterRecidentCard extends StatefulWidget {
  const RegisterRecidentCard({Key? key}) : super(key: key);

  @override
  State<RegisterRecidentCard> createState() => _RegisterRecidentCardState();
}

class _RegisterRecidentCardState extends State<RegisterRecidentCard> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => RegisterRCardPrv(),
        builder: (context, child) {
          return PrimaryScreen(
            appBar: PrimaryAppbar(title: ' S.of(context).register_r_card'),
            body: ListView(
              padding: EdgeInsets.only(
                  top: AppBar().preferredSize.height +
                      MediaQuery.of(context).padding.top +
                      24,
                  left: 12,
                  right: 12,
                  bottom: 24),
              children: [
                PrimaryTextField(
                    controller: context.read<RegisterRCardPrv>().typeController,
                    label: S.of(context).type,
                    hint: S.of(context).choices,
                    isReadOnly: true,
                    isRequired: true,
                    suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                    onTap: () {
                      context.read<RegisterRCardPrv>().selectType(context);
                    }),
                vpad(16),
                PrimaryTextField(
                    controller: context.read<RegisterRCardPrv>().nameController,
                    label: S.of(context).full_name,
                    hint: S.of(context).enter_name,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    isRequired: true),
                vpad(16),
                PrimaryTextField(
                  controller:
                      context.read<RegisterRCardPrv>().relationshipController,
                  label: 'S.of(context).relationship_owner',
                  hint: 'S.of(context).relationship_owner',
                  isReadOnly: true,
                  suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                  isRequired: true,
                  onTap: () {
                    context
                        .read<RegisterRCardPrv>()
                        .selectRelationship(context);
                  },
                ),
                vpad(16),
                PrimaryTextField(
                  controller: context.read<RegisterRCardPrv>().genderController,
                  label: 'S.of(context).gender',
                  hint: 'S.of(context).gender',
                  isReadOnly: true,
                  suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                  isRequired: true,
                  onTap: () {
                    context.read<RegisterRCardPrv>().selectGender(context);
                  },
                ),
                vpad(16),
                PrimaryTextField(
                  controller:
                      context.read<RegisterRCardPrv>().dateOfBirthController,
                  label: 'S.of(context).date_of_birth',
                  hint: "dd/MM/yyyy",
                  prefixIcon: const PrimaryIcon(icons: PrimaryIcons.calendar),
                  isReadOnly: true,
                  isRequired: true,
                  onTap: () {
                    context.read<RegisterRCardPrv>().selectDateOfBirth(context);
                  },
                ),
                vpad(16),
                PrimaryTextField(
                    controller:
                        context.read<RegisterRCardPrv>().idNumController,
                    label: ' S.of(context).id_number',
                    hint: S.of(context).enter_num,
                    isRequired: true),
                vpad(16),
                PrimaryTextField(
                    controller:
                        context.read<RegisterRCardPrv>().countryController,
                    label: 'S.of(context).country',
                    hint: 'S.of(context).country',
                    isRequired: true),
                vpad(16),
                PrimaryTextField(
                    controller:
                        context.read<RegisterRCardPrv>().emaiOrPhoneController,
                    label: S.of(context).phone_num,
                    hint: S.of(context).enter,
                    isRequired: true),
                vpad(16),
                SelectMediaWidget(
                  images: context.watch<RegisterRCardPrv>().listRImage,
                  onSelect: () {
                    context
                        .read<RegisterRCardPrv>()
                        .onSelecImageRecident(context);
                  },
                  onRemove:
                      context.read<RegisterRCardPrv>().onRemoveImageRecident,
                  title: ' S.of(context).r_photo',
                ),
                vpad(16),
                SelectMediaWidget(
                  images: context.watch<RegisterRCardPrv>().listIDImage,
                  onRemove: context.read<RegisterRCardPrv>().onRemoveImageId,
                  onSelect: () {
                    context.read<RegisterRCardPrv>().onSelecImageId(context);
                  },
                  title: 'S.of(context).id_photo',
                ),
                vpad(16),
                SelectMediaWidget(
                  images: context.watch<RegisterRCardPrv>().listTTImage,
                  onRemove: context.read<RegisterRCardPrv>().onRemoveImageTT,
                  onSelect: () {
                    context.read<RegisterRCardPrv>().onSelecImageTT(context);
                  },
                  title: 'S.of(context).tt_photo',
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
        });
  }
}
