import 'package:app_cudan/constants/constants.dart';
import 'package:app_cudan/widgets/primary_card.dart';
import 'package:app_cudan/widgets/primary_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../generated/l10n.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/item_selected.dart';
import '../../../../widgets/primary_bottom_sheet.dart';
import '../../../../widgets/primary_dialog.dart';
import '../../../reg_resident/add_existed_resident.dart';
import '../../../reg_resident/add_new_resident_screen.dart';
import '../../../services/resident_card/register_resident_card.dart';
import '../../../services/transport_card/transport_card_screen.dart.dart';

class CardListTab extends StatefulWidget {
  const CardListTab({super.key});

  @override
  State<CardListTab> createState() => _CardListTabState();
}

class _CardListTabState extends State<CardListTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          vpad(12),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).registered_card,
                      style: txtBold(14, grayScaleColorBase),
                      textAlign: TextAlign.start,
                    ),
                    vpad(6),
                    Text(
                      S.of(context).confirmed_card,
                      style: txtRegular(12, grayScaleColorBase),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              hpad(5),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(
                          color: primaryColorBase,
                          width: 2,
                        ),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () {
                    Utils.showBottomSheet(
                      context: context,
                      child: PrimaryBottomSheet(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 40,
                              child: Center(
                                child: Text(
                                  S.of(context).select_card_type,
                                  overflow: TextOverflow.ellipsis,
                                  style: txtLinkSmall(color: grayScaleColor1),
                                ),
                              ),
                            ),
                            const Divider(
                              height: 1,
                            ),
                            ItemSelected(
                              text: S.of(context).res_card,
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.pushNamed(
                                  context,
                                  RegisterResidentCard.routeName,
                                );
                              },
                            ),
                            const Divider(
                              height: 1,
                            ),
                            ItemSelected(
                              text: S.of(context).trans_card,
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.pushNamed(
                                  context,
                                  TransportCardScreen.routeName,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Text(
                    S.of(context).add,
                    style: txtMedium(14, primaryColorBase),
                  ),
                ),
              )
            ],
          ),
          vpad(12),
          Expanded(
            child: ListView(
              children: [
                vpad(20),
                PrimaryCard(
                  borderRadius: BorderRadius.circular(24),
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        decoration: const BoxDecoration(
                          color: blueColor3,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              spreadRadius: 0,
                              blurRadius: 10,
                            )
                          ],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Expanded(
                              flex: 1,
                              child: PrimaryIcon(
                                icons: PrimaryIcons.identity_bg,
                                color: Colors.white,
                                size: 80,
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  vpad(5),
                                  Text(
                                    "Thẻ cư dân",
                                    style: txtBold(14, Colors.white),
                                  ),
                                  vpad(10),
                                  Text(
                                    "TH-001 -  Demego",
                                    style: txtRegular(14, Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        // height: 120,
                        decoration: const BoxDecoration(
                          color: grayScaleColor6,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              spreadRadius: 0,
                              blurRadius: 10,
                            )
                          ],
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(24),
                            bottomRight: Radius.circular(24),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  vpad(12),
                                  Text(
                                    "Nguyễn Thị Dung",
                                    style: txtBold(14, primaryColorBase),
                                  ),
                                  vpad(10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Mã mặt bằng:",
                                          style: txtBold(14, grayScaleColor3),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "TH001 - Demego",
                                          style: txtRegular(
                                            14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  vpad(10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Ngày đăng ký:",
                                          style: txtBold(14, grayScaleColor3),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "02/03/2023",
                                          style: txtRegular(
                                            14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  vpad(10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Ngày hết hạn:",
                                          style: txtBold(14, grayScaleColor3),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "02/03/2023",
                                          style: txtRegular(
                                            14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  vpad(10),
                                ],
                              ),
                              Positioned(
                                bottom: 10,
                                right: 8,
                                width: 60,
                                child: Image.asset(AppImage.qltnLogo),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                vpad(20),
                PrimaryCard(
                  borderRadius: BorderRadius.circular(24),
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        decoration: const BoxDecoration(
                          color: greenColor10,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              spreadRadius: 0,
                              blurRadius: 10,
                            )
                          ],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Expanded(
                              flex: 1,
                              child: PrimaryIcon(
                                icons: PrimaryIcons.car,
                                color: Colors.white,
                                size: 80,
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  vpad(5),
                                  Text(
                                    "Thẻ Phương tiện",
                                    style: txtBold(14, Colors.white),
                                  ),
                                  vpad(10),
                                  Text(
                                    "TH-001 -  Demego",
                                    style: txtRegular(14, Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        // height: 120,
                        decoration: const BoxDecoration(
                          color: grayScaleColor6,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              spreadRadius: 0,
                              blurRadius: 10,
                            )
                          ],
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(24),
                            bottomRight: Radius.circular(24),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  vpad(12),
                                  Text(
                                    "Nguyễn Thị Dung",
                                    style: txtBold(14, primaryColorBase),
                                  ),
                                  vpad(10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Mã mặt bằng:",
                                          style: txtBold(14, grayScaleColor3),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "TH001 - Demego",
                                          style: txtRegular(
                                            14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  vpad(10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Ngày đăng ký:",
                                          style: txtBold(14, grayScaleColor3),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "02/03/2023",
                                          style: txtRegular(
                                            14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  vpad(10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Ngày hết hạn:",
                                          style: txtBold(14, grayScaleColor3),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "02/03/2023",
                                          style: txtRegular(
                                            14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  vpad(10),
                                ],
                              ),
                              Positioned(
                                bottom: 10,
                                right: 8,
                                width: 60,
                                child: Image.asset(AppImage.qltnLogo),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                vpad(50)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
