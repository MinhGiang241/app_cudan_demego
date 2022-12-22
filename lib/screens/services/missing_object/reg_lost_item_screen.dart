import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:app_cudan/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_icon.dart';
import '../../../widgets/select_media_widget.dart';
import 'prv/reg_lost_item_prv.dart';

class RegisterLostItemScreen extends StatefulWidget {
  const RegisterLostItemScreen({super.key});
  static const routeName = '/missing-object/register';

  @override
  State<RegisterLostItemScreen> createState() => _RegisterLostItemScreenState();
}

class _RegisterLostItemScreenState extends State<RegisterLostItemScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegisterLostItemPrv(),
      builder: (context, child) {
        return PrimaryScreen(
            appBar: PrimaryAppbar(
              title: S.of(context).reg_missing_obj,
            ),
            body: SafeArea(
              child: Form(
                key: context.read<RegisterLostItemPrv>().formKey,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  children: [
                    vpad(24),
                    PrimaryTextField(
                      validateString:
                          context.read<RegisterLostItemPrv>().validateName,
                      controller:
                          context.read<RegisterLostItemPrv>().nameController,
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
                      validateString:
                          context.read<RegisterLostItemPrv>().validateLostTime,
                      controller: context
                          .read<RegisterLostItemPrv>()
                          .lostDateController,
                      label: S.of(context).missing_time,
                      isRequired: true,
                      isReadOnly: true,
                      hint: "dd/mm/yyyy",
                      onTap: () {
                        context
                            .read<RegisterLostItemPrv>()
                            .pickLostDate(context);
                      },
                      suffixIcon:
                          const PrimaryIcon(icons: PrimaryIcons.calendar),
                      validator: (v) {
                        if (v!.isEmpty) {
                          return '';
                        }
                        return null;
                      },
                    ),
                    vpad(16),
                    SelectMediaWidget(
                      title: S.of(context).photos,
                      existImages:
                          context.watch<RegisterLostItemPrv>().existedImage,
                      images: context.watch<RegisterLostItemPrv>().imagesLost,
                      onRemove:
                          context.read<RegisterLostItemPrv>().onRemoveImageLost,
                      onRemoveExist: context
                          .read<RegisterLostItemPrv>()
                          .removeExistedImages,
                      onSelect: () => context
                          .read<RegisterLostItemPrv>()
                          .onSelectImageLost(context),
                    ),
                    vpad(16),
                    PrimaryTextField(
                      hint: S.of(context).note,
                      controller:
                          context.read<RegisterLostItemPrv>().noteController,
                      label: S.of(context).note,
                      maxLines: 3,
                    ),
                    vpad(30),
                    PrimaryButton(
                      isLoading: context.watch<RegisterLostItemPrv>().isLoading,
                      text: S.of(context).send_letter,
                      onTap: () => context
                          .read<RegisterLostItemPrv>()
                          .submitRegister(context),
                    ),
                    vpad(40),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
