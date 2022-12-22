import 'package:app_cudan/screens/auth/prv/auth_prv.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../../widgets/primary_card.dart';
import '../../widgets/primary_icon.dart';
import '../../widgets/primary_text_field.dart';
import 'apartment_selection_screen.dart';

class ProjectSelectionScreen extends StatelessWidget {
  const ProjectSelectionScreen({super.key});
  static const routeName = '/project-selection';

  @override
  Widget build(BuildContext context) {
    var projects = [
      {"title": "Dự án 1", "desc": "Thông tin dự án "},
    ];
    return PrimaryScreen(
        appBar: AppBar(
          elevation: 0,
          leading: vpad(0),
          actions: [
            IconButton(
                onPressed: () {
                  context.read<AuthPrv>().onSignOut(context);
                },
                icon: const Icon(Icons.logout)),
            hpad(12)
          ],
        ),
        body: Column(
          children: [
            vpad(24 +
                AppBar().preferredSize.height +
                MediaQuery.of(context).padding.top),
            Center(
                child: Text(S.of(context).choose_a_project,
                    style: txtDisplayMedium())),
            vpad(36),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 12),
            //   child: PrimaryTextField(
            //     hint: S.of(context).search_project,
            //     prefixIcon: const Padding(
            //       padding: EdgeInsets.all(12.0),
            //       child: PrimaryIcon(
            //           icons: PrimaryIcons.search_outline,
            //           color: grayScaleColor2),
            //     ),
            //   ),
            // ),
            // vpad(16),
            Expanded(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                children: [
                  ...projects.map(
                    (e) => PrimaryCard(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              ApartmentSeletionScreen.routeName,
                              arguments: e['title']);
                        },
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(children: [
                            const PrimaryIcon(
                              icons: PrimaryIcons.home_smile,
                              color: primaryColor4,
                              backgroundColor: primaryColor5,
                              style: PrimaryIconStyle.round,
                              padding: EdgeInsets.all(12),
                            ),
                            hpad(16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(e['title'] ?? '', style: txtLinkSmall()),
                                vpad(4),
                                Text(e['desc'] ?? '',
                                    style: txtBodySmallBold()),
                              ],
                            )
                          ]),
                        )),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
