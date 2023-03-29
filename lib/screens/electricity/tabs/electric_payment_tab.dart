import 'package:app_cudan/widgets/primary_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../constants/constants.dart';

class ElectricityPaymentTab extends StatefulWidget {
  const ElectricityPaymentTab({super.key});

  @override
  State<ElectricityPaymentTab> createState() => _ElectricityPaymentTabState();
}

class _ElectricityPaymentTabState extends State<ElectricityPaymentTab> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: () async {}(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: PrimaryLoading(),
          );
        }
        return SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          header: WaterDropMaterialHeader(
            backgroundColor: Theme.of(context).primaryColor,
          ),
          controller: _refreshController,
          onRefresh: () {
            _refreshController.refreshCompleted();
            setState(() {});
          },
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            children: [
              vpad(12),
              Text("kddkdkd"),
            ],
          ),
        );
      },
    );
  }
}
