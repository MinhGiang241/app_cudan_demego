import 'package:app_cudan/screens/auth/prv/auth_prv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import '../../../constants/constants.dart';
import '../../../widgets/primary_icon.dart';

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(math.pi),
        child: IconButton(
          onPressed: () {
            context.read<AuthPrv>().onSignOut(context);
          },
          icon: const Icon(Icons.logout),
        ),
      ),
      title: Center(
        child: Text.rich(TextSpan(children: [
          TextSpan(text: "DEME", style: txtBold(24)),
          TextSpan(text: "GO", style: txtBold(24, yellowColor1)),
        ])),
      ),
      trailing: PrimaryIcon(
          icons: PrimaryIcons.bell_outline,
          style: PrimaryIconStyle.gradient,
          color: grayScaleColor2,
          //badge: "2",
          onTap: () {
            // Utils.pushScreen(context, const NotificationScreen());
          }),
    );
  }
}
