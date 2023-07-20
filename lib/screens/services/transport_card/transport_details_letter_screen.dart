import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/info_content_view.dart';
import '../../../models/transportation_card.dart';
import '../../../services/api_service.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_info_widget.dart';
import '../../../widgets/primary_screen.dart';

class TransportDetailsLetterScreen extends StatefulWidget {
  const TransportDetailsLetterScreen({super.key});
  static const routeName = '/transport/details-transport-letter';

  @override
  State<TransportDetailsLetterScreen> createState() =>
      _TransportDetailsLetterScreenState();
}

class _TransportDetailsLetterScreenState
    extends State<TransportDetailsLetterScreen> {
  @override
  Widget build(BuildContext context) {
    final arg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    var item = arg['item'] as TransportItem;
    return PrimaryScreen(
      appBar: PrimaryAppbar(
        title: S.of(context).trans_details,
      ),
      body: ListView(
        children: [
          vpad(24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: PrimaryInfoWidget(
              label: S.of(context).trans_info,
              listInfoView: [
                InfoContentView(
                  isHorizontal: true,
                  title: S.of(context).transport,
                  content: item.vehicleType?.name ?? "",
                ),
                if (item.seats != null)
                  InfoContentView(
                    isHorizontal: true,
                    title: S.of(context).num_seat,
                    content: item.seats.toString(),
                  ),
                if (item.vehicleType?.code != 'BICYCLE')
                  InfoContentView(
                    isHorizontal: true,
                    title: S.of(context).licene_plate,
                    content: item.number_plate,
                  ),
                if (item.vehicleType?.code != 'BICYCLE')
                  InfoContentView(
                    isHorizontal: true,
                    title: S.of(context).reg_num,
                    content: item.registration_number,
                  ),
                InfoContentView(
                  isHorizontal: true,
                  title: S.of(context).used_expired_date,
                  content:
                      '${item.shelfLife?.use_time} ${item.shelfLife?.type_time}',
                ),
                if (item.registration_image != null &&
                    item.registration_image!.isNotEmpty)
                  InfoContentView(
                    // isHorizontal: true,
                    images: (item.registration_image ?? [])
                        .map<String>(
                          (e) =>
                              "${ApiService.shared.uploadURL}?load=${e.id}&regcode=${ApiService.shared.regCode}",
                        )
                        .toList(),
                    title: S.of(context).reg_trans_photos,
                  ),
                if (item.vehicle_image != null &&
                    item.vehicle_image!.isNotEmpty)
                  InfoContentView(
                    // isHorizontal: true,
                    images: (item.vehicle_image ?? [])
                        .map<String>(
                          (e) =>
                              "${ApiService.shared.uploadURL}?load=${e.id}&regcode=${ApiService.shared.regCode}",
                        )
                        .toList(),
                    title: S.of(context).trans_images,
                  ),
                if (item.identity_image != null &&
                    item.identity_image!.isNotEmpty)
                  InfoContentView(
                    // isHorizontal: true,
                    images: (item.identity_image ?? [])
                        .map<String>(
                          (e) =>
                              "${ApiService.shared.uploadURL}?load=${e.id}&regcode=${ApiService.shared.regCode}",
                        )
                        .toList(),
                    title: S.of(context).cmnd_images,
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
