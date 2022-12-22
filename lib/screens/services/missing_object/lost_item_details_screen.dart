import 'package:app_cudan/models/missing_object.dart';
import 'package:app_cudan/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../constants/api_constant.dart';
import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/info_content_view.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_info_widget.dart';
import '../../../widgets/primary_screen.dart';

class LostItemDetailsScreen extends StatelessWidget {
  const LostItemDetailsScreen({super.key});
  static const routeName = '/missing-object/details';

  @override
  Widget build(BuildContext context) {
    final arg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    MissingObject lostItem = MissingObject();

    if (arg['lost'] != null) {
      lostItem = arg['lost'];
    }
    return PrimaryScreen(
      appBar: PrimaryAppbar(
        title: S.of(context).object_details,
      ),
      body: ListView(children: [
        vpad(24),
        PrimaryInfoWidget(
          label: S.of(context).object_info,
          listInfoView: [
            InfoContentView(
              title: S.of(context).object_code,
              content: lostItem.code,
              contentStyle: txtBold(14, grayScaleColorBase),
            ),
            InfoContentView(
              title: S.of(context).object_name,
              content: lostItem.name,
              contentStyle: txtBold(14, grayScaleColorBase),
            ),
            InfoContentView(
              title: S.of(context).missing_time,
              content: Utils.dateFormat(lostItem.time ?? "", 1),
              contentStyle: txtBold(14, grayScaleColorBase),
            ),
            if (lostItem.find_time != null)
              InfoContentView(
                title: S.of(context).found_time,
                content: Utils.dateFormat(lostItem.find_time ?? "", 1),
                contentStyle: txtBold(14, grayScaleColorBase),
              ),
            if (lostItem.find_place != null)
              InfoContentView(
                title: S.of(context).found_place,
                content: lostItem.find_place,
                contentStyle: txtBold(14, grayScaleColorBase),
              ),
            if (lostItem.describe != null)
              InfoContentView(
                title: S.of(context).note,
                content: lostItem.describe,
                contentStyle: txtBold(14, grayScaleColorBase),
              ),
            if (lostItem.image != null && lostItem.image!.isNotEmpty)
              InfoContentView(title: S.of(context).photos, images: [
                ...lostItem.image!
                    .map((e) => "${ApiConstants.uploadURL}?load=${e.file_id}"),
              ]),
          ],
        ),
        vpad(30),
        PrimaryButton(
          text: arg['status'] == "FOUND"
              ? S.of(context).returned
              : S.of(context).found,
          onTap: () {},
        ),
        vpad(50),
      ]),
    );
  }
}
