import 'package:app_cudan/models/missing_object.dart';
import 'package:app_cudan/widgets/primary_button.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/info_content_view.dart';
import '../../../services/api_service.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_info_widget.dart';
import '../../../widgets/primary_screen.dart';

class LostItemDetailsScreen extends StatefulWidget {
  const LostItemDetailsScreen({
    super.key,
  });
  static const routeName = '/missing-object/details';

  @override
  State<LostItemDetailsScreen> createState() => _LostItemDetailsScreenState();
}

class _LostItemDetailsScreenState extends State<LostItemDetailsScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final arg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    MissingObject lostItem = MissingObject();
    Function(BuildContext, MissingObject)? changeStatus;
    if (arg['change'] != null) {
      changeStatus = arg['change'];
    }
    if (arg['lost'] != null) {
      lostItem = arg['lost'];
    }

    var time;
    if (lostItem.lost_time != null) {
      time = TimeOfDay(
        hour: int.parse(lostItem.lost_time!.split(':')[0]),
        minute: int.parse(lostItem.lost_time!.split(':')[1]),
      );
    }

    return PrimaryScreen(
      appBar: PrimaryAppbar(
        title: S.of(context).object_details,
      ),
      body: ListView(
        children: [
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
                content:
                    '${lostItem.lost_time != null ? '${time.hour.toString().padLeft(2, "0")}:${time.minute.toString().padLeft(2, "0")} ' : ""}${Utils.dateFormat(lostItem.time ?? "", 1)}',
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
                InfoContentView(
                  title: S.of(context).photos,
                  images: [
                    ...lostItem.image!.map(
                      (e) =>
                          "${ApiService.shared.uploadURL}?load=${e.id}&regcode=${ApiService.shared.regCode}",
                    ),
                  ],
                ),
            ],
          ),
          vpad(30),
          if (arg['status'] != "ACCEPT")
            PrimaryButton(
              isLoading: isLoading,
              text: arg['status'] == 'NOTFOUND'
                  ? S.of(context).i_found
                  : S.of(context).confirm,
              onTap: () async {
                if (changeStatus != null) {
                  setState(() {
                    isLoading = true;
                  });

                  await changeStatus(context, lostItem);

                  setState(() {
                    isLoading = false;
                  });
                }
              },
            ),
          vpad(50),
        ],
      ),
    );
  }
}
