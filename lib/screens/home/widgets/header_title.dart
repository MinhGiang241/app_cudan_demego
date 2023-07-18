import 'package:app_cudan/screens/notification/prv/notification_prv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../widgets/primary_icon.dart';
import '../../notification/notification_screen.dart';

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({
    Key? key,
    required this.onMenuTab,
  }) : super(key: key);
  final Function onMenuTab;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: IconButton(
        onPressed: () {
          onMenuTab(2);
        },
        icon: Icon(Icons.menu),
      ),
      title: Center(
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "DEME", style: txtBold(24)),
              TextSpan(text: "PRO", style: txtBold(24, yellowColor1)),
            ],
          ),
        ),
      ),
      trailing: FutureBuilder(
        future: context.read<NotificationPrv>().getUnReadNotification(context),
        builder: (context, snapshot) {
          var badgeNum = context.watch<NotificationPrv>().unRead;
          return PrimaryIcon(
            icons: PrimaryIcons.bell_outline,
            style: PrimaryIconStyle.gradient,
            color: grayScaleColor2,
            badge: badgeNum != 0 ? "${badgeNum}" : null,
            onTap: () {
              Navigator.pushNamed(context, NotificationScreen.routeName);
            },
          );
        },
      ),
    );
  }
}
