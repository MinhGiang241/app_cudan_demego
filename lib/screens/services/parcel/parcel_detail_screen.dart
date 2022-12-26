import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../constants/api_constant.dart';
import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/info_content_view.dart';
import '../../../models/parcel.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_info_widget.dart';
import '../../../widgets/primary_screen.dart';

class ParcelDetailsScreen extends StatelessWidget {
  const ParcelDetailsScreen({super.key});
  static const routeName = '/parcel/details';

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Parcel;
    return PrimaryScreen(
        appBar: PrimaryAppbar(
          title: S.of(context).parcel_details,
        ),
        body: ListView(
          children: [
            vpad(24),
            PrimaryInfoWidget(
              label: S.of(context).parcel_info,
              listInfoView: [
                InfoContentView(
                  title: S.of(context).parcel_code,
                  content: arg.code,
                  contentStyle: txtBold(14, grayScaleColorBase),
                ),
                InfoContentView(
                  title: S.of(context).parcel_name,
                  content: arg.name,
                  contentStyle: txtBold(14, grayScaleColorBase),
                ),
                InfoContentView(
                  title: S.of(context).arrived_date,
                  content: Utils.dateFormat(arg.time_get ?? "", 1),
                  contentStyle: txtBold(14, grayScaleColorBase),
                ),
                if (arg.time_out != null)
                  InfoContentView(
                    title: S.of(context).receipt_date,
                    content: Utils.dateFormat(arg.time_out ?? "", 1),
                    contentStyle: txtBold(14, grayScaleColorBase),
                  ),
                if (arg.describe != null)
                  InfoContentView(
                    title: S.of(context).note,
                    content: arg.describe,
                    contentStyle: txtBold(14, grayScaleColorBase),
                  ),
                if (arg.image != null && arg.image!.isNotEmpty)
                  InfoContentView(title: S.of(context).photos, images: [
                    ...arg.image!.map(
                      (e) => "${ApiConstants.uploadURL}?load=${e.id}",
                    )
                  ]),
              ],
            ),
          ],
        ));
  }
}
