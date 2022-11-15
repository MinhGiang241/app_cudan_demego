import 'package:app_cudan/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../constants/constants.dart';
import '../generated/l10n.dart';
import 'primary_card.dart';

class ConnectError extends StatelessWidget {
  ConnectError({super.key, this.onTap, this.title});
  Function()? onTap;
  String? title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PrimaryCard(
        width: 300,
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              S.of(context).err_conn,
              style: txtBodyLargeBold(color: grayScaleColorBase),
            ),
            if (title != null) vpad(20),
            if (title != null)
              Text(
                title ?? "",
                style: txtBodySmallRegular(color: grayScaleColorBase),
              ),
            vpad(20),
            PrimaryButton(
              buttonType: ButtonType.secondary,
              secondaryBackgroundColor: redColor2,
              buttonSize: ButtonSize.small,
              text: "", // S.of(context).reload,
              onTap: onTap,
            )
          ],
        ),
      ),
    );
  }
}
