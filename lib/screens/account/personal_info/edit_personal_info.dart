import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/api_constant.dart';
import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_icon.dart';
import '../../../widgets/primary_loading.dart';
import '../../../widgets/primary_screen.dart';
import '../../../widgets/primary_text_field.dart';
import '../../auth/prv/auth_prv.dart';
import 'provider/edit_info_provider.dart';

class EditPersonalInfo extends StatelessWidget {
  final user;

  const EditPersonalInfo({super.key, this.user});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EditInfoProvider(user, context.read<AuthPrv>()),
      builder: (context, child) {
        final fileAvatar = context.watch<EditInfoProvider>().avatar;
        final avatarLink = context.watch<EditInfoProvider>().avatarLink;
        return PrimaryScreen(
          appBar: PrimaryAppbar(
            title: S.of(context).personal_info,
            actions: [
              if (!context.watch<EditInfoProvider>().isSaving)
                TextButton(
                    onPressed: () async {
                      await context.read<EditInfoProvider>().save(context);
                    },
                    child: Text(S.of(context).save,
                        style: txtLinkMedium(color: primaryColorBase)))
              else
                const SizedBox(
                  width: 64,
                  child: Center(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: PrimaryLoading(height: 20, width: 20),
                  )),
                )
            ],
          ),
          body: ListView(
            children: [
              vpad(30),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    await context.read<EditInfoProvider>().selectImage(context);
                  },
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      if (fileAvatar == null)
                        if (avatarLink == null)
                          const CircleAvatar(
                              radius: 60,
                              backgroundColor: grayScaleColor4,
                              child: Icon(
                                Icons.person,
                                size: 80,
                              ))
                        else
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: grayScaleColor4,
                            backgroundImage: CachedNetworkImageProvider(
                                ApiConstants.baseURL + avatarLink),
                          ),
                      if (fileAvatar != null)
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: grayScaleColor4,
                          backgroundImage: FileImage(fileAvatar),
                        ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: PrimaryIcon(
                            icons: PrimaryIcons.camera,
                            padding: const EdgeInsets.all(6),
                            style: PrimaryIconStyle.gradient,
                            gradients: PrimaryIconGradient.white,
                            borderRadius: BorderRadius.circular(50),
                          ))
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    PrimaryTextField(
                      controller:
                          context.read<EditInfoProvider>().nameController,
                      label: S.of(context).full_name,
                      hint: S.of(context).enter_name,
                    ),
                    vpad(16),
                    PrimaryTextField(
                      controller:
                          context.read<EditInfoProvider>().idNumController,
                      label: "S.of(context).id_number",
                      hint: S.of(context).enter_num,
                    ),
                    vpad(16),
                    PrimaryTextField(
                      controller: context
                          .read<EditInfoProvider>()
                          .dateOfBirthController,
                      label: "S.of(context).date_of_birth",
                      hint: "dd/MM/yyyy",
                      isReadOnly: true,
                      onTap: () async {
                        await context
                            .read<EditInfoProvider>()
                            .birthDayPicker(context);
                      },
                      prefixIcon:
                          const PrimaryIcon(icons: PrimaryIcons.calendar),
                    ),
                    vpad(16),
                    PrimaryTextField(
                      controller:
                          context.read<EditInfoProvider>().genderController,
                      label: " S.of(context).gender",
                      hint: S.of(context).choices,
                      isReadOnly: true,
                      onTap: () async {
                        await context
                            .read<EditInfoProvider>()
                            .selectGender(context);
                      },
                      suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                    ),
                    vpad(16),
                    PrimaryTextField(
                      controller:
                          context.read<EditInfoProvider>().countryController,
                      label: "S.of(context).country",
                      hint: " S.of(context).enter_country",
                      textCapitalization: TextCapitalization.words,
                    ),
                  ],
                ),
              ),
              vpad(100),
            ],
          ),
        );
      },
    );
  }
}
