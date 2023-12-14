import 'package:app_cudan/screens/display_services/prv/display_service_prv.dart';
import 'package:app_cudan/widgets/primary_card.dart';
import 'package:app_cudan/widgets/primary_image_netword.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../services/api_service.dart';
import '../../../widgets/primary_empty_widget.dart';
import '../../../widgets/primary_error_widget.dart';
import '../../../widgets/primary_icon.dart';
import '../../../widgets/primary_loading.dart';

class ServiceList extends StatefulWidget {
  const ServiceList({super.key});

  @override
  State<ServiceList> createState() => _ServiceListState();
}

class _ServiceListState extends State<ServiceList> {
  @override
  Widget build(BuildContext context) {
    final RefreshController _refreshController =
        RefreshController(initialRefresh: false);
    final RefreshController _emptyRefreshController =
        RefreshController(initialRefresh: false);
    return FutureBuilder(
      future: context.read<DisplayServicePrv>().getLinkingService(context),
      builder: (context, snapshot) {
        var list = context.watch<DisplayServicePrv>().linkingList;
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
        return Column(
          children: [
            Expanded(
              child: SmartRefresher(
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
                child: ListView(
                  children: [
                    vpad(12),
                    ...list.map(
                      (v) => PrimaryCard(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(bottom: 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0),
                                    bottomLeft: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0),
                                  ),
                                  child: PrimaryImageNetwork(
                                    width: 98,
                                    height: 96,
                                    canShowPhotoView: false,
                                    path:
                                        '${ApiService.shared.uploadURL}/?load=${v.image}&regcode=${ApiService.shared.regCode}',
                                  ),
                                ),
                                hpad(10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AutoSizeText(
                                        v.name ?? '',
                                        style: txtBold(14, primaryColorBase),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                      AutoSizeText(
                                        v.address ?? "",
                                        style: txtRegular(
                                          12,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                      AutoSizeText(
                                        "${v.time_start ?? ''} - ${v.time_end ?? ''}",
                                        style: txtRegular(
                                          12,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                      AutoSizeText(
                                        v.id ?? '',
                                        style: txtRegular(
                                          12,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
