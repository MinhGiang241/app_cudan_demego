import 'package:app_cudan/screens/services/parcel/parels_list_month_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/response_parcel_list.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_card.dart';
import '../../../widgets/primary_empty_widget.dart';
import '../../../widgets/primary_error_widget.dart';
import '../../../widgets/primary_icon.dart';
import '../../../widgets/primary_loading.dart';
import '../../../widgets/primary_screen.dart';
import '../../account/plan_info/widgets/recident_info_tab.dart';
import 'parcel_details_screen.dart';
import 'prv/parcel_prv.dart';

class ParcelListScreen extends StatefulWidget {
  const ParcelListScreen({Key? key}) : super(key: key);
  static const routeName = '/parcel';

  @override
  State<ParcelListScreen> createState() => _ParcelListScreenState();
}

class _ParcelListScreenState extends State<ParcelListScreen>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);
  @override
  Widget build(BuildContext context) {
    var itemExample = ParcelItems(
        author: 'author',
        buuPham: BuuPham(
          canHo: CanHo(
              contentItemIds: ['contentItemIds'],
              displayTexts: ['displayTexts']),
          chotTruc: ChotTruc(text: 'ChotTruc'),
          ghiChu: GhiChu(text: 'GhiChu'),
          hinhAnh: HinhAnh(
            mediaTexts: ['mediaTexts'],
            paths: [
              'https://unsplash.it/120/256',
              'https://unsplash.it/120/256',
            ],
          ),
          id: Id(value: 1),
          matBang: 'matBang',
          nguoiGui: NguoiGui(text: 'NguoiGui'),
          nguoiNhan: NguoiNhan(
              contentItemIds: ['contentItemIds'],
              displayTexts: ['displayTexts']),
          soDienThoai: SoDienThoai(text: '0123456789'),
          tenBuuPham: TenBuuPham(text: 'TenBuuPham'),
          soDienThoaiNguoiGui: SoDienThoaiNguoiGui(text: 'SoDienThoaiNguoiGui'),
          tang: Tang(
              contentItemIds: ['contentItemIds'],
              displayTexts: ['displayTexts']),
          thoiGianGui: ThoiGianGui(value: '2022-11-02T03:59:28.071+0000'),
          toa: 1,
          toaNha: ToaNha(
              contentItemIds: ['contentItemIds'],
              displayTexts: ['displayTexts']),
        ),
        contentItemId: 'contentItemId',
        contentItemVersionId: 'contentItemVersionId',
        contentType: 'contentType',
        createdUtc: '2022-11-02T03:59:28.071+0000',
        displayText: 'displayText',
        giaoBuuPham: GiaoBuuPham(
          contentItems: ['contentItems'],
          trangthai: Trangthai(text: 'Trangthai'),
        ),
        latest: true,
        modifiedUtc: '2022-11-02T03:59:28.071+0000',
        owner: 'owner',
        privateBuuPham: PrivateBuuPham(trangThai: TrangThai(text: 'TrangThai')),
        published: true,
        publishedUtc: '2022-11-02T03:59:28.071+0000',
        titlePart: TitlePart(title: 'TitlePart'));
    var listParcelExample =
        ResponseParcelList(count: 2, items: [itemExample, itemExample]);

    return PrimaryScreen(
      appBar: PrimaryAppbar(
        title: 'S.of(context).parcel',
        tabController: tabController,
        isTabScrollabel: false,
        tabs: [
          Tab(text: 'S.of(context).waiting'),
          Tab(text: 'S.of(context).received'),
        ],
      ),
      body: ChangeNotifierProvider<ParcelPrv>(
          create: (context) => ParcelPrv(),
          builder: (context, snapshot) {
            final listParcel =
                listParcelExample; //context.watch<ParcelPrv>().parcelList;
            if (listParcel == null) {
              return const Center(child: PrimaryLoading());
            } else if (listParcel.status != null) {
              return PrimaryErrorWidget(
                code: listParcel.status,
                message: listParcel.message,
                onRetry: () {
                  context.read<ParcelPrv>().retry();
                },
              );
            }
            final waitingList = [
              itemExample
            ]; //context.watch<ParcelPrv>().waitingList;

            var groupYear = context.watch<ParcelPrv>().groupYear;
            //  {
            //   '2011': [
            //     {'item': [itemExample]}
            //   ]
            // };

            return TabBarView(controller: tabController, children: [
              if (waitingList.isEmpty)
                PrimaryEmptyWidget(
                  emptyText: 'S.of(context).no_waiting_parcel',
                  icons: PrimaryIcons.package,
                )
              else
                ListView(
                  children: [
                    vpad(24),
                    ...List.generate(
                        waitingList.length,
                        (index) => Padding(
                              padding: const EdgeInsets.only(
                                  left: 24, right: 24, bottom: 16),
                              child: PrimaryCard(
                                  onTap: () {
                                    Utils.pushScreen(
                                        context,
                                        ParcelDetailsScreen(
                                          item: waitingList[index],
                                        ));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const PrimaryIcon(
                                          icons: PrimaryIcons.package,
                                          style: PrimaryIconStyle.gradient,
                                          size: 32,
                                          padding: EdgeInsets.all(12),
                                          gradients:
                                              PrimaryIconGradient.primary,
                                          color: Colors.white,
                                        ),
                                        hpad(16),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                waitingList[index]
                                                        .buuPham
                                                        ?.tenBuuPham
                                                        ?.text ??
                                                    ' S.of(context).no_name',
                                                style: txtLinkSmall()),
                                            vpad(4),
                                            Text(
                                                "${'S.of(context).sender'}: ${waitingList[index].buuPham?.nguoiGui?.text}",
                                                style: txtBodySmallBold()),
                                            vpad(4),
                                            Text(
                                                "${S.of(context).phone_num}: ${waitingList[index].buuPham?.soDienThoaiNguoiGui?.text}",
                                                style: txtBodySmallBold()),
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                            ))
                  ],
                ),
              if (groupYear.isEmpty)
                PrimaryEmptyWidget(
                  emptyText: 'S.of(context).no_done_parcel',
                  icons: PrimaryIcons.package,
                )
              else
                ListView(
                  children: [
                    vpad(24),
                    ...List.generate(
                        groupYear.keys.length,
                        (index) => RecidentInfoItem(
                              isShowInit: index == 0,
                              header: Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                          groupYear.keys
                                              .toList()[index]
                                              .toString(),
                                          style:
                                              txtMedium(14, grayScaleColor2))),
                                  Text('S.of(context).num_of_parcel',
                                      style: txtMedium())
                                ],
                              ),
                              hide: Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                        "${listParcel.items!.length - waitingList.length}",
                                        style: txtMedium())
                                  ],
                                ),
                              ),
                              show: Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Column(
                                  children: List.generate(
                                      (groupYear[groupYear.keys
                                              .toList()[index]
                                              .toString()] as List)
                                          .length, (i) {
                                    final date = (groupYear[groupYear.keys
                                            .toList()[index]
                                            .toString()][i] as Map)
                                        .keys
                                        .toList()[0];
                                    final list = (groupYear[groupYear.keys
                                            .toList()[index]
                                            .toString()][i] as Map)[date]
                                        as List<ParcelItems>;
                                    return InkWell(
                                      onTap: () {
                                        Utils.pushScreen(
                                            context,
                                            ParcelsListMonthScreen(
                                              title: Utils.dateFormat(
                                                  date, "MMMM"),
                                              list: list,
                                            ));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                child: Text(
                                                    Utils.dateFormat(
                                                        date, "MMMM"),
                                                    style: txtMedium(
                                                        13, grayScaleColor2))),
                                            Text("${list.length}",
                                                style: txtMedium())
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ))
                  ],
                ),
            ]);
          }),
    );
  }
}

class YearParcel {
  final String title;
  final List<MonthParcel> monthList;

  YearParcel(this.title, this.monthList);
}

class MonthParcel {
  final String title;
  final List<ParcelItems> listParcel;

  MonthParcel(this.title, this.listParcel);
}
