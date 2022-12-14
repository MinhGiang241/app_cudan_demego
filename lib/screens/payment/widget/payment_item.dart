import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../widgets/primary_card.dart';
import '../../../widgets/primary_icon.dart';

class PaymentItem extends StatelessWidget {
  const PaymentItem({
    Key? key,
    this.isPaid = false,
    this.isSelected = false,
    this.onSelect,
  }) : super(key: key);
  final bool isPaid;
  final bool isSelected;
  final Function()? onSelect;

  @override
  Widget build(BuildContext context) {
    return PrimaryCard(
      margin: const EdgeInsets.only(bottom: 16, left: 12, right: 12),
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        child: Row(
          children: [
            const PrimaryIcon(
              icons: PrimaryIcons.electricity,
              style: PrimaryIconStyle.gradient,
              gradients: PrimaryIconGradient.yellow,
              size: 32,
              padding: EdgeInsets.all(12),
              color: Colors.white,
            ),
            hpad(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hoá đơn tiền ", style: txtLinkSmall()),
                  vpad(2),
                  Text("1.578.000 VND", style: txtLinkSmall()),
                  vpad(2),
                  Text("2/2/2022", style: txtBodyXSmallRegular()),
                ],
              ),
            ),
            if (!isPaid)
              InkWell(
                onTap: onSelect,
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  width: 32,
                  height: 32,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    switchInCurve: Curves.easeOutBack,
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: ScaleTransition(
                          scale: animation,
                          child: child,
                        ),
                      );
                    },
                    child: isSelected
                        ? const PrimaryIcon(
                            padding: EdgeInsets.zero,
                            icons: PrimaryIcons.check,
                            size: 32,
                            color: primaryColor3,
                          )
                        : Container(
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 3, color: primaryColor3),
                                shape: BoxShape.circle),
                          ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
