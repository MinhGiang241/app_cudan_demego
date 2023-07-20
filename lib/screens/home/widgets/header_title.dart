import 'package:app_cudan/screens/notification/prv/notification_prv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../widgets/primary_icon.dart';
import '../../notification/notification_screen.dart';
import '../../notification/prv/undread_noti.dart';

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
      trailing:
          //FutureBuilder(
          //future: context.read<NotificationPrv>().getUnReadNotification(),
          // builder: (context, snapshot) {
          //  var badgeNum = context.watch<NotificationPrv>().unRead;
          //return
          StreamBuilder(
        stream: UnreadNotification.count.stream,
        builder: (context, snapshot) {
          return PrimaryIcon(
            icons: PrimaryIcons.bell_outline,
            style: PrimaryIconStyle.gradient,
            color: grayScaleColor2,
            badge: snapshot.data != null ? snapshot.data.toString() : null,
            onTap: () {
              context.read<NotificationPrv>().resetSelectType();
              Navigator.pushNamed(context, NotificationScreen.routeName);
            },
            //  );
            //},
          );
        },
      ),
    );
  }
}
