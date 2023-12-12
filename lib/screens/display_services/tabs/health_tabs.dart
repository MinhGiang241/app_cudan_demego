import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../generated/l10n.dart';
import '../../../widgets/primary_empty_widget.dart';
import '../../../widgets/primary_error_widget.dart';
import '../../../widgets/primary_icon.dart';
import '../../../widgets/primary_loading.dart';

class HealthTab extends StatefulWidget {
  const HealthTab({super.key});

  @override
  State<HealthTab> createState() => _HealthTabState();
}

class _HealthTabState extends State<HealthTab> {
  @override
  Widget build(BuildContext context) {
    final RefreshController _refreshController =
        RefreshController(initialRefresh: false);
    final RefreshController _emptyRefreshController =
        RefreshController(initialRefresh: false);
    return FutureBuilder(
      future: () async {}(),
      builder: (context, snapshot) {
        var list = [];
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: PrimaryLoading());
        } else if (snapshot.connectionState == ConnectionState.none) {
          return PrimaryErrorWidget(
            code: snapshot.hasError ? 'err' : '1',
            message: snapshot.data.toString(),
            onRetry: () async {
              setState(() {});
            },
          );
        } else if (list.isEmpty) {
          return SafeArea(
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              header: WaterDropMaterialHeader(
                backgroundColor: Theme.of(context).primaryColor,
              ),
              controller: _emptyRefreshController,
              onRefresh: () {
                setState(() {});
                _emptyRefreshController.refreshCompleted();
              },
              child: PrimaryEmptyWidget(
                emptyText: S.of(context).no_display_ser,
                icons: PrimaryIcons.planet,
                action: () {},
              ),
            ),
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
            setState(() {});
            _refreshController.refreshCompleted();
          },
          child: ListView(children: []),
        );
      },
    );
  }
}
