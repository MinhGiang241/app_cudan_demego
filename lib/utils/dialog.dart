import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_dialog.dart';

var onConfirmDelete =
    (BuildContext context, String title, Function() onDelete) {
  Utils.showDialog(
    context: context,
    dialog: PrimaryDialog.custom(
      title: title,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PrimaryButton(
            text: S.of(context).delete,
            buttonSize: ButtonSize.medium,
            onTap: () {
              onDelete();
            },
          ),
          hpad(35),
          PrimaryButton(
            text: S.of(context).cancel,
            buttonSize: ButtonSize.medium,
            buttonType: ButtonType.secondary,
            secondaryBackgroundColor: redColor4,
            textColor: redColor,
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ),
  );
};
