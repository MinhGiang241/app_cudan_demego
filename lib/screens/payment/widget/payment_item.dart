import 'package:app_cudan/screens/payment/prv/payment_list_prv.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/receipt.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_card.dart';
import '../../../widgets/primary_icon.dart';
import '../bill_details_screen.dart';

genIcon(String? type) {
  switch (type) {
    case "WaterFee":
      return const PrimaryIcon(
        icons: PrimaryIcons.water,
        style: PrimaryIconStyle.gradient,
        gradients: PrimaryIconGradient.green,
        size: 32,
        padding: EdgeInsets.all(12),
        color: Colors.white,
      );
    case "ElectricFee":
      return const PrimaryIcon(
        icons: PrimaryIcons.electricity,
        style: PrimaryIconStyle.gradient,
        gradients: PrimaryIconGradient.yellow,
        size: 32,
        padding: EdgeInsets.all(12),
        color: Colors.white,
      );
    case "ParkingFee":
      return const PrimaryIcon(
        icons: PrimaryIcons.car,
        style: PrimaryIconStyle.gradient,
        gradients: PrimaryIconGradient.purple,
        size: 32,
        padding: EdgeInsets.all(12),
        color: Colors.white,
      );
    case "ApartmentFee":
      return const PrimaryIcon(
        icons: PrimaryIcons.home,
        style: PrimaryIconStyle.gradient,
        gradients: PrimaryIconGradient.red,
        size: 32,
        padding: EdgeInsets.all(12),
        color: Colors.white,
      );
    case "ServiceRegistration":
      return const PrimaryIcon(
        icons: PrimaryIcons.service_feedback,
        style: PrimaryIconStyle.gradient,
        gradients: PrimaryIconGradient.pink,
        size: 32,
        padding: EdgeInsets.all(12),
        color: Colors.white,
      );
    case "Other":
      return const PrimaryIcon(
        icons: PrimaryIcons.calendar_check,
        style: PrimaryIconStyle.gradient,
        gradients: PrimaryIconGradient.primary,
        size: 32,
        padding: EdgeInsets.all(12),
        color: Colors.white,
      );
    default:
      return const PrimaryIcon(
        icons: PrimaryIcons.electricity,
        style: PrimaryIconStyle.gradient,
        gradients: PrimaryIconGradient.yellow,
        size: 32,
        padding: EdgeInsets.all(12),
        color: Colors.white,
      );
  }
}

genName(String? type) {
  switch (type) {
    case "WaterFee":
      return S.current.water_bill;
    case "ElectricFee":
      return S.current.elcetric_bill;
    case "ParkingFee":
      return S.current.parking_bill;
    case "ApartmentFee":
      return S.current.apartment_bill;
    case "ServiceRegistration":
      return S.current.service_bill;
    case "Other":
      return S.current.other_bill;
    default:
      return S.current.bills;
  }
}

final formatCurrency = NumberFormat.simpleCurrency(locale: "vi");

class PaymentItem extends StatelessWidget {
  PaymentItem({
    Key? key,
    this.isPaid = false,
    this.isSelected = false,
    this.onSelect,
    required this.re,
  }) : super(key: key);
  final bool isPaid;
  final bool isSelected;
  final Function()? onSelect;
  Receipt re;

  @override
  Widget build(BuildContext context) {
    return PrimaryCard(
      margin: const EdgeInsets.only(bottom: 16, left: 12, right: 12),
      onTap: () {
        Navigator.pushNamed(context, BillDetailsScreen.routeName, arguments: {
          "re": re,
          "year": context.read<PaymentListPrv>().year,
          "month": context.read<PaymentListPrv>().month
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        child: Row(
          children: [
            genIcon(re.type),
            hpad(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(re.reason ?? "", style: txtLinkSmall()),
                  vpad(2),
                  Table(
                    textBaseline: TextBaseline.ideographic,
                    defaultVerticalAlignment:
                        TableCellVerticalAlignment.baseline,
                    columnWidths: const {
                      0: FlexColumnWidth(2),
                      1: FlexColumnWidth(3)
                    },
                    children: [
                      TableRow(children: [
                        Text('${S.of(context).total_money}:'),
                        Text(formatCurrency.format(re.amount_due ?? 0),
                            style: txtLinkSmall()),
                      ]),
                      TableRow(children: [
                        Text('${S.of(context).due_bill}:'),
                        Text(
                          Utils.dateFormat(re.date ?? '', 1),
                        ),
                      ]),
                    ],
                  )
                  // Text(formatCurrency.format(re.amount_due ?? 0),
                  //     // .replaceAll("₫", ""),
                  //     style: txtLinkSmall()),
                  // vpad(2),
                  // Text(
                  //     '${S.of(context).due_bill}: ${Utils.dateFormat(re.date ?? '', 1)}',
                  //     style: txtBodyXSmallRegular()),
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
                    child: re.isSelected
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
