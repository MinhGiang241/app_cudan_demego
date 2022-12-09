import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../constants/api_constant.dart';
import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../../models/new.dart';
import '../../utils/utils.dart';
import '../../widgets/primary_empty_widget.dart';
import '../../widgets/primary_error_widget.dart';
import '../../widgets/primary_icon.dart';
import '../../widgets/primary_image_netword.dart';
import '../../widgets/primary_loading.dart';
import '../../widgets/primary_screen.dart';
import 'new_details_screen.dart';
import 'prv/news_list_prv.dart';

class NewListScreen extends StatefulWidget {
  const NewListScreen({super.key});
  static const routeName = '/news';

  @override
  State<NewListScreen> createState() => _NewListScreenState();
}

class _NewListScreenState extends State<NewListScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as String;
    return ChangeNotifierProvider(
      create: (context) => NewListPrv(type: arg),
      builder: (context, child) {
        return PrimaryScreen(
          appBar: PrimaryAppbar(
            title: S.of(context).news,
          ),
          body: WillPopScope(
            onWillPop: () async {
              context.read<NewListPrv>().clearInitList();

              Navigator.pop(context);
              return Future.value(false);
            },
            child: SafeArea(
              child: FutureBuilder(
                  future: context.read<NewListPrv>().getNews(context, true),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: PrimaryLoading());
                    } else if (snapshot.connectionState ==
                        ConnectionState.none) {
                      return PrimaryErrorWidget(
                          code: snapshot.hasError ? "err" : "1",
                          message: snapshot.data.toString(),
                          onRetry: () async {
                            setState(() {});
                          });
                    } else if (context.watch<NewListPrv>().listNews.isEmpty) {
                      return SmartRefresher(
                        enablePullDown: true,
                        enablePullUp: true,
                        header: WaterDropMaterialHeader(
                            backgroundColor: Theme.of(context).primaryColor),
                        controller: _refreshController,
                        onRefresh: () async {
                          await Future.delayed(
                              const Duration(milliseconds: 1000));
                          if (mounted) setState(() {});
                          _refreshController.refreshCompleted();
                        },
                        onLoading: () async {
                          await context
                              .read<NewListPrv>()
                              .getNews(context, false);

                          _refreshController.loadComplete();
                        },
                        child: PrimaryEmptyWidget(
                          emptyText: S.of(context).no_news,
                          icons: PrimaryIcons.news,
                          action: () {},
                        ),
                      );
                    }
                    return SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      header: WaterDropMaterialHeader(
                          backgroundColor: Theme.of(context).primaryColor),
                      controller: _refreshController,
                      onRefresh: () async {
                        await Future.delayed(
                            const Duration(milliseconds: 1000));
                        if (mounted) setState(() {});
                        _refreshController.refreshCompleted();
                      },
                      onLoading: () async {
                        await context
                            .read<NewListPrv>()
                            .getNews(context, false);

                        _refreshController.loadComplete();
                      },
                      child: ListView(
                        children: [
                          vpad(24),
                          ...context
                              .watch<NewListPrv>()
                              .listNews
                              .asMap()
                              .entries
                              .map<Widget>(
                            (e) {
                              if (e.key == 0) {
                                return PrimaryCard(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, NewDetailsScreen.routeName,
                                        arguments: e.value);
                                  },
                                  margin: const EdgeInsets.only(
                                    bottom: 16,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 16),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        bottom: -5,
                                        right: -10,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            S.of(context).not_read,
                                            style:
                                                txtRegular(12, greenColorBase),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            e.value.title ?? '',
                                            overflow: TextOverflow.ellipsis,
                                            style: txtBodyMediumBold(
                                                color: grayScaleColorBase),
                                            textAlign: TextAlign.left,
                                          ),
                                          vpad(12),
                                          SizedBox(
                                            width: double.infinity,
                                            child: PrimaryImageNetwork(
                                              canShowPhotoView: false,
                                              path:
                                                  "${ApiConstants.uploadURL}?load=${e.value.image}",
                                              fit: BoxFit.cover,
                                              height: 150,
                                            ),
                                          ),
                                          // Image.network(
                                          //   "${ApiConstants.uploadURL}?load=${e.value.image}",
                                          //   fit: BoxFit.contain,
                                          //   width: double.infinity,
                                          //   height: 150,
                                          // ),
                                          vpad(12),
                                          Text(
                                            e.value.title ?? '',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: txtBodyMediumRegular(
                                                color: grayScaleColorBase),
                                          ),
                                          vpad(12),
                                          Text(
                                            Utils.dateFormat(
                                                e.value.date ?? "", 1),
                                            maxLines: 1,
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.ellipsis,
                                            style: txtBodySmallRegular(
                                                color: grayScaleColorBase),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return PrimaryCard(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, NewDetailsScreen.routeName,
                                      arguments: e.value);
                                },
                                height: 100,
                                margin: const EdgeInsets.only(bottom: 16),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                          S.of(context).not_read,
                                          style: txtRegular(12, greenColorBase),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        PrimaryImageNetwork(
                                          canShowPhotoView: false,
                                          width: 120,
                                          height: double.infinity,
                                          path:
                                              "${ApiConstants.uploadURL}?load=${e.value.image}",
                                        ),
                                        hpad(12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            textDirection: TextDirection.ltr,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                e.value.title ?? '',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: txtBodyMediumBold(
                                                    color: grayScaleColorBase),
                                              ),
                                              Text(
                                                e.value.content ?? "",
                                                maxLines: 1,
                                                textAlign: TextAlign.left,
                                                overflow: TextOverflow.ellipsis,
                                                style: txtBodyMediumRegular(
                                                    color: grayScaleColorBase),
                                              ),
                                              Text(
                                                Utils.dateFormat(
                                                    e.value.date ?? "", 1),
                                                maxLines: 1,
                                                textAlign: TextAlign.left,
                                                overflow: TextOverflow.ellipsis,
                                                style: txtBodySmallRegular(
                                                    color: grayScaleColorBase),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ),
        );
      },
    );
  }
}
