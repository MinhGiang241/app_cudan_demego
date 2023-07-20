import 'package:app_cudan/screens/home/home_screen.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_card.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../../utils/utils.dart';
import '../../widgets/custom_footer_refresh.dart';
import '../../widgets/primary_empty_widget.dart';
import '../../widgets/primary_error_widget.dart';
import '../../widgets/primary_icon.dart';
import '../../widgets/primary_loading.dart';
import '../../widgets/primary_screen.dart';
import 'notification_detail_screen.dart';
import 'prv/notification_prv.dart';
import 'prv/undread_noti.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});
  static const routeName = '/notification';

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    // final messages =
    //     ModalRoute.of(context)?.settings.arguments as RemoteMessage?;
    onTapFilter(BuildContext context, setState) {
      var notiTypeList = context.read<NotificationPrv>().notiTypeList;
      var unReadCount = UnreadNotification.unReadCount;
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (contex) => Column(
          children: [
            vpad(30),
            Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    S.of(context).notification_type,
                    style: txtBold(16, grayScaleColorBase),
                  ),
                  hpad(50),
                ],
              ),
            ),
            vpad(24),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...notiTypeList.map(
                      (e) {
                        var index = unReadCount.indexWhere((o) => o.id == e.id);
                        if (index != -1 && unReadCount[index].total! > 0) {
                          e.isRead = false;
                        }
                        return PrimaryCard(
                          onTap: () {
                            context
                                .read<NotificationPrv>()
                                .setSelectedType(e.id ?? '');
                            Navigator.pop(context);
                            setState(() {});
                          },
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          width: dvWidth(context) - 48,
                          child: Row(
                            children: [
                              // PrimaryImageNetwork(
                              //   path:
                              //       "${ApiService.shared.uploadURL}/?load=${e.icon}&regcode=${ApiService.shared.regCode}",
                              // ),
                              PrimaryIcon(
                                icons: PrimaryIcons.bell_fill,
                                size: 30,
                                padding: const EdgeInsets.all(10),
                                style: PrimaryIconStyle.round,
                                backgroundColor: primaryColor5,
                                color: e.isRead == false
                                    ? primaryColor1
                                    : primaryColor4,
                              ),
                              hpad(20),
                              Expanded(
                                child: Text(
                                  e.name ?? '',
                                  style: txtBold(14, grayScaleColorBase),
                                ),
                              ),
                              if (e.isRead == false)
                                SizedBox(
                                  height: 40,
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      padding: const EdgeInsets.all(3),
                                      height: 15,
                                      width: 15,
                                      decoration: BoxDecoration(
                                        gradient: gradientPrimary,
                                        borderRadius: BorderRadius.circular(9),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return ChangeNotifierProvider(
      create: (_) => NotificationPrv(),
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: PrimaryScreen(
            appBar: PrimaryAppbar(
              leading: BackButton(
                onPressed: () async {
                  //await context.read<NotificationPrv>().getUnReadNotification();
                  var c = context.read<NotificationPrv>().unRead;
                  UnreadNotification.count.add(c);
                  Navigator.pushReplacementNamed(
                    context,
                    HomeScreen.routeName,
                  );
                },
              ),
              title: S.of(context).notification,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Center(
                    child: PrimaryIcon(
                      icons: PrimaryIcons.faders,
                      onTap: () => onTapFilter(context, setState),
                    ),
                  ),
                )
              ],
            ),
            body: FutureBuilder(
              future: context.read<NotificationPrv>().getInitData(context),
              builder: (context, snapshot) {
                var notiList =
                    context.watch<NotificationPrv>().notificationList;
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
                } else if (notiList.isEmpty) {
                  return SafeArea(
                    child: SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: false,
                      footer: customFooter(),
                      header: WaterDropMaterialHeader(
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      controller: _refreshController,
                      onRefresh: () async {
                        setState(() {});
                        _refreshController.refreshCompleted();
                      },
                      onLoading: () async {
                        _refreshController.loadComplete();
                      },
                      child: PrimaryEmptyWidget(
                        emptyText: S.of(context).no_notification,
                        icons: PrimaryIcons.bell_fill,
                        action: () {},
                      ),
                    ),
                  );
                }
                return SafeArea(
                  child: SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    header: WaterDropMaterialHeader(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    controller: _refreshController,
                    footer: customFooter(),
                    onRefresh: () async {
                      await context
                          .read<NotificationPrv>()
                          .getNotificationList(true);
                      _refreshController.refreshCompleted();
                    },
                    onLoading: () async {
                      await context
                          .read<NotificationPrv>()
                          .getNotificationList(false);
                      _refreshController.loadComplete();
                    },
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      children: [
                        vpad(24),
                        ...notiList.asMap().entries.map(
                              (e) => PrimaryCard(
                                onTap: () {
                                  context
                                      .read<NotificationPrv>()
                                      .markReadNotification(
                                        e.value,
                                        e.key,
                                      );
                                  Navigator.of(context).pushNamed(
                                    NotificationDetailsScreen.routeName,
                                    arguments: e.value,
                                  );
                                },
                                margin: const EdgeInsets.only(bottom: 16),
                                child: Stack(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(flex: 1, child: hpad(0)),
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 5,
                                                ),
                                                child: Text(
                                                  e.value.message?.subject ??
                                                      "",
                                                  style: txtBold(
                                                    14,
                                                    grayScaleColorBase,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 5,
                                                ),
                                                child: Text(
                                                  e.value.message?.content ??
                                                      "",
                                                  style: txtRegular(
                                                    14,
                                                    grayScaleColorBase,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 5,
                                                ),
                                                child: Text(
                                                  Utils.dateFormat(
                                                    e.value.createdTime ?? "",
                                                    1,
                                                  ),
                                                  style: txtRegular(
                                                    14,
                                                    grayScaleColorBase,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(flex: 2, child: hpad(0)),
                                      ],
                                    ),
                                    Positioned(
                                      bottom: 5,
                                      right: 10,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          e.value.isRead == true
                                              ? S.of(context).al_read
                                              : S.of(context).not_read,
                                          style: txtRegular(
                                            12,
                                            e.value.isRead == true
                                                ? grayScaleColorBase
                                                : greenColorBase,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
