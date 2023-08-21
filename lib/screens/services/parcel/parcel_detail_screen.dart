import 'package:app_cudan/services/api_parcel.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/info_content_view.dart';
import '../../../models/parcel.dart';
import '../../../services/api_service.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_info_widget.dart';
import '../../../widgets/primary_screen.dart';
import 'parcel_list_screen.dart';

class ParcelDetailsScreen extends StatefulWidget {
  const ParcelDetailsScreen({super.key});
  static const routeName = '/parcel/details';

  @override
  State<ParcelDetailsScreen> createState() => _ParcelDetailsScreenState();
}

class _ParcelDetailsScreenState extends State<ParcelDetailsScreen> {
  var isLoading = false;
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
                content: Utils.dateTimeFormat(arg.time_get ?? "", 1),
                contentStyle: txtBold(14, grayScaleColorBase),
              ),
              if (arg.time_out != null)
                InfoContentView(
                  title: S.of(context).receipt_date,
                  content: Utils.dateTimeFormat(arg.time_out ?? "", 1),
                  contentStyle: txtBold(14, grayScaleColorBase),
                ),
              if (arg.describe != null)
                InfoContentView(
                  title: S.of(context).note,
                  content: arg.describe,
                  contentStyle: txtBold(14, grayScaleColorBase),
                ),
              if (arg.image != null && arg.image!.isNotEmpty)
                InfoContentView(
                  title: S.of(context).photos,
                  images: [
                    ...arg.image!.map(
                      (e) =>
                          "${ApiService.shared.uploadURL}?load=${e.id}&regcode=${ApiService.shared.regCode}",
                    )
                  ],
                ),
            ],
          ),
          vpad(20),
          if (arg.status == "YES")
            PrimaryButton(
              text: S.of(context).confirm,
              isLoading: isLoading,
              onTap: () async {
                setState(() {
                  isLoading = true;
                });
                var data = arg.toJson();
                data["status"] = "ACCEPT";
                APIParcel.acceptParcel(data).then((v) {
                  setState(() {
                    isLoading = false;
                  });
                  Utils.showSuccessMessage(
                    context: context,
                    e: S.of(context).success_accept,
                    onClose: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        ParcelListScreen.routeName,
                        (route) => route.isFirst,
                        arguments: {'initTab': 1},
                      );
                    },
                  );
                }).catchError((e) {
                  setState(() {
                    isLoading = false;
                  });
                  Utils.showErrorMessage(context, e);
                });
              },
            ),
          vpad(40),
        ],
      ),
    );
  }
}
