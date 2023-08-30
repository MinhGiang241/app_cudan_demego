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

// ignore: must_be_immutable
class PaymentItem extends StatelessWidget {
  PaymentItem({
    Key? key,
    this.isPaid = false,
    this.isSelected = false,
    this.onSelect,
    this.onTap,
    this.widget,
    this.navigate,
    this.canSelect = true,
    required this.re,
  }) : super(key: key);
  final bool isPaid;
  final bool isSelected;
  final Function()? onSelect;
  final Function()? onTap;
  final Function? navigate;
  final Widget? widget;
  final bool? canSelect;
  Receipt re;

  @override
  Widget build(BuildContext context) {
    // var own = re.transactions.fold(
    //     0.0,
    //     (previousValue, element) =>
    //         previousValue + (element.payment_amount ?? 0));
    // var money =
    //     (re.amount_due ?? 0) * (re.vat ?? 0) / 100 + (re.amount_due ?? 0) - own;
    String? payDate;
    var paid =
        re.transactions.fold(0.0, (a, b) => a += (b.payment_amount ?? 0));

    if (re.transactions.isNotEmpty) {
      payDate = re.transactions.map((e) => e.createdTime).reduce((a, e) {
        if (a!.compareTo(e!) > 0) {
          return a;
        } else {
          return e;
        }
      });
    }

    return PrimaryCard(
      margin: const EdgeInsets.only(bottom: 16, left: 12, right: 12),
      onTap: onTap ??
          () {
            Navigator.pushNamed(
              context,
              BillDetailsScreen.routeName,
              arguments: {
                "re": re,
                "year": context.read<PaymentListPrv>().year,
                "month": context.read<PaymentListPrv>().month,
                "navigate": navigate,
              },
            );
          },
      child: Column(
        children: [
          if (widget != null) widget!,
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            child: Row(
              children: [
                genIcon(re.type),
                hpad(12),
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
                          0: FlexColumnWidth(3),
                          1: FlexColumnWidth(3),
                        },
                        children: [
                          TableRow(
                            children: [
                              Text(
                                '${!isPaid ? S.of(context).need_pay : S.of(context).pay}:',
                                style: txtRegular(13, grayScaleColorBase),
                              ),
                              isPaid
                                  ? Text(
                                      formatCurrency.format(paid),
                                      style: txtLinkSmall(),
                                    )
                                  : Text(
                                      formatCurrency.format(re.amount! - paid),
                                      style: txtLinkSmall(),
                                    ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Text(
                                '${!isPaid ? S.of(context).due_bill : S.of(context).pay_date}:',
                                style: txtRegular(13, grayScaleColorBase),
                              ),
                              Text(
                                Utils.dateFormat(
                                  (!isPaid ? re.date : payDate) ?? '',
                                  1,
                                ),
                                style: txtRegular(14, grayScaleColorBase),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (!isPaid && canSelect!)
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
                                size: 26,
                                color: primaryColor3,
                              )
                            : Container(
                                width: 22,
                                height: 26,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 3,
                                    color: primaryColor3,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
