import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/info_content_view.dart';
import '../../../models/response_parcel_list.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_info_widget.dart';
import '../../../widgets/primary_screen.dart';

class ParcelDetailsScreen extends StatefulWidget {
  const ParcelDetailsScreen({Key? key, required this.item}) : super(key: key);
  final ParcelItems item;

  @override
  State<ParcelDetailsScreen> createState() => _ParcelDetailsScreenState();
}

class _ParcelDetailsScreenState extends State<ParcelDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return PrimaryScreen(
      appBar: PrimaryAppbar(title: 'S.of(context).parcel_details'),
      body: ListView(
        children: [
          vpad(24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: PrimaryInfoWidget(
                lable: 'S.of(context).parcel_info',
                listInfoView: [
                  InfoContentView(
                      title: 'S.of(context).parcel_name',
                      content: widget.item.buuPham?.tenBuuPham?.text),
                  InfoContentView(
                      title: 'S.of(context).sender',
                      content: widget.item.buuPham?.nguoiGui?.text),
                  InfoContentView(
                      title: S.of(context).phone_num,
                      content: widget.item.buuPham?.soDienThoaiNguoiGui?.text),
                  InfoContentView(
                      title: 'S.of(context).sending_time',
                      content: Utils.dateFormat(
                          widget.item.buuPham?.thoiGianGui?.value ?? "")),
                  InfoContentView(
                      title: 'S.of(context).note',
                      content: widget.item.buuPham?.ghiChu?.text),
                  InfoContentView(
                      title: 'S.of(context).photos',
                      images: widget.item.buuPham?.hinhAnh?.paths
                          ?.map<String>((e) => e ?? "")
                          .toList()),
                ]),
          ),
          vpad(24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: PrimaryInfoWidget(
                lable: 'S.of(context).receiver',
                listInfoView: [
                  InfoContentView(
                      title: 'S.of(context).receiver_name',
                      content:
                          widget.item.buuPham?.nguoiNhan?.displayTexts?[0]),
                  InfoContentView(
                      title: S.of(context).phone_num,
                      content: widget.item.buuPham?.soDienThoai?.text),
                  if (widget.item.privateBuuPham?.trangThai?.text ==
                      "DaHoanThanh")
                    InfoContentView(
                        title: 'S.of(context).receiving_time',
                        content:
                            Utils.dateFormat(widget.item.modifiedUtc ?? "")),
                ]),
          )
        ],
      ),
    );
  }
}
