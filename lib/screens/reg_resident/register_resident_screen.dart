import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../../models/selection_model.dart';
import '../../utils/utils.dart';
import '../../widgets/item_selected.dart';
import '../../widgets/primary_bottom_sheet.dart';
import '../home/home_screen.dart';
import './prv/register_resident_prv.dart';
import 'add_new_resident_screen.dart';

class RegisterResidentScreen extends StatefulWidget {
  const RegisterResidentScreen({super.key});
  static const routeName = '/reg_resident';

  @override
  State<RegisterResidentScreen> createState() => _RegisterResidentScreenState();
}

class _RegisterResidentScreenState extends State<RegisterResidentScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => RegisterResidentPrv(),
        builder: (context, child) {
          return PrimaryScreen(
            appBar: PrimaryAppbar(
              title: S.of(context).add_dependent_person,
              leading: BackButton(
                onPressed: () => Navigator.pushReplacementNamed(
                    context, HomeScreen.routeName),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              tooltip: S.of(context).reg_service,
              onPressed: () {
                Utils.showBottomSheet(
                    context: context,
                    child: PrimaryBottomSheet(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 40,
                            child: Center(
                              child: Text(S.of(context).dependent_person,
                                  overflow: TextOverflow.ellipsis,
                                  style: txtLinkSmall(color: grayScaleColor1)),
                            ),
                          ),
                          const Divider(
                            height: 1,
                          ),
                          ItemSelected(
                            text: S.of(context).dependence_has_info,
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          const Divider(
                            height: 1,
                          ),
                          ItemSelected(
                            text: S.of(context).dependence_not_info,
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(
                                  context, AddNewResidentScreen.routeName);
                            },
                          ),
                        ],
                      ),
                    ));
              },
              backgroundColor: primaryColorBase,
              child: const Icon(
                Icons.add,
                size: 40,
              ),
            ),
          );
        });
  }
}
