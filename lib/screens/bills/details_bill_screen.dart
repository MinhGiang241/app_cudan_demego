import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../../models/info_content_view.dart';
import '../../widgets/primary_appbar.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/primary_info_widget.dart';
import '../../widgets/primary_screen.dart';

class DetailsBillScreen extends StatelessWidget {
  const DetailsBillScreen({Key? key, required this.isPaid}) : super(key: key);
  final bool isPaid;
  @override
  Widget build(BuildContext context) {
    return PrimaryScreen(
      appBar: PrimaryAppbar(
        title: S.of(context).bills,
        isTabScrollabel: true,
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: PrimaryInfoWidget(listInfoView: [
                  InfoContentView(
                      title: "Tên hoá đơn", content: "Hoá đơn tiền điện"),
                  InfoContentView(title: "Mã hoá đơn", content: "AXBYCZ"),
                  InfoContentView(
                      title: "Nội dung", content: "Tiền điện tháng 2/2022"),
                  InfoContentView(title: "VAT", content: "0 VND"),
                  InfoContentView(
                      title: "Thành tiền", content: "1.587.000 VND"),
                  InfoContentView(
                      title: "Tình trạng hoá đơn",
                      content: isPaid ? "Đã thanh toán" : "Chưa thanh toán"),
                ]),
              )
            ],
          ),
          if (!isPaid)
            Positioned(
                bottom: 24,
                left: 32,
                right: 32,
                child: SafeArea(
                    child: PrimaryButton(
                  text: ' S.of(context).payment',
                  onTap: () {
                    // Utils.pushScreen(context, const PaymentScreen());
                  },
                )))
        ],
      ),
    );
  }
}
