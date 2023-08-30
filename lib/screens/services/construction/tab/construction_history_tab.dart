import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/constants.dart';
import '../../../../widgets/primary_error_widget.dart';
import '../../../../widgets/primary_loading.dart';
import '../../../../widgets/timeline_view.dart';
import '../prv/construction_history_prv.dart';

// ignore: must_be_immutable
class ConstructionHistoryTab extends StatefulWidget {
  ConstructionHistoryTab({super.key, required this.constructionregistrationId});
  String constructionregistrationId;

  @override
  State<ConstructionHistoryTab> createState() => _ConstructionHistoryTabState();
}

class _ConstructionHistoryTabState extends State<ConstructionHistoryTab> {
  // final RefreshController _refreshController =
  //     RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ConstructionHistoryPrv(),
      builder: (context, state) {
        return FutureBuilder(
          future: context
              .read<ConstructionHistoryPrv>()
              .getHistoryList(context, widget.constructionregistrationId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: PrimaryLoading());
            } else if (snapshot.connectionState == ConnectionState.none) {
              return PrimaryErrorWidget(
                code: snapshot.hasError ? "err" : "1",
                message: snapshot.data.toString(),
                onRetry: () async {
                  setState(() {});
                },
              );
            } else if (context.watch<ConstructionHistoryPrv>().list.isEmpty) {
              return SafeArea(
                child:
                    // SmartRefresher(
                    //   enablePullDown: true,
                    //   enablePullUp: false,
                    //   header: WaterDropMaterialHeader(
                    //       backgroundColor: Theme.of(context).primaryColor),
                    //   controller: _refreshController,
                    //   onRefresh: () {
                    //     setState(() {});
                    //     _refreshController.refreshCompleted();
                    //   },
                    //   child:
                    ListView(
                  children: [
                    vpad(24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: TimeLineView(),
                    ),
                  ],
                ),
                // ),
              );
            }

            return SafeArea(
              child:
                  // SmartRefresher(
                  //   enablePullDown: true,
                  //   enablePullUp: false,
                  //   header: WaterDropMaterialHeader(
                  //       backgroundColor: Theme.of(context).primaryColor),
                  //   controller: _refreshController,
                  //   onRefresh: () {
                  //     setState(() {});
                  //     _refreshController.refreshCompleted();
                  //   },
                  //   child:

                  ListView(
                children: [
                  vpad(24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TimeLineView(
                      content: context.watch<ConstructionHistoryPrv>().content,
                    ),
                  ),
                ],
              ),
              // ),
            );
          },
        );
      },
    );

    // FutureBuilder(builder: (context, snapshot) {
    //           return ListView(
    //             children: [
    //               vpad(24),
    //               const Padding(
    //                 padding: EdgeInsets.symmetric(horizontal: 12),
    //                 child: TimeLineView(),
    //               )
    //             ],
    //           );
    //         });
  }
}
