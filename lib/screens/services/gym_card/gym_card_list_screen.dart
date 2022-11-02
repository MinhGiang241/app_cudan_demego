import 'package:app_cudan/widgets/primary_dropdown.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/info_content_view.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_card.dart';
import '../../../widgets/primary_screen.dart';
import 'add_gym_card_screen.dart';

class GymCardListScreen extends StatelessWidget {
  const GymCardListScreen({Key? key}) : super(key: key);
  static const routeName = '/services/gym';

  @override
  Widget build(BuildContext context) {
    List<InfoContentView> listContent = [
      InfoContentView(
          title: 'S.current.card_num',
          content: "TX000000001",
          contentStyle: txtBold(16, primaryColor1)),
      InfoContentView(
          title: S.current.full_name,
          content: "NGUYỄN VĂN A",
          contentStyle: txtBold(14)),
      InfoContentView(
          title: S.current.phone_num,
          content: "0xxx xxx xxx",
          contentStyle: txtSemiBold(12)),
      InfoContentView(
          title: 'S.current.register_day',
          content: "22/02/2022",
          contentStyle: txtSemiBold(12)),
      InfoContentView(
          title: 'S.current.expire_day',
          content: "22/08/2022",
          contentStyle: txtSemiBold(12)),
    ];
    return PrimaryScreen(
      isPadding: false,
      appBar: PrimaryAppbar(title: S.of(context).gym_card),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddGymCardScreen.routeName);
        },
        backgroundColor: primaryColorBase,
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          children: [
            vpad(24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: PrimaryDropDown(
                label: S.of(context).his_reg_service,
              ),
            ),
            vpad(12),
            ...List.generate(
                2,
                (index) => Padding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, bottom: 16),
                      child: PrimaryCard(
                          onTap: () {},
                          child: Column(
                            children: [
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    decoration: const BoxDecoration(
                                        color: greenColorBase,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(12),
                                            bottomLeft: Radius.circular(8))),
                                    child: Text(
                                      'S.current.active',
                                      style: txtSemiBold(12, Colors.white),
                                    ),
                                  )),
                              vpad(16),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Table(
                                  columnWidths: const {
                                    0: FlexColumnWidth(2),
                                    1: FlexColumnWidth(3)
                                  },
                                  children: listContent
                                      .map<TableRow>((e) => TableRow(children: [
                                            Text(e.title,
                                                style: txtMedium(
                                                    12, grayScaleColor2)),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 16),
                                              child: Text(e.content ?? "",
                                                  style: e.contentStyle),
                                            )
                                          ]))
                                      .toList(),
                                ),
                              ),
                            ],
                          )),
                    )),
            vpad(bottomSafePad(context) + 80),
          ],
        ),
      ),
    );
  }
}

class PrimaryRadio extends StatelessWidget {
  const PrimaryRadio({
    Key? key,
    required this.isSelected,
    required this.title,
    this.onTap,
  }) : super(key: key);
  final bool isSelected;
  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        width: isSelected ? 5 : 2,
                        color: isSelected ? primaryColorBase : primaryColor4))),
            hpad(16),
            Text(
              title,
              style: txtLinkXSmall(),
            )
          ],
        ),
      ),
    );
  }
}
