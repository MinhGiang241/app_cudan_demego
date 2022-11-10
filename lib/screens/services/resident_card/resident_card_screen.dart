import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/info_content_view.dart';
import '../../../models/response_thecudan_list.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_card.dart';
import '../../../widgets/primary_empty_widget.dart';
import '../../../widgets/primary_error_widget.dart';
import '../../../widgets/primary_icon.dart';
import '../../../widgets/primary_loading.dart';
import '../../../widgets/primary_screen.dart';
import '../../account/r_card/r_card_info.dart';
import '../../account/r_card/register_r_card.dart';
import 'prv/resident_card_prv.dart';

var listCardExample = [
  TheCuDanItems(
    aliasPart: AliasPart(alias: 'alias'),
    author: 'author',
    contentItemId: 'contentItemId',
    contentItemVersionId: 'contentItemVersionId',
    contentType: 'contentType',
    createdUtc: '2022-11-02T03:59:28.071+0000',
    daGuiEmail: true,
    displayText: 'displayText',
    latest: true,
    listPart: ListPart(),
    modifiedUtc: '2022-11-02T03:59:28.071+0000',
    owner: 'owner',
    privateTheCuDanPart: PrivateTheCuDanPart(
        createFrom: CreateFrom(
          text: 'CreateFrom',
        ),
        maTaiSanKho: MaTaiSanKho(),
        soDichVu: SoDichVu(value: 1),
        tinhTrang: TinhTrang(text: 'TinhTrang')),
    published: true,
    publishedUtc: 'publishedUtc',
    theCuDan: TheCuDan(
      canHo: CanHo(contentItemIds: ['contentItemIds']),
      chuThe: ChuThe(contentItemIds: ['contentItemIds']),
      id: Id(value: 's'),
      soDienThoai: SoDienThoai(
        text: '0123456789',
      ),
      soThe: SoThe(text: "123"),
      tang: Tang(
          contentItemIds: ['contentItemIds'], displayTexts: ['displayTexts']),
      toaNha: ToaNha(
          contentItemIds: ['contentItemIds'], displayTexts: ['displayTexts']),
    ),
  ),
  TheCuDanItems(
    aliasPart: AliasPart(alias: 'alias'),
    author: 'author',
    contentItemId: 'contentItemId',
    contentItemVersionId: 'contentItemVersionId',
    contentType: 'contentType',
    createdUtc: '2022-11-02T03:59:28.071+0000',
    daGuiEmail: true,
    displayText: 'displayText',
    latest: true,
    listPart: ListPart(),
    modifiedUtc: '2022-11-02T03:59:28.071+0000',
    owner: 'owner',
    privateTheCuDanPart: PrivateTheCuDanPart(
        createFrom: CreateFrom(
          text: 'CreateFrom',
        ),
        maTaiSanKho: MaTaiSanKho(),
        soDichVu: SoDichVu(value: 1),
        tinhTrang: TinhTrang(text: 'TinhTrang')),
    published: true,
    publishedUtc: 'publishedUtc',
    theCuDan: TheCuDan(
      canHo: CanHo(contentItemIds: ['contentItemIds']),
      chuThe: ChuThe(contentItemIds: ['contentItemIds']),
      id: Id(value: 's'),
      soDienThoai: SoDienThoai(
        text: '0123456789',
      ),
      soThe: SoThe(text: "123"),
      tang: Tang(
          contentItemIds: ['contentItemIds'], displayTexts: ['displayTexts']),
      toaNha: ToaNha(
          contentItemIds: ['contentItemIds'], displayTexts: ['displayTexts']),
    ),
  )
];

var thecudanListExample = ResponseTheCuDanList(
  count: 2,
  items: listCardExample,
  // status: null,
);

class ResidentCardListScreen extends StatefulWidget {
  const ResidentCardListScreen({Key? key}) : super(key: key);
  static const routeName = '/residence-card';

  @override
  State<ResidentCardListScreen> createState() => _ResidentCardListScreenState();
}

class _ResidentCardListScreenState extends State<ResidentCardListScreen> {
  @override
  Widget build(BuildContext context) {
    return PrimaryScreen(
      appBar: PrimaryAppbar(title: ' S.of(context).resident_card'),
      body: ChangeNotifierProvider<ResidentCardPrv>(
          create: (context) => ResidentCardPrv(),
          builder: (context, child) {
            final thecudanList = thecudanListExample;
            // context.watch<ResidentCardPrv>().responseTheCuDanList;
            if (thecudanList == null) {
              return const Center(child: PrimaryLoading());
            } else if (thecudanList.status != null) {
              return PrimaryErrorWidget(
                code: thecudanList.status,
                message: thecudanList.message,
                onRetry: () {
                  context.read<ResidentCardPrv>().retry();
                },
              );
            } else if (thecudanList.items!.isEmpty) {
              return PrimaryEmptyWidget(
                emptyText: 'S.of(context).no_resident_card',
                buttonText: 'S.of(context).register_r_card',
                icons: PrimaryIcons.inbox,
                action: () {
                  Utils.pushScreen(context, const RegisterRecidentCard());
                },
              );
            }
            final listCard = thecudanList.items ?? [];
            return Stack(
              children: [
                SafeArea(
                  top: false,
                  child: ListView(
                    children: [
                      vpad(24),
                      ...List.generate(listCard.length, (index) {
                        List<InfoContentView> listContent = [
                          InfoContentView(
                              title: 'S.current.signal',
                              content:
                                  listCard[index].theCuDan?.soThe?.text ?? "",
                              contentStyle: txtBold(16, primaryColor1)),
                          InfoContentView(
                              title: S.current.full_name,
                              content: (listCard[index]
                                          .theCuDan
                                          ?.chuThe
                                          ?.displayTexts?[0] ??
                                      "")
                                  .toUpperCase(),
                              contentStyle: txtBold(14)),
                          InfoContentView(
                              title: 'S.current.plan_name',
                              content: listCard[index]
                                      .theCuDan
                                      ?.canHo
                                      ?.displayTexts?[0] ??
                                  "",
                              contentStyle: txtSemiBold(12)),
                          InfoContentView(
                              title: 'S.current.card_num',
                              content:
                                  listCard[index].theCuDan?.soThe?.text ?? "",
                              contentStyle: txtSemiBold(12)),
                        ];

                        final trangThai = listCard[index]
                            .privateTheCuDanPart
                            ?.tinhTrang
                            ?.text;

                        if (trangThai == null) {
                          return vpad(0);
                        }
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, bottom: 16),
                          child: PrimaryCard(
                              onTap: () {
                                Utils.pushScreen(
                                    context,
                                    RecidentCardInfo(
                                      items: listCard[index],
                                    ));
                              },
                              child: Column(
                                children: [
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(
                                            color: trangThai!.toLowerCase() ==
                                                    "hoatdong"
                                                ? greenColorBase
                                                : trangThai!.toLowerCase() ==
                                                        "chothe"
                                                    ? yellowColor1
                                                    : redColor3,
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(12),
                                                    bottomLeft:
                                                        Radius.circular(8))),
                                        child: Text(
                                          trangThai.toLowerCase() == "hoatdong"
                                              ? 'S.of(context).active'
                                              : trangThai.toLowerCase() ==
                                                      "chothe"
                                                  ? 'S.of(context).wating_card'
                                                  : 'S.of(context).inactive',
                                          style: txtSemiBold(12, Colors.white),
                                        ),
                                      )),
                                  vpad(16),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Table(
                                      columnWidths: const {
                                        0: FlexColumnWidth(2),
                                        1: FlexColumnWidth(3)
                                      },
                                      children: listContent
                                          .map<TableRow>((e) =>
                                              TableRow(children: [
                                                Text(e.title,
                                                    style: txtMedium(
                                                        12, grayScaleColor2)),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
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
                        );
                      }),
                      vpad(bottomSafePad(context) + 80),
                    ],
                  ),
                ),
                Positioned(
                    bottom: 24,
                    left: 34,
                    right: 34,
                    child: SafeArea(
                        child: PrimaryButton(
                      text: 'S.of(context).register_r_card',
                      onTap: () {
                        Utils.pushScreen(context, const RegisterRecidentCard());
                      },
                    )))
              ],
            );
          }),
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
