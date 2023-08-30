import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../services/api_service.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_icon.dart';
import '../../../widgets/primary_loading.dart';
import '../../../widgets/primary_screen.dart';
import '../../../widgets/primary_text_field.dart';
import '../../auth/prv/auth_prv.dart';
import 'provider/edit_info_provider.dart';

class EditPersonalInfo extends StatelessWidget {
  const EditPersonalInfo({super.key});
  @override
  Widget build(BuildContext context) {
    final user = context.read<ResidentInfoPrv>().userInfo!.account;
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
                    // await context.read<EditInfoProvider>().save(context);
                    Utils.showErrorMessage(
                      context,
                      "Tính năng đang nâng cấp , chưa sử dụng được",
                    );
                  },
                  child: Text(
                    S.of(context).save,
                    style: txtLinkMedium(color: primaryColorBase),
                  ),
                )
              else
                const SizedBox(
                  width: 64,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: PrimaryLoading(height: 20, width: 20),
                    ),
                  ),
                ),
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
                            ),
                          )
                        else
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: grayScaleColor4,
                            backgroundImage: CachedNetworkImageProvider(
                              "${ApiService.shared.uploadURL}?load=$avatarLink&regcode=${ApiService.shared.regCode}",
                            ),
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
                        ),
                      ),
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
                      isReadOnly: true,
                      enable: false,
                      background: grayScaleColor4,
                      controller:
                          context.read<EditInfoProvider>().userNameController,
                      label: S.current.username,
                      hint: S.of(context).enter_num,
                    ),
                    vpad(16),
                    PrimaryTextField(
                      controller:
                          context.read<EditInfoProvider>().emailController,
                      label: S.of(context).email,
                      hint: S.of(context).enter_email,
                    ),
                    vpad(16),
                    PrimaryTextField(
                      controller:
                          context.read<EditInfoProvider>().phoneController,
                      label: S.of(context).phone_num,
                      hint: S.of(context).enter_phone,
                    ),
                    // vpad(16),
                    // PrimaryTextField(
                    //   controller:
                    //       context.read<EditInfoProvider>().countryController,
                    //   label: "S.of(context).country",
                    //   hint: " S.of(context).enter_country",
                    //   textCapitalization: TextCapitalization.words,
                    // ),
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
