import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/info_content_view.dart';
import '../../../models/response_parking_card_model.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_info_widget.dart';
import '../../../widgets/primary_screen.dart';
import '../../../widgets/timeline_view.dart';

class ParkingCardDetailsScreen extends StatefulWidget {
  const ParkingCardDetailsScreen({Key? key, required this.item})
      : super(key: key);
  final ParkingCards item;

  @override
  State<ParkingCardDetailsScreen> createState() =>
      _ParkingCardDetailsScreenState();
}

class _ParkingCardDetailsScreenState extends State<ParkingCardDetailsScreen>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);
  @override
  Widget build(BuildContext context) {
    return PrimaryScreen(
      appBar: PrimaryAppbar(
        title: S.of(context).parking_card,
        tabController: tabController,
        isTabScrollabel: false,
        tabs: [
          Tab(text: ' S.of(context).details'),
          Tab(text: 'S.of(context).timeline'),
        ],
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          ListView(
            children: [
              vpad(24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: PrimaryInfoWidget(
                    lable: 'S.of(context).parking_card_info',
                    listInfoView: [
                      InfoContentView(
                          title: 'S.of(context).card_num',
                          content: widget.item.khachHangTheXe!.contentItems![0]
                              .khachHangTheXe!.soThe!.text
                              ?.toUpperCase(),
                          contentStyle: txtBold(16, primaryColor1)),
                      InfoContentView(
                          title: S.of(context).full_name,
                          content: widget.item.khachHangTheXe!.contentItems![0]
                              .khachHangTheXe!.khachHang!.displayTexts![0]
                              .toUpperCase(),
                          contentStyle: txtBold(14)),
                      InfoContentView(
                          title:
                              // ignore: unnecessary_string_interpolations
                              "${S.of(context).phone_num}",
                          content: widget.item.khachHangTheXe!.contentItems![0]
                                  .khachHangTheXe?.soDienThoai?.text ??
                              ""),
                      InfoContentView(
                          title: 'S.of(context).expire_date',
                          content: Utils.dateFormat(
                              widget.item.theXe!.ngayHetHan!.value ?? "")),
                      InfoContentView(
                          title: S.of(context).status,
                          content: widget
                                      .item.privateTheXePart?.trangThai?.text!
                                      .toLowerCase() ==
                                  "hoatdong"
                              ? 'S.of(context).active'
                              : 'S.of(context).inactive',
                          contentStyle: txtSemiBold(
                              14,
                              widget.item.privateTheXePart?.trangThai?.text!
                                          .toLowerCase() ==
                                      "hoatdong"
                                  ? greenColorBase
                                  : redColor2)),
                    ]),
              ),
              vpad(16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: PrimaryInfoWidget(
                    lable: 'S.of(context).vehicle_info',
                    listInfoView: [
                      InfoContentView(
                          title: 'S.of(context).vehicle_photo',
                          images: widget.item.theXe?.hinhAnh?.paths),
                      InfoContentView(
                        title: 'S.of(context).vehicle_type',
                        content:
                            widget.item.theXe?.loaiPhuongTien?.displayTexts![0],
                      ),
                      InfoContentView(
                        title: 'S.of(context).vehicle_com',
                        content: widget.item.theXe?.dongXe?.text ?? "",
                      ),
                      if (widget.item.theXe?.bienKiemSoat?.text != null)
                        InfoContentView(
                            title: 'S.of(context).license_plates',
                            content: widget.item.theXe?.bienKiemSoat?.text),
                      InfoContentView(
                          title: 'S.of(context).vehicle_color',
                          content: widget.item.theXe?.mauXe?.text),
                      if (widget.item.theXe?.soDangKy?.value != null)
                        InfoContentView(
                            title: 'S.of(context).registration_num',
                            content: double.parse(widget
                                    .item.theXe!.soDangKy!.value
                                    .toString())
                                .floor()
                                .toString()),
                      InfoContentView(
                          title: 'S.of(context).owner_vehicle',
                          isCheckType: true,
                          isCheck: widget.item.privateTheXePart!.owner != null),
                      InfoContentView(
                          title: 'S.of(context).note',
                          content: widget.item.theXe?.ghiChu?.text),
                    ]),
              ),
              vpad(24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (widget.item.privateTheXePart?.trangThai?.text!
                          .toLowerCase() !=
                      "hoatdong")
                    PrimaryButton(
                      text: 'S.of(context).extend',
                      buttonType: ButtonType.secondary,
                      secondaryBackgroundColor: yellowColor5,
                      textColor: const Color(0xffFF7A00),
                      onTap: () {},
                    ),
                  if (widget.item.privateTheXePart?.trangThai?.text!
                          .toLowerCase() ==
                      "hoatdong")
                    PrimaryButton(
                      text: 'S.of(context).report_lost',
                      buttonType: ButtonType.secondary,
                      textColor: primaryColorBase,
                      secondaryBackgroundColor: primaryColor5,
                      onTap: () {},
                    ),
                  if (widget.item.privateTheXePart?.trangThai?.text!
                          .toLowerCase() ==
                      "hoatdong")
                    PrimaryButton(
                      text: 'S.of(context).deactive_card',
                      buttonType: ButtonType.secondary,
                      textColor: redColorBase,
                      secondaryBackgroundColor: redColor5,
                      onTap: () {},
                    )
                ],
              ),
              vpad(kBottomNavigationBarHeight),
            ],
          ),
          ListView(
            children: [
              vpad(24),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: TimeLineView(),
              )
            ],
          )
        ],
      ),
    );
  }
}
