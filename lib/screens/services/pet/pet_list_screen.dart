import 'package:app_cudan/screens/services/pet/prv/pet_list_prv.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../widgets/primary_empty_widget.dart';
import '../../../widgets/primary_error_widget.dart';
import '../../../widgets/primary_icon.dart';
import '../../../widgets/primary_loading.dart';
import '../service_screen.dart';

class PetListScreen extends StatefulWidget {
  const PetListScreen({super.key});
  static const routeName = '/pet';

  @override
  State<PetListScreen> createState() => _PetListScreenState();
}

class _PetListScreenState extends State<PetListScreen> {
  var initIndex = 0;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PetListPrv(),
      builder: (context, child) {
        return PrimaryScreen(
          appBar: PrimaryAppbar(
            title: S.of(context).reg_pet_list,
            leading: BackButton(
              onPressed: () => Navigator.pushReplacementNamed(
                  context, ServiceScreen.routeName),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            tooltip: S.of(context).reg_pet,
            onPressed: () {
              // Navigator.pushNamed(context, RegisterDelivery.routeName,
              //     arguments: {"isEdit": false});
            },
            backgroundColor: primaryColorBase,
            child: const Icon(
              Icons.add,
              size: 40,
            ),
          ),
          body: FutureBuilder(
            future: () async {}(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: PrimaryLoading());
              } else if (snapshot.connectionState == ConnectionState.none) {
                return PrimaryErrorWidget(
                    code: snapshot.hasError ? "err" : "1",
                    message: snapshot.data.toString(),
                    onRetry: () async {
                      setState(() {});
                    });
              } else if ([].isEmpty) {
                SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  header: WaterDropMaterialHeader(
                      backgroundColor: Theme.of(context).primaryColor),
                  controller: _refreshController,
                  onRefresh: () {
                    setState(() {});
                    _refreshController.refreshCompleted();
                  },
                  child: PrimaryEmptyWidget(
                    emptyText: S.of(context).no_delivery,
                    // buttonText: S.of(context).add_trans_card,
                    icons: PrimaryIcons.bone,
                    action: () {
                      // Utils.pushScreen(context, const RegisterParkingCard());
                    },
                  ),
                );
              }
              return SafeArea(
                child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  header: WaterDropMaterialHeader(
                      backgroundColor: Theme.of(context).primaryColor),
                  controller: _refreshController,
                  onRefresh: () {
                    setState(() {});
                    _refreshController.refreshCompleted();
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
