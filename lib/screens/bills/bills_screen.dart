// ignore_for_file: require_trailing_commas

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../../utils/utils.dart';
import '../../widgets/item_selected.dart';
import '../../widgets/primary_appbar.dart';
import '../../widgets/primary_bottom_sheet.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/primary_card.dart';
import '../../widgets/primary_checkbox.dart';
import '../../widgets/primary_icon.dart';
import '../../widgets/primary_screen.dart';
import 'details_bill_screen.dart';
import 'prv/bills_prv.dart';

class BillsScreen extends StatefulWidget {
  const BillsScreen({Key? key}) : super(key: key);
  static const routeName = '/bill-list';

  @override
  State<BillsScreen> createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BillsPrv>(
      create: (context) => BillsPrv(),
      builder: (context, state) {
        final listBill = context.watch<BillsPrv>().listBill;
        return PrimaryScreen(
          appBar: PrimaryAppbar(
            title: S.of(context).bills,
            tabController: tabController,
            isTabScrollabel: false,
            tabs: [
              Tab(text: " S.of(context).g"),
              Tab(text: 'S.of(context).paid'),
            ],
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Center(
                    child: PrimaryIcon(
                        icons: PrimaryIcons.filter,
                        onTap: () {
                          Utils.showBottomSheet(
                              context: context,
                              child: PrimaryBottomSheet(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ItemSelected(
                                          text: "Tất cả", onTap: () {}),
                                      const Divider(height: 1),
                                      ItemSelected(
                                          text: "Điện",
                                          isSelected: true,
                                          onTap: () {}),
                                      const Divider(height: 1),
                                      ItemSelected(text: "Nước", onTap: () {}),
                                      const Divider(height: 1),
                                      ItemSelected(
                                          text: "Internet", onTap: () {}),
                                      const Divider(height: 1),
                                      ItemSelected(
                                          text: "Bảo trì", onTap: () {}),
                                      const Divider(height: 1),
                                      vpad(MediaQuery.of(context)
                                              .padding
                                              .bottom +
                                          24)
                                    ],
                                  ),
                                ),
                              ));
                        })),
              )
            ],
          ),
          body: TabBarView(controller: tabController, children: [
            Stack(
              children: [
                ListView(
                  children: [
                    vpad(24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: PrimaryCheckBox(
                          value: context.watch<BillsPrv>().selectAll,
                          onChanged: (v) {
                            context.read<BillsPrv>().onSelectAll();
                          },
                          text: 'S.of(context).select_all'),
                    ),
                    vpad(24),
                    ...List.generate(
                        listBill.length,
                        (index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (!(index > 0 &&
                                      listBill[index].date ==
                                          listBill[index - 1].date))
                                    Text(_dateFomate(listBill[index].date!),
                                        style: txtLinkSmall(
                                            color: grayScaleColor2)),
                                  vpad(16),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 16.0),
                                    child: BillItem(
                                      isSelected: listBill[index].isSelected,
                                      onSelect: () {
                                        context
                                            .read<BillsPrv>()
                                            .onSelect(index);
                                      },
                                    ),
                                  )
                                ],
                              ),
                            )),
                    vpad(bottomSafePad(context) + 80),
                  ],
                ),
                Positioned(
                    bottom: 24,
                    left: 32,
                    right: 32,
                    child: SafeArea(
                        child: PrimaryButton(
                      text: 'S.of(context).payment',
                      onTap: () {
                        // Utils.pushScreen(context, const PaymentScreen());
                      },
                    )))
              ],
            ),
            ListView(
              children: [
                vpad(24),
                ...List.generate(
                    2,
                    (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_dateFomate(listBill[index].date!),
                                  style: txtLinkSmall(color: grayScaleColor2)),
                              vpad(16),
                              ...List.generate(
                                  2,
                                  (index) => const Padding(
                                        padding: EdgeInsets.only(bottom: 16.0),
                                        child: BillItem(isPaid: true),
                                      ))
                            ],
                          ),
                        )),
                vpad(bottomSafePad(context) + 80),
              ],
            ),
          ]),
        );
      },
    );
  }

  String _dateFomate(String dt) {
    DateTime date = DateTime.parse(dt);
    final format = DateFormat("MMMM, yyy").format(date);
    return format.capitalize();
  }
}

class BillItem extends StatelessWidget {
  const BillItem({
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
    return Row(
      children: [
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
                            border: Border.all(width: 3, color: primaryColor3),
                            shape: BoxShape.circle),
                      ),
              ),
            ),
          ),
        if (!isPaid) hpad(24),
        Expanded(
          child: PrimaryCard(
              onTap: () {
                Utils.pushScreen(context, DetailsBillScreen(isPaid: isPaid));
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
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
                          Text("Hoá đơn tiền điện", style: txtLinkSmall()),
                          vpad(2),
                          Text("1.578.000 VND", style: txtLinkSmall()),
                          vpad(2),
                          Text("2/2/2022", style: txtBodyXSmallRegular()),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ],
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
