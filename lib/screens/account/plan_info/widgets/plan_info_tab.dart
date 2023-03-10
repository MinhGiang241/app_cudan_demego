import 'package:app_cudan/models/response_resident_own.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/services/api_tower.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../../../../models/info_content_view.dart';
import '../../../../widgets/dash_button.dart';
import '../../../../widgets/primary_icon.dart';
import '../../../../widgets/primary_info_widget.dart';
import '../../../services/resident_card/register_resident_card.dart';

class PlanInfoTab extends StatefulWidget {
  const PlanInfoTab({
    Key? key,
  }) : super(key: key);

  @override
  State<PlanInfoTab> createState() => _PlanInfoTabState();
}

class _PlanInfoTabState extends State<PlanInfoTab> {
  Apartment? aprt;
  @override
  Widget build(BuildContext context) {
    var apartmentId =
        context.read<ResidentInfoPrv>().selectedApartment?.apartmentId;
    return FutureBuilder(future: () async {
      await APITower.getPlanInfo(apartmentId).then((value) {
        if (value != null) {
          aprt = Apartment.fromJson(value);
        }
      });
    }(), builder: (context, snapshot) {
      return ListView(
        children: [
          Padding(
              padding: const EdgeInsets.all(12.0),
              child: DashButton(
                text: S.of(context).register_res_card,
                icon: const PrimaryIcon(
                  icons: PrimaryIcons.home_alt,
                  style: PrimaryIconStyle.none,
                ),
                onTap: () {
                  Navigator.pushNamed(context, RegisterResidentCard.routeName);
                },
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: PrimaryInfoWidget(listInfoView: [
              InfoContentView(title: S.of(context).abrv, content: aprt?.code),
              InfoContentView(
                  title: S.of(context).plan_name,
                  content: aprt != null
                      ? "${aprt?.name}-${aprt?.f?.name ?? ""}-${aprt?.b?.name ?? ""}"
                      : ""),
              InfoContentView(
                  title: S.of(context).area,
                  content: aprt != null ? "${aprt?.area} m2" : ""),
              InfoContentView(
                  title: S.of(context).free_res_card, content: "1 thẻ"),
              InfoContentView(
                  title: S.of(context).issue_res_card, content: "2 thẻ"),
            ]),
          )
        ],
      );
    });
  }
}
