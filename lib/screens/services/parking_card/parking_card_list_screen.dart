import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/info_content_view.dart';
import '../../../models/response_apartment.dart';
import '../../../models/response_parking_card_model.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_card.dart';
import '../../../widgets/primary_empty_widget.dart';
import '../../../widgets/primary_error_widget.dart';
import '../../../widgets/primary_icon.dart';
import '../../../widgets/primary_loading.dart';
import '../../../widgets/primary_screen.dart';
import '../../auth/prv/auth_prv.dart';
import 'parking_card_details_screem.dart';
import 'providers/parking_card_provider.dart';
import 'register_parking_card.dart';

var parkingCardListExamples = ResponseParkingCardsList(count: 3, items: [
  ParkingCard(
      aliasPart: AliasPart1(alias: '1'),
      author: "Giang",
      contentItemId: 'id1',
      contentItemVersionId: 'ct1',
      contentType: 'contentType',
      createdUtc: '2022-11-02T03:59:28.071+0000',
      displayText: 'displayText',
      khachHangTheXe: KhachHangTheXe(
        contentItems: [
          ContentItems(
            aliasPart: AliasPart(alias: 'alias'),
            author: 'Giang',
            contentItemId: 'ct1',
            contentItemVersionId: 'contentItemVersionId',
            contentType: 'contentType',
            createdUtc: '2022-11-02T03:59:28.071+0000',
            displayText: 'displayText',
            khachHangTheXe: KhachHangTheXe1(
                canHo: CanHo(
                  contentItemIds: ['contentItemIds'],
                  displayTexts: ['displayTexts'],
                ),
                khachHang: KhachHang(
                  contentItemIds: ['contentItemIds'],
                  displayTexts: ['displayTexts'],
                ),
                soDienThoai: SoDienThoai(text: '0123456789'),
                soThe: SoThe(text: '001'),
                tang: Tang(
                  contentItemIds: ['contentItemIds1'],
                  displayTexts: ['displayTexts'],
                ),
                toaNha: ToaNha(
                  contentItemIds: ['contentItemIds1'],
                  displayTexts: ['displayTexts'],
                ),
                trangThai: 'trangThai'),
          ),
        ],
        trangthai: Trangthai(
          text: 'trangThai',
        ),
      ),
      latest: true,
      listPart: ListPart(),
      modifiedUtc: '2022-11-02T03:59:28.071+0000',
      owner: 'owner',
      privateTheXePart: PrivateTheXePart(
        createFrom: CreateFrom(text: '2022-11-02T03:59:28.071+0000'),
        errorDetail: ErrorDetail(text: 'ErrorDetail'),
        isDuplicateBienSoXe: 'isDuplicateBienSoXe',
        khachHangId: KhachHangId(text: 'KhachHangId'),
        loai: Loai(text: 'Loai'),
        maTaiSanKho: MaTaiSanKho(text: 'MaTaiSanKho'),
        owner: Owner(text: 'Owner'),
        trangThai: TrangThai(text: 'TrangThai'),
      ),
      published: true,
      publishedUtc: '2022-11-02T03:59:28.071+0000',
      theXe: TheXe(
        bienKiemSoat: BienKiemSoat(text: 'BienKiemSoat'),
        dongXe: DongXe(text: 'DongXe'),
        ghiChu: GhiChu(text: 'Ghichu'),
        giaHanLanThuNhat: GiaHanLanThuNhat(value: true),
        hinhAnh: HinhAnh(
            mediaTexts: ['sss'], paths: ['https://unsplash.it/120/256']),
        id: Id(value: '123'),
        loaiPhuongTien: LoaiPhuongTien(
            contentItemIds: ['contentItemIds'], displayTexts: ['displayTexts']),
        mauXe: MauXe(text: 'MauXe'),
        ngayHetHan: NgayHetHan(value: '2022-11-02T03:59:28.071+0000'),
        soDangKy: SoDangKy(value: '1234'),
      ),
      titlePart: TitlePart(title: 'TitlePart')),
  ParkingCard(
      aliasPart: AliasPart1(alias: '1'),
      author: "Giang",
      contentItemId: 'id1',
      contentItemVersionId: 'ct1',
      contentType: 'contentType',
      createdUtc: '2022-11-02T03:59:28.071+0000',
      displayText: 'displayText',
      khachHangTheXe: KhachHangTheXe(
        contentItems: [
          ContentItems(
            aliasPart: AliasPart(alias: 'alias'),
            author: 'Giang',
            contentItemId: 'ct1',
            contentItemVersionId: 'contentItemVersionId',
            contentType: 'contentType',
            createdUtc: '2022-11-02T03:59:28.071+0000',
            displayText: 'displayText',
            khachHangTheXe: KhachHangTheXe1(
                canHo: CanHo(
                  contentItemIds: ['contentItemIds'],
                  displayTexts: ['displayTexts'],
                ),
                khachHang: KhachHang(
                  contentItemIds: ['contentItemIds'],
                  displayTexts: ['displayTexts'],
                ),
                soDienThoai: SoDienThoai(text: '0123456789'),
                soThe: SoThe(text: '001'),
                tang: Tang(
                  contentItemIds: ['contentItemIds1'],
                  displayTexts: ['displayTexts'],
                ),
                toaNha: ToaNha(
                  contentItemIds: ['contentItemIds1'],
                  displayTexts: ['displayTexts'],
                ),
                trangThai: 'trangThai'),
          ),
        ],
        trangthai: Trangthai(
          text: 'trangThai',
        ),
      ),
      latest: true,
      listPart: ListPart(),
      modifiedUtc: '2022-11-02T03:59:28.071+0000',
      owner: 'owner',
      privateTheXePart: PrivateTheXePart(
        createFrom: CreateFrom(text: '2022-11-02T03:59:28.071+0000'),
        errorDetail: ErrorDetail(text: 'ErrorDetail'),
        isDuplicateBienSoXe: 'isDuplicateBienSoXe',
        khachHangId: KhachHangId(text: 'KhachHangId'),
        loai: Loai(text: 'Loai'),
        maTaiSanKho: MaTaiSanKho(text: 'MaTaiSanKho'),
        owner: Owner(text: 'Owner'),
        trangThai: TrangThai(text: 'TrangThai'),
      ),
      published: true,
      publishedUtc: 'publishedUtc',
      theXe: TheXe(
        bienKiemSoat: BienKiemSoat(text: 'BienKiemSoat'),
        dongXe: DongXe(text: 'DongXe'),
        ghiChu: GhiChu(text: 'Ghichu'),
        giaHanLanThuNhat: GiaHanLanThuNhat(value: true),
        hinhAnh: HinhAnh(
            mediaTexts: ['sss'], paths: ['https://unsplash.it/120/256']),
        id: Id(value: '123'),
        loaiPhuongTien: LoaiPhuongTien(
            contentItemIds: ['contentItemIds'], displayTexts: ['displayTexts']),
        mauXe: MauXe(text: 'MauXe'),
        ngayHetHan: NgayHetHan(value: '2022-11-02T03:59:28.071+0000'),
        soDangKy: SoDangKy(value: '1234'),
      ),
      titlePart: TitlePart(title: 'TitlePart'))
]);

var apartmentExample =
    FloorPlan(detail: 'detail', floorPlan: '11', id: '1', name: 'name');

class ParkingCardListScreen extends StatefulWidget {
  const ParkingCardListScreen({Key? key}) : super(key: key);
  static const routeName = '/parking-card';

  @override
  State<ParkingCardListScreen> createState() => _ParkingCardListScreenState();
}

class _ParkingCardListScreenState extends State<ParkingCardListScreen> {
  @override
  Widget build(BuildContext context) {
    // final apartment = context.watch<AuthPrv>().selectedApartment;
    final apartment = apartmentExample;
    return ChangeNotifierProvider(
      create: (context) => ParkingCardProvider(apartment!.apartmentId ?? ""),
      builder: (context, state) {
        // final parkingCards =
        //     context.watch<ParkingCardProvider>().parkingCardsList;

        final parkingCards = parkingCardListExamples;

        return PrimaryScreen(
          appBar: PrimaryAppbar(title: S.of(context).parking_card),
          body: Builder(builder: (context) {
            if (parkingCards == null) {
              return const Center(child: PrimaryLoading());
            } else if (parkingCards.status != null) {
              return PrimaryErrorWidget(
                code: parkingCards.status,
                message: parkingCards.message,
                onRetry: () {
                  context.read<ParkingCardProvider>().retry();
                },
              );
            } else if (parkingCards.items!.isEmpty) {
              return PrimaryEmptyWidget(
                emptyText: 'S.of(context).no_parking_card',
                buttonText: ' S.of(context).register_parking_card',
                icons: PrimaryIcons.car,
                action: () {
                  Utils.pushScreen(context, const RegisterParkingCard());
                },
              );
            }
            return Stack(
              children: [
                SafeArea(
                  child: ListView(
                    children: [
                      vpad(24),
                      ...List.generate(parkingCards.items!.length, (index) {
                        List<InfoContentView> listContent = [
                          InfoContentView(
                              title: 'S.of(context).card_num',
                              content: (parkingCards
                                          .items?[index]
                                          .khachHangTheXe
                                          ?.contentItems?[0]
                                          .khachHangTheXe
                                          ?.soThe
                                          ?.text ??
                                      "")
                                  .toUpperCase(),
                              contentStyle: txtBold(16, primaryColor1)),
                          InfoContentView(
                              title: S.of(context).full_name,
                              content: parkingCards
                                  .items![index]
                                  .khachHangTheXe!
                                  .contentItems![0]
                                  .khachHangTheXe!
                                  .khachHang!
                                  .displayTexts![0]
                                  .toUpperCase(),
                              contentStyle: txtBold(14)),
                          InfoContentView(
                              title: 'S.of(context).vehicle_type',
                              content: parkingCards.items![index].theXe!
                                  .loaiPhuongTien!.displayTexts![0],
                              contentStyle: txtSemiBold(12)),
                          InfoContentView(
                              title: 'S.of(context).license_plates',
                              content: parkingCards
                                  .items![index].theXe!.bienKiemSoat!.text,
                              contentStyle: txtSemiBold(12)),
                        ];
                        final trangThai = parkingCards
                            .items![index].privateTheXePart!.trangThai;

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
                                    ParkingCardDetailsScreen(
                                        item: parkingCards.items![index]));
                              },
                              child: Column(
                                children: [
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(
                                            color:
                                                trangThai.text!.toLowerCase() ==
                                                        "hoatdong"
                                                    ? greenColorBase
                                                    : redColor3,
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(12),
                                                    bottomLeft:
                                                        Radius.circular(8))),
                                        child: Text(
                                          trangThai.text!.toLowerCase() ==
                                                  "hoatdong"
                                              ? 'S.of(context).active'
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
                                  // vpad(16),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        if (trangThai.text!.toLowerCase() !=
                                            "hoatdong")
                                          PrimaryButton(
                                            text: 'S.of(context).extend',
                                            buttonSize: ButtonSize.xsmall,
                                            buttonType: ButtonType.secondary,
                                            secondaryBackgroundColor:
                                                yellowColor5,
                                            textColor: const Color(0xffFF7A00),
                                            onTap: () {},
                                          ),
                                        if (trangThai.text!.toLowerCase() ==
                                            "hoatdong")
                                          hpad(16),
                                        if (trangThai.text!.toLowerCase() ==
                                            "hoatdong")
                                          PrimaryButton(
                                            text: 'S.of(context).report_lost',
                                            buttonSize: ButtonSize.xsmall,
                                            buttonType: ButtonType.secondary,
                                            secondaryBackgroundColor:
                                                primaryColor5,
                                            textColor: primaryColorBase,
                                            onTap: () {
                                              context
                                                  .read<ParkingCardProvider>()
                                                  .reportLostCard(context);
                                            },
                                          ),
                                        if (trangThai.text!.toLowerCase() ==
                                            "hoatdong")
                                          hpad(16),
                                        if (trangThai.text!.toLowerCase() ==
                                            "hoatdong")
                                          PrimaryButton(
                                            text: 'S.of(context).deactive_card',
                                            buttonSize: ButtonSize.xsmall,
                                            buttonType: ButtonType.secondary,
                                            secondaryBackgroundColor: redColor5,
                                            textColor: redColorBase,
                                            onTap: () {
                                              context
                                                  .read<ParkingCardProvider>()
                                                  .deactiveCard(context);
                                            },
                                          )
                                      ],
                                    ),
                                  ),
                                  vpad(16),
                                ],
                              )),
                        );
                      }),
                      vpad(bottomSafePad(context) + 50),
                    ],
                  ),
                ),
                vpad(16),
                Positioned(
                  bottom: (bottomSafePad(context) + 24),
                  left: 24,
                  right: 24,
                  child: PrimaryButton(
                    text: 'S.of(context).register_parking_card',
                    onTap: () {
                      Utils.pushScreen(context, const RegisterParkingCard());
                    },
                  ),
                ),
              ],
            );
          }),
        );
      },
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
