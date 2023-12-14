import 'package:app_cudan/constants/constants.dart';
import 'package:app_cudan/screens/display_services/prv/display_service_prv.dart';
import 'package:app_cudan/screens/display_services/tabs/health_tabs.dart';
import 'package:app_cudan/services/api_service.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:app_cudan/widgets/primary_text_field.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../generated/l10n.dart';
import '../../widgets/primary_card.dart';
import '../../widgets/primary_empty_widget.dart';
import '../../widgets/primary_error_widget.dart';
import '../../widgets/primary_icon.dart';
import '../../widgets/primary_image_netword.dart';
import '../../widgets/primary_loading.dart';

class DisplayServiceScreen extends StatefulWidget {
  const DisplayServiceScreen({super.key});
  static const routeName = '/display';

  @override
  State<DisplayServiceScreen> createState() => _DisplayServiceScreenState();
}

class _DisplayServiceScreenState extends State<DisplayServiceScreen>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final RefreshController _emptyRefreshController =
      RefreshController(initialRefresh: false);
  late AnimationController animationFilterController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 100),
  );

  late Animation<double> animationFilter = CurvedAnimation(
    parent: animationFilterController,
    curve: Curves.easeInOut,
    // reverseCurve: Curves.easeInOut,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DisplayServicePrv(context: context),
      builder: (context, builder) {
        var showFilter = context.watch<DisplayServicePrv>().showFilterSpec;
        var list = context.watch<DisplayServicePrv>().linkingList;
        var loading = context.watch<DisplayServicePrv>().loading;
        return PrimaryScreen(
          appBar: PrimaryAppbar(
            title: S.of(context).display_service,
            // tabController: tabController,
            isTabScrollabel: false,
            titleWidget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
              child: PrimaryTextField(
                hint: S.of(context).search,
                border: Border.all(color: grayScaleColorBase),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {});
                  },
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  context.read<DisplayServicePrv>().toggleShowFilter();
                  if (!showFilter) {
                    // isShowAsset = false;
                    animationFilterController.reverse();
                  } else {
                    // isShowAsset = true;
                    animationFilterController.forward();
                  }
                },
                icon: Icon(Icons.filter_alt_outlined),
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                SizeTransition(
                  sizeFactor: animationFilter,
                  child: Text(
                    'ssssfgdfgfdgdfgdfgdffgdfgdfgretwrwerwrerwerwerews',
                  ),
                ),
                Expanded(
                  child: loading
                      ? Center(child: PrimaryLoading())
                      : SmartRefresher(
                          enablePullDown: true,
                          enablePullUp: false,
                          header: WaterDropMaterialHeader(
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          controller: _refreshController,
                          onRefresh: () async {
                            await context
                                .read<DisplayServicePrv>()
                                .getLinkingService(context);
                            _refreshController.refreshCompleted();
                          },
                          child: list.isEmpty
                              ? PrimaryEmptyWidget(
                                  emptyText: S.of(context).no_display_ser,
                                  icons: PrimaryIcons.planet,
                                  action: () {},
                                )
                              : ListView(
                                  children: [
                                    vpad(12),
                                    ...list.map(
                                      (v) => PrimaryCard(
                                        padding: EdgeInsets.all(10),
                                        margin: EdgeInsets.only(bottom: 10),
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(
                                                  10.0,
                                                ),
                                                topRight: Radius.circular(
                                                  10.0,
                                                ),
                                                bottomLeft: Radius.circular(
                                                  10.0,
                                                ),
                                                bottomRight: Radius.circular(
                                                  10.0,
                                                ),
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
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  AutoSizeText(
                                                    v.name ?? '',
                                                    style: txtBold(
                                                      14,
                                                      primaryColorBase,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                  ),
                                                  vpad(6),
                                                  AutoSizeText(
                                                    v.address ?? "",
                                                    style: txtRegular(
                                                      12,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                  ),
                                                  vpad(6),
                                                  AutoSizeText(
                                                    "${v.time_start ?? ''} - ${v.time_end ?? ''}",
                                                    style: txtRegular(
                                                      12,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                  ),
                                                  vpad(6),
                                                  AutoSizeText(
                                                    v.id ?? '',
                                                    style: txtRegular(
                                                      12,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                  ),
                                                ],
                                              ),
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
            ),

            // TabBarView(
            //   controller: tabController,
            //   children: [
            //     HealthTab(),
            //     ShoppingTab(),
            //   ],
            // ),
          ),
        );
      },
    );
  }
}
