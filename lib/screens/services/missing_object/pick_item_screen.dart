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
import 'prv/pick_item_prv.dart';

class PickItemScreen extends StatefulWidget {
  const PickItemScreen({super.key});
  static const routeName = '/missing-object/pick';

  @override
  State<PickItemScreen> createState() => _PickItemScreenState();
}

class _PickItemScreenState extends State<PickItemScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PickItemPrv(),
      builder: (context, child) {
        return PrimaryScreen(
          appBar: PrimaryAppbar(
            title: S.of(context).found_object,
          ),
          body: SafeArea(
            child: Form(
              onChanged: context.watch<PickItemPrv>().autoValid
                  ? () => context.read<PickItemPrv>().validate(context)
                  : null,
              autovalidateMode: context.watch<PickItemPrv>().autoValid
                  ? AutovalidateMode.onUserInteraction
                  : null,
              key: context.read<PickItemPrv>().formKey,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  vpad(24),
                  PrimaryTextField(
                    maxLength: 255,
                    validateString: context.read<PickItemPrv>().validateName,
                    controller: context.read<PickItemPrv>().nameController,
                    label: S.of(context).object_name,
                    isRequired: true,
                    hint: S.of(context).object_name,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return '';
                      }
                      return null;
                    },
                  ),
                  vpad(16),
                  PrimaryTextField(
                    maxLength: 255,
                    validateString: context.read<PickItemPrv>().validatePlace,
                    controller: context.read<PickItemPrv>().placeController,
                    label: S.of(context).found_place,
                    isRequired: true,
                    hint: S.of(context).found_place,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return '';
                      }
                      return null;
                    },
                  ),
                  vpad(16),
                  PrimaryTextField(
                    validateString:
                        context.read<PickItemPrv>().validateFoundTime,
                    controller: context.read<PickItemPrv>().foundController,
                    label: S.of(context).found_time,
                    isRequired: true,
                    isReadOnly: true,
                    hint: "dd/mm/yyyy",
                    onTap: () {
                      context.read<PickItemPrv>().pickFoundDate(context);
                    },
                    suffixIcon: const PrimaryIcon(icons: PrimaryIcons.calendar),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return '';
                      }
                      return null;
                    },
                  ),
                  vpad(16),
                  SelectMediaWidget(
                    isRequired: true,
                    title: S.of(context).photos,
                    existImages: context.watch<PickItemPrv>().existedImage,
                    images: context.watch<PickItemPrv>().imagesPick,
                    onRemove: context.read<PickItemPrv>().onRemoveImagePick,
                    onRemoveExist:
                        context.read<PickItemPrv>().removeExistedImages,
                    onSelect: () =>
                        context.read<PickItemPrv>().onSelectImagePick(context),
                  ),
                  vpad(16),
                  PrimaryTextField(
                    maxLength: 500,
                    hint: S.of(context).note,
                    controller: context.read<PickItemPrv>().noteController,
                    label: S.of(context).note,
                    maxLines: 3,
                  ),
                  vpad(30),
                  PrimaryButton(
                    isLoading: context.watch<PickItemPrv>().isLoading,
                    text: S.of(context).send_letter,
                    onTap: () =>
                        context.read<PickItemPrv>().submitPick(context),
                  ),
                  vpad(40),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
