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
    final userInfo = context.watch<AuthPrv>().userInfo;
    List<InfoContentView> listInfoView = [
      InfoContentView(
          title: S.current.full_name,
          content: "userInfo?.userName" ?? "S.of(context).not_update",
          contentStyle: "userInfo?.userName" != null
              ? const TextStyle(
                  fontFamily: family, fontSize: 14, fontWeight: FontWeight.w600)
              : TextStyle(
                  fontFamily: family,
                  color: Colors.black.withOpacity(0.3),
                  fontSize: 14,
                  fontWeight: FontWeight.w600)),
      InfoContentView(
          title: S.current.phone_num,
          content: userInfo?.phone ?? "S.of(context).not_update",
          contentStyle: userInfo?.phone != null
              ? const TextStyle(
                  fontFamily: family, fontSize: 14, fontWeight: FontWeight.w600)
              : TextStyle(
                  fontFamily: family,
                  color: Colors.black.withOpacity(0.3),
                  fontSize: 14,
                  fontWeight: FontWeight.w600)),
      InfoContentView(
          title: "S.current.id_number",
          content: "userInfo?.cmnd" ?? "S.of(context).not_update",
          contentStyle: "userInfo?.cmnd" != null
              ? const TextStyle(
                  fontFamily: family, fontSize: 14, fontWeight: FontWeight.w600)
              : TextStyle(
                  fontFamily: family,
                  color: Colors.black.withOpacity(0.3),
                  fontSize: 14,
                  fontWeight: FontWeight.w600)),
      InfoContentView(
          title: "S.current.date_of_birth",
          content: "userInfo?.birthday" != null
              ? Utils.dateFormat("userInfo!.birthday"!)
              : "S.of(context).not_update",
          contentStyle: "userInfo?.birthday" != null
              ? const TextStyle(
                  fontFamily: family, fontSize: 14, fontWeight: FontWeight.w600)
              : TextStyle(
                  fontFamily: family,
                  color: Colors.black.withOpacity(0.3),
                  fontSize: 14,
                  fontWeight: FontWeight.w600)),
      InfoContentView(
          title: " S.current.gender",
          content: _genderString(context, userInfo?.sex),
          contentStyle: userInfo?.sex != null
              ? const TextStyle(
                  fontFamily: family, fontSize: 14, fontWeight: FontWeight.w600)
              : TextStyle(
                  fontFamily: family,
                  color: Colors.black.withOpacity(0.3),
                  fontSize: 14,
                  fontWeight: FontWeight.w600)),
      InfoContentView(
          title: "S.current.country",
          content: "userInfo?.national" ?? "S.of(context).not_update",
          contentStyle: "userInfo?.national" != null
              ? const TextStyle(
                  fontFamily: family, fontSize: 14, fontWeight: FontWeight.w600)
              : TextStyle(
                  fontFamily: family,
                  color: Colors.black.withOpacity(0.3),
                  fontSize: 14,
                  fontWeight: FontWeight.w600)),
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
                    lable: S.of(context).info,
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
                  Utils.pushScreen(
                      context,
                      EditPersonalInfo(
                        user: null,
                      ));
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
