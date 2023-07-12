import 'package:app_cudan/screens/auth/prv/auth_prv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../../models/response_resident_own.dart';
import '../../services/api_tower.dart';
import '../../services/prf_data.dart';
import '../../widgets/primary_card.dart';
import '../../widgets/primary_icon.dart';
import '../../widgets/primary_screen.dart';
import '../ho/prv/ho_account_service_prv.dart';
import '../home/home_screen.dart';
import 'prv/resident_info_prv.dart';

class ApartmentSeletionScreen extends StatefulWidget {
  const ApartmentSeletionScreen({
    Key? key,
    required this.context,
  }) : super(key: key);
  static const routeName = '/selection';
  final BuildContext context;

  @override
  State<ApartmentSeletionScreen> createState() =>
      _ApartmentSeletionScreenState();
}

// Fake data

class _ApartmentSeletionScreenState extends State<ApartmentSeletionScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as String;
    var listOwn = widget.context.read<ResidentInfoPrv>().listOwn;

    var listProject = [];
    for (var e in listOwn) {
      if (e.apartment?.name != null) {
        listProject.add(e.apartment?.name);
      }
    }

    listProject.toSet().toList();
    return PrimaryScreen(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthPrv>().onSignOut(context);
            },
            icon: const Icon(Icons.logout),
          ),
          hpad(12)
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Text(
                S.of(context).choose_an_apartment,
                style: txtDisplayMedium(),
              ),
            ),
            vpad(20),
            Expanded(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                children: [
                  vpad(12),
                  Text(arg, style: txtBold(14, grayScaleColorBase)),
                  vpad(12),
                  ...listOwn.asMap().entries.map(
                        (e) => PrimaryCard(
                          onTap: () async {
                            context
                                .read<HOAccountServicePrv>()
                                .navigateToHomeScreen(context, e.value);
                          },
                          margin: const EdgeInsets.only(bottom: 16),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: ListTile(
                              leading: const PrimaryIcon(
                                icons: PrimaryIcons.home_smile,
                                color: primaryColor4,
                                backgroundColor: primaryColor5,
                                style: PrimaryIconStyle.round,
                                padding: EdgeInsets.all(12),
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.value.building?.name ?? '',
                                    style: txtLinkSmall(),
                                  ),
                                  vpad(4),
                                  Text(
                                    '${e.value.apartment?.name ?? ''} - ${e.value.floor?.name ?? ''}',
                                    style: txtBodySmallBold(),
                                  ),
                                  // vpad(4),
                                  // Text('Thông tin thêm',
                                  //     style: txtBodySmallRegular()),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                  vpad(50)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
