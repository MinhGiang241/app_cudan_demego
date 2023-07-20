import 'package:flutter/material.dart';

import '../../../widgets/primary_icon.dart';

class EventWidget extends StatelessWidget {
  const EventWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xff23D2C3).withOpacity(0.2),
          ),
        ),
        Positioned(
          top: 8,
          left: 9,
          child: Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xff23D2C3).withOpacity(0.6),
              // boxShadow: [
              //   BoxShadow(
              //       color: const Color(0xff009ED0).withOpacity(0.16),
              //       offset: const Offset(0, 16),
              //       blurRadius: 24)
              // ],
            ),
            child: const PrimaryIcon(
              icons: PrimaryIcons.calendar_check,
              style: PrimaryIconStyle.none,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
