import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/info_content_view.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_info_widget.dart';
import '../../../widgets/primary_screen.dart';
import '../../auth/prv/auth_prv.dart';
import 'edit_personal_info.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({Key? key}) : super(key: key);
  static const routeName = '/info';

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final userInfo = context.watch<ResidentInfoPrv>().userInfo!.account;
    List<InfoContentView> listInfoView = [
      InfoContentView(
          title: S.current.full_name,
          content: userInfo?.fullName ?? "",
          contentStyle: userInfo?.fullName != null
              ? const TextStyle(
                  fontFamily: family, fontSize: 14, fontWeight: FontWeight.w600)
              : TextStyle(
                  fontFamily: family,
                  color: Colors.black.withOpacity(0.3),
                  fontSize: 14,
                  fontWeight: FontWeight.w600)),
      InfoContentView(
          title: S.current.username,
          content: userInfo?.userName ?? "",
          contentStyle: userInfo?.userName != null
              ? const TextStyle(
                  fontFamily: family, fontSize: 14, fontWeight: FontWeight.w600)
              : TextStyle(
                  fontFamily: family,
                  color: Colors.black.withOpacity(0.3),
                  fontSize: 14,
                  fontWeight: FontWeight.w600)),
      InfoContentView(
          title: S.current.phone_num,
          content: userInfo?.phone_number ?? "",
          contentStyle: userInfo?.phone_number != null
              ? const TextStyle(
                  fontFamily: family, fontSize: 14, fontWeight: FontWeight.w600)
              : TextStyle(
                  fontFamily: family,
                  color: Colors.black.withOpacity(0.3),
                  fontSize: 14,
                  fontWeight: FontWeight.w600)),
      InfoContentView(
          title: S.current.email,
          content: userInfo?.email ?? "",
          contentStyle: userInfo?.email != null
              ? const TextStyle(
                  fontFamily: family, fontSize: 14, fontWeight: FontWeight.w600)
              : TextStyle(
                  fontFamily: family,
                  color: Colors.black.withOpacity(0.3),
                  fontSize: 14,
                  fontWeight: FontWeight.w600)),

      // InfoContentView(
      //     title: " S.current.gender",
      //     content: _genderString(context, userInfo?.sex),
      //     contentStyle: userInfo?.sex != null
      //         ? const TextStyle(
      //             fontFamily: family, fontSize: 14, fontWeight: FontWeight.w600)
      //         : TextStyle(
      //             fontFamily: family,
      //             color: Colors.black.withOpacity(0.3),
      //             fontSize: 14,
      //             fontWeight: FontWeight.w600)),
      // InfoContentView(
      //     title: "S.current.country",
      //     content: userInfo?.national ?? "S.of(context).not_update",
      //     contentStyle: userInfo?.national != null
      //         ? const TextStyle(
      //             fontFamily: family, fontSize: 14, fontWeight: FontWeight.w600)
      //         : TextStyle(
      //             fontFamily: family,
      //             color: Colors.black.withOpacity(0.3),
      //             fontSize: 14,
      //             fontWeight: FontWeight.w600),

      //             ),
    ];
    return PrimaryScreen(
      appBar: PrimaryAppbar(title: S.of(context).personal_info),
      body: Stack(
        children: [
          ListView(
            children: [
              Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: PrimaryInfoWidget(
                    listInfoView: listInfoView,
                    label: S.of(context).info,
                  )),
              vpad(100)
            ],
          ),
          Positioned(
              bottom: 24,
              left: 12,
              right: 12,
              child: SafeArea(
                  child: PrimaryButton(
                text: S.of(context).edit,
                onTap: () {
                  Utils.pushScreen(context, const EditPersonalInfo());
                },
              )))
        ],
      ),
    );
  }

  String _genderString(BuildContext context, String? gen) {
    if (gen == "Male") {
      return S.of(context).male;
    }
    if (gen == "Female") {
      return S.of(context).female;
    }
    if (gen == "Other") {
      return S.of(context).other_gender;
    }
    return "S.of(context).not_update";
  }
}
