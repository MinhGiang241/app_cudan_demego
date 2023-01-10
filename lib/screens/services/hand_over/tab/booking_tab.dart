import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../generated/l10n.dart';
import '../../../../widgets/primary_empty_widget.dart';
import '../../../../widgets/primary_error_widget.dart';
import '../../../../widgets/primary_icon.dart';
import '../../../../widgets/primary_loading.dart';

class BookingTab extends StatefulWidget {
  BookingTab({super.key});
  var list = [];

  @override
  State<BookingTab> createState() => _BookingTabState();
}

class _BookingTabState extends State<BookingTab> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
        } else if (widget.list.isEmpty) {
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
              child: PrimaryEmptyWidget(
                emptyText: S.of(context).no_hand_over,
                icons: PrimaryIcons.home,
                action: () {},
              ),
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
          child: ListView(),
        ));
      },
    );
  }
}
