import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/response_parcel_list.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_card.dart';
import '../../../widgets/primary_icon.dart';
import '../../../widgets/primary_screen.dart';
import 'parcel_details_screen.dart';

class ParcelsListMonthScreen extends StatefulWidget {
  const ParcelsListMonthScreen(
      {Key? key, required this.title, required this.list})
      : super(key: key);
  final String title;
  final List<ParcelItems> list;

  @override
  State<ParcelsListMonthScreen> createState() => _ParcelsListMonthScreenState();
}

class _ParcelsListMonthScreenState extends State<ParcelsListMonthScreen> {
  @override
  Widget build(BuildContext context) {
    return PrimaryScreen(
      appBar: PrimaryAppbar(title: widget.title),
      body: ListView(
        children: [
          vpad(24),
          ...List.generate(
              widget.list.length,
              (index) => Padding(
                    padding:
                        const EdgeInsets.only(left: 24, right: 24, bottom: 16),
                    child: PrimaryCard(
                        onTap: () {
                          Utils.pushScreen(
                              context,
                              ParcelDetailsScreen(
                                item: widget.list[index],
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const PrimaryIcon(
                                icons: PrimaryIcons.package,
                                style: PrimaryIconStyle.gradient,
                                size: 32,
                                padding: EdgeInsets.all(12),
                                gradients: PrimaryIconGradient.primary,
                                color: Colors.white,
                              ),
                              hpad(16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      widget.list[index].buuPham?.tenBuuPham
                                              ?.text ??
                                          'S.of(context).no_name',
                                      style: txtLinkSmall()),
                                  vpad(4),
                                  Text(
                                      "${'S.of(context).sender'}: ${widget.list[index].buuPham?.nguoiGui?.text}",
                                      style: txtBodySmallBold()),
                                  vpad(4),
                                  Text(
                                      "${S.of(context).phone_num}: ${widget.list[index].buuPham?.soDienThoaiNguoiGui?.text}",
                                      style: txtBodySmallBold()),
                                ],
                              )
                            ],
                          ),
                        )),
                  ))
        ],
      ),
    );
  }
}
