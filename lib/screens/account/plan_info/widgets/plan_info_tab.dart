import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../../../models/info_content_view.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/dash_button.dart';
import '../../../../widgets/primary_icon.dart';
import '../../../../widgets/primary_info_widget.dart';
import '../../r_card/register_r_card.dart';

class PlanInfoTab extends StatelessWidget {
  const PlanInfoTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
            padding: const EdgeInsets.all(12.0),
            child: DashButton(
              text: "S.of(context).register_r_card",
              icon: const PrimaryIcon(
                icons: PrimaryIcons.home_alt,
                style: PrimaryIconStyle.none,
              ),
              onTap: () {
                Utils.pushScreen(context, const RegisterRecidentCard());
              },
            )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: PrimaryInfoWidget(listInfoView: [
            InfoContentView(title: 'S.of(context).signal', content: "ABCXYZ"),
            InfoContentView(
                title: "S.of(context).plan_name", content: "Tên mặt bằng"),
            InfoContentView(title: 'S.of(context).area', content: "100 m2"),
            InfoContentView(
                title: ' S.of(context).free_r_card', content: "1 thẻ"),
            InfoContentView(
                title: 'S.of(context).free_r_card_issued', content: "2 thẻ"),
          ]),
        )
      ],
    );
  }
}
