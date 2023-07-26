import 'package:app_cudan/models/info_content_view.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/screens/services/ultilty/prv/add_new_letter_ultility_prv.dart';
import 'package:app_cudan/widgets/primary_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/constants.dart';
import '../../../../widgets/primary_button.dart';

class ServiceInformationPage extends StatelessWidget {
  const ServiceInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    var userInfo = context.read<ResidentInfoPrv>().userInfo;
    var apartment = context.read<ResidentInfoPrv>().selectedApartment;
    return ListView(
      children: [
        vpad(20),
        PrimaryInfoWidget(
          label: 'Thông tin đăng ký',
          listInfoView: [
            InfoContentView(
              title: 'Loại tiện ích',
              content: 'Nướng BBQ',
              isHorizontal: true,
            ),
            InfoContentView(
              title: 'Địa điểm',
              content:
                  context.watch<AddNewLetterUltilityPrv>().locationValue ?? '',
              isHorizontal: true,
            ),
            InfoContentView(
              title: 'Số lượng về cư dân',
              content:
                  context.watch<AddNewLetterUltilityPrv>().resNum.toString(),
              isHorizontal: true,
            ),
            InfoContentView(
              title: 'Thời gian đặt lịch',
              content:
                  '${context.read<AddNewLetterUltilityPrv>().dateController.text.trim()} ${context.watch<AddNewLetterUltilityPrv>().currentTimeValue}',
              isHorizontal: true,
            ),
            InfoContentView(
              title: 'Loại tiện ích',
              content: 'Nướng BBQ',
              isHorizontal: true,
            ),
          ],
        ),
        vpad(20),
        PrimaryInfoWidget(
          label: 'Thông tin đăng ký',
          listInfoView: [
            InfoContentView(
              title: "Người đăng ký",
              content: userInfo?.info_name ??
                  userInfo?.account?.fullName ??
                  userInfo?.account?.userName ??
                  '',
              isHorizontal: true,
            ),
            InfoContentView(
              title: "Mã căn hộ/ biệt thự",
              content: apartment == null
                  ? ''
                  : "${apartment.apartment?.name} - ${apartment.floor?.name} - ${apartment.building?.name}",
              isHorizontal: true,
            ),
            InfoContentView(
              title: "Số điện thoại",
              content: '',
              isHorizontal: true,
            ),
          ],
        ),
        vpad(20),
        PrimaryButton(
          text: "Xác nhận",
          onTap: () {
            Navigator.pop(context);
          },
        ),
        vpad(20),
      ],
    );
  }
}
