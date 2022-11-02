import 'package:app_cudan/widgets/primary_icon.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:app_cudan/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../../widgets/search_bar.dart';

var data = [
  {
    "background": gradientRed,
    "icon": PrimaryIcons.bell_fill,
    "title": S.current.services
  },
  {
    "background": gradientRed,
    "icon": PrimaryIcons.bell_fill,
    "title": S.current.services
  },
  {
    "background": gradientRed,
    "icon": PrimaryIcons.bell_fill,
    "title": S.current.services
  },
  {
    "background": gradientRed,
    "icon": PrimaryIcons.bell_fill,
    "title": S.current.services
  },
  {
    "background": gradientRed,
    "icon": PrimaryIcons.bell_fill,
    "title": S.current.services
  },
  {
    "background": gradientRed,
    "icon": PrimaryIcons.bell_fill,
    "title": S.current.services
  },
];

class ServiceScreen extends StatelessWidget {
  const ServiceScreen({super.key});
  static const routeName = '/services';

  @override
  Widget build(BuildContext context) {
    return PrimaryScreen(
        appBar: AppBar(backgroundColor: Colors.transparent),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              vpad(12),
              Center(
                child: Text(
                  S.of(context).services,
                  style: txtDisplayMedium(),
                ),
              ),
              SearchBar(),
              vpad(12),
              GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 18,
                crossAxisSpacing: 12,
                children: [
                  ...data.map(
                    (e) => Container(),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
