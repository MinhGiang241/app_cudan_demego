import 'package:app_cudan/models/missing_object.dart';
import 'package:app_cudan/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../constants/api_constant.dart';
import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/info_content_view.dart';
import '../../../services/api_service.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_info_widget.dart';
import '../../../widgets/primary_screen.dart';
import 'missing_object_screen.dart';

class LootItemDetailsScreen extends StatefulWidget {
  const LootItemDetailsScreen({
    super.key,
  });
  static const routeName = '/missing-object/details-loot';

  @override
  State<LootItemDetailsScreen> createState() => _LootItemDetailsScreenState();
}

class _LootItemDetailsScreenState extends State<LootItemDetailsScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final arg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    LootItem lootItem = LootItem();
    Function(BuildContext, LootItem)? changeStatus;
    if (arg['lost'] != null) {
      lootItem = arg['lost'];
    }
    if (arg['change'] != null) {
      changeStatus = arg['change'];
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
              content: lootItem.code,
              contentStyle: txtBold(14, grayScaleColorBase),
            ),
            InfoContentView(
              title: S.of(context).object_name,
              content: lootItem.name,
              contentStyle: txtBold(14, grayScaleColorBase),
            ),
            InfoContentView(
              title: S.of(context).found_time,
              content: Utils.dateFormat(lootItem.date ?? "", 1),
              contentStyle: txtBold(14, grayScaleColorBase),
            ),
            // if (lootItem.find_time != null)
            //   InfoContentView(
            //     title: S.of(context).found_time,
            //     content: Utils.dateFormat(lostItem.find_time ?? "", 1),
            //     contentStyle: txtBold(14, grayScaleColorBase),
            //   ),
            if (lootItem.address != null)
              InfoContentView(
                title: S.of(context).found_place,
                content: lootItem.address,
                contentStyle: txtBold(14, grayScaleColorBase),
              ),
            if (lootItem.describe != null)
              InfoContentView(
                title: S.of(context).note,
                content: lootItem.describe,
                contentStyle: txtBold(14, grayScaleColorBase),
              ),
            if (lootItem.photo != null && lootItem.photo!.isNotEmpty)
              InfoContentView(title: S.of(context).photos, images: [
                ...lootItem.photo!.map((e) =>
                    "${ApiService.shared.uploadURL}?load=${e.id}&regcode=${ApiService.shared.regCode}"),
              ]),
            InfoContentView(
                title: S.of(context).status,
                content: lootItem.s!.name,
                contentStyle:
                    txtBold(14, genStatusColor(lootItem.status ?? ''))),
            if (lootItem.return_image != null &&
                lootItem.return_image!.isNotEmpty)
              InfoContentView(title: S.of(context).return_image, images: [
                ...lootItem.return_image!.map((e) =>
                    "${ApiService.shared.uploadURL}?load=${e.id}&regcode=${ApiService.shared.regCode}"),
              ])
          ],
        ),
        // vpad(30),
        // if (arg['status'] == "WAIT_RETURN")
        //   PrimaryButton(
        //     isLoading: isLoading,
        //     text: S.of(context).returned,
        //     onTap: () async {
        //       if (changeStatus != null) {
        //         setState(() {
        //           isLoading = true;
        //         });

        //         await changeStatus(context, lootItem);
        //         setState(() {
        //           isLoading = false;
        //         });
        //       }
        //     },
        //   ),
        vpad(50),
      ]),
    );
  }
}
