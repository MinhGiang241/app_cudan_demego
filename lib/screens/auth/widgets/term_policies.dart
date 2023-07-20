import 'package:app_cudan/constants/constants.dart';
import 'package:app_cudan/widgets/primary_button.dart';
import 'package:flutter/material.dart';

import '../../../constants/policies.dart';
import '../../../generated/l10n.dart';
import '../../../widgets/primary_card.dart';

var showTermPolicies = (context) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) => PrimaryCard(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: dvHeight(context) * 0.8,
      child: ListView(
        children: [
          vpad(24),
          ...policies.map(
            (e) => textformat(e),
          ),
          vpad(24),
          Column(
            children: [
              PrimaryButton(
                isFit: false,
                width: 120,
                text: S.of(context).close,
                buttonSize: ButtonSize.medium,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          vpad(24),
        ],
      ),
    ),
  );
};

var textformat = (e) {
  switch (e['type']) {
    case PType.title:
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text(
          e['content'],
          style: txtBodyMediumBold(color: grayScaleColorBase),
          textAlign: TextAlign.center,
        ),
      );
    case PType.nomal:
      return Text(
        e['content'],
        style: txtBodySmallRegular(color: grayScaleColorBase),
      );
    case PType.bold:
      return Text(
        e['content'],
        style: txtBodySmallBold(color: grayScaleColorBase),
      );
    case PType.list:
      return Text(
        "   * " + e['content'],
        style: txtBodySmallRegular(color: grayScaleColorBase),
      );
    default:
      return Text(e['content']);
  }
};
