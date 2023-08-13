import 'package:app_cudan/widgets/primary_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import '../../../../constants/constants.dart';
import '../prv/add_new_letter_ultility_prv.dart';

class SelectLocationPage extends StatelessWidget {
  const SelectLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    var locationList = context.watch<AddNewLetterUltilityPrv>().locationList;
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 4),
      children: [
        vpad(12),
        PrimaryCard(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          border: Border.all(
            color: primaryColorBase,
            style: BorderStyle.solid,
            width: 2,
            // strokeAlign: BorderSide.strokeAlignInside,
          ),
          child: Text(
            "Nướng BBQ",
            style: txtBold(14, orangeColor),
          ),
        ),
        vpad(12),
        ...locationList.map((v) {
          return InkWell(
            onTap: () => context
                .read<AddNewLetterUltilityPrv>()
                .onNextStep2(context, v['name'] as String),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 6),
              child: Row(
                children: [
                  Text(v['name'] as String),
                  Spacer(),
                  Transform.rotate(
                    child: Icon(Icons.expand_more),
                    angle: -math.pi / 2,
                  )
                ],
              ),
            ),
          );
        })
      ],
    );
  }
}
