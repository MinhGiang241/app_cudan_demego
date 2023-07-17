import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../constants/api_constant.dart';
import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../../services/api_ho_service.dart';
import '../../services/api_service.dart';
import '../../utils/utils.dart';
import '../../widgets/primary_card.dart';
import '../../widgets/primary_icon.dart';
import '../../widgets/primary_screen.dart';
import '../auth/prv/auth_prv.dart';
import 'change_pass/change_pass_screen.dart';
import 'language/language_screen.dart';
import 'personal_info/personal_info_screen.dart';
import 'plan_info/plan_info_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userInfo = context.watch<ResidentInfoPrv>().userInfo?.account;
    return PrimaryScreen(
      body: ListView(
        children: [
          vpad(60),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SizedBox(
              height: 64,
              child: Row(
                children: [
                  if (userInfo?.avatar == null)
                    const CircleAvatar(
                      radius: 32,
                      backgroundColor: grayScaleColor4,
                      child: Icon(
                        Icons.person,
                        size: 40,
                      ),
                    )
                  else if (userInfo?.avatar.runtimeType.toString() !=
                      "List<dynamic>")
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: grayScaleColor4,
                      backgroundImage: CachedNetworkImageProvider(
                        "${ApiService.shared.uploadURL}?load=${userInfo?.avatar ?? ""}&regcode=${ApiService.shared.regCode}",
                      ),
                    )
                  else if (userInfo?.avatar.runtimeType.toString() ==
                          "List<dynamic>" &&
                      (userInfo?.avatar as List).isNotEmpty)
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: grayScaleColor4,
                      backgroundImage: CachedNetworkImageProvider(
                        "${ApiService.shared.uploadURL}?load=${(userInfo?.avatar as List)[0]['file_id'] ?? ""}&regcode=${ApiService.shared.regCode}",
                      ),
                    )
                  else
                    const CircleAvatar(
                      radius: 32,
                      backgroundColor: grayScaleColor4,
                      child: Icon(
                        Icons.person,
                        size: 40,
                      ),
                    ),
                  hpad(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userInfo?.userName ?? "",
                          style: txtLinkLarge(),
                        ),
                        const Spacer(),
                        Text("", style: txtBodySmallRegular())
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          vpad(24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: PrimaryCard(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AccountItem(
                      lable: S.of(context).personal_info,
                      icons: PrimaryIcons.user_circle_outline,
                      onTap: () {
                        Utils.pushScreen(context, const PersonalInfoScreen());
                      },
                    ),
                    AccountItem(
                      lable: S.of(context).plan_info,
                      icons: PrimaryIcons.home_alt,
                      onTap: () {
                        Utils.pushScreen(context, const PlanInfoScreen());
                      },
                    ),
                    AccountItem(
                      lable: S.of(context).language,
                      icons: PrimaryIcons.planet,
                      onTap: () {
                        Utils.pushScreen(context, const LanguageScreen());
                      },
                    ),
                    AccountItem(
                      lable: S.of(context).terms_services,
                      icons: PrimaryIcons.news,
                      onTap: () {
                        launchUrlString("https://www.apple.com/");
                      },
                    ),
                    AccountItem(
                      lable: S.of(context).change_pass,
                      icons: PrimaryIcons.lock,
                      onTap: () {
                        Utils.pushScreen(context, const ChangePassScreen());
                      },
                    ),
                    AccountItem(
                      lable: S.of(context).sign_out,
                      icons: PrimaryIcons.log_out,
                      onTap: () {
                        context.read<AuthPrv>().onSignOut(context);
                      },
                    ),
                    vpad(8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: FutureBuilder<String>(
                        future: Utils.getVersion(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const SizedBox.shrink();
                          }
                          return Text(
                            "${S.of(context).app_version} ${snapshot.data}",
                            style: txtBodySmallRegular(color: grayScaleColor2),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          vpad(kBottomNavigationBarHeight + 30)
        ],
      ),
    );
  }
}

class AccountItem extends StatelessWidget {
  const AccountItem({
    Key? key,
    required this.lable,
    required this.icons,
    this.onTap,
  }) : super(key: key);
  final String lable;
  final PrimaryIcons icons;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          children: [
            PrimaryIcon(icons: icons),
            hpad(12),
            Expanded(child: Text(lable, style: txtBodySmallRegular())),
            const Icon(Icons.chevron_right_rounded, color: grayScaleColor4)
          ],
        ),
      ),
    );
  }
}
