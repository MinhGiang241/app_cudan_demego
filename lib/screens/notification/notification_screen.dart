import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../../widgets/custom_footer_refresh.dart';
import '../../widgets/primary_empty_widget.dart';
import '../../widgets/primary_error_widget.dart';
import '../../widgets/primary_icon.dart';
import '../../widgets/primary_loading.dart';
import '../../widgets/primary_screen.dart';
import 'prv/notification_prv.dart';

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
    var category = [
      {"title": S.current.all, "icon": PrimaryIcons.bell_fill, "isRead": true},
      {
        "title": S.current.general_notification,
        "icon": PrimaryIcons.star,
        "isRead": true
      },
      {
        "title": S.current.event_notification,
        "icon": PrimaryIcons.calendar_block,
        "isRead": false
      },
      {
        "title": S.current.system_notification,
        "icon": PrimaryIcons.setting,
        "isRead": true
      },
      {
        "title": S.current.service_reflection,
        "icon": PrimaryIcons.service_feedback,
        "isRead": false
      },
      {"title": S.current.forum, "icon": PrimaryIcons.detail, "isRead": true},
      {
        "title": S.current.birthday_congratulaion,
        "icon": PrimaryIcons.birthday,
        "isRead": true
      },
      {
        "title": S.current.new_resident,
        "icon": PrimaryIcons.new_user,
        "isRead": false
      },
      {
        "title": S.current.debt,
        "icon": PrimaryIcons.remind_debt,
        "isRead": false
      },
    ];
    onTapFilter() {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (contex) => Column(children: [
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
              child: Column(children: [
                ...category.map(
                  (e) => PrimaryCard(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      width: dvWidth(context) - 48,
                      child: Row(
                        children: [
                          PrimaryIcon(
                            icons: e['icon'] as PrimaryIcons,
                            size: 35,
                            padding: const EdgeInsets.all(16),
                            style: PrimaryIconStyle.round,
                            backgroundColor: primaryColor5,
                            color: e['isRead'] == true
                                ? primaryColor4
                                : primaryColor1,
                          ),
                          hpad(20),
                          Expanded(
                            child: Text(e['title'] as String,
                                style: txtBold(14, grayScaleColorBase)),
                          ),
                          if (e['isRead'] == false)
                            SizedBox(
                              height: 60,
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  height: 18,
                                  width: 18,
                                  decoration: BoxDecoration(
                                      gradient: gradientPrimary,
                                      borderRadius: BorderRadius.circular(9)),
                                ),
                              ),
                            ),
                        ],
                      )),
                )
              ]),
            ),
          ),
        ]),
      );
    }

    return ChangeNotifierProvider(
      create: (_) => NotificationPrv(),
      builder: (context, state) {
        var notifications = [
          {
            "title": "Ti??u ?????",
            "content": "N???i dung v???n t???t",
            'date': "09/01/2023"
          },
          {
            "title": "Th??ng b??o s??? ki???n",
            "content": "N???i dung v???n t???t",
            'date': "09/01/2023"
          },
          {
            "title": "Th??ng b??o h??? th???ng",
            "content": "N???i dung v???n t???t",
            'date': "09/01/2023"
          },
          {
            "title": "Ph???n h???i d???ch v???",
            "content": "N???i dung v???n t???t",
            'date': "09/01/2023"
          },
          {
            "title": "Di???n ????n",
            "content": "N???i dung v???n t???t",
            'date': "09/01/2023"
          },
          {
            "title": "Ch??c m???ng sinh nh???t",
            "content": "N???i dung v???n t???t",
            'date': "09/01/2023"
          },
          {
            "title": "C?? d??n m???i",
            "content": "N???i dung v???n t???t",
            'date': "09/01/2023"
          },
        ];
        return PrimaryScreen(
          appBar: PrimaryAppbar(
            title: S.of(context).notification,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Center(
                  child: PrimaryIcon(
                    icons: PrimaryIcons.faders,
                    onTap: onTapFilter,
                  ),
                ),
              )
            ],
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
                } else if (notifications.isEmpty) {
                  return SafeArea(
                    child: SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: false,
                      footer: customFooter(),
                      header: WaterDropMaterialHeader(
                          backgroundColor: Theme.of(context).primaryColor),
                      controller: _refreshController,
                      onRefresh: () async {
                        setState(() {});
                        _refreshController.refreshCompleted();
                      },
                      onLoading: () async {
                        await Future.delayed(const Duration(seconds: 1));
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
                        backgroundColor: Theme.of(context).primaryColor),
                    controller: _refreshController,
                    footer: customFooter(),
                    onRefresh: () async {
                      setState(() {});
                      _refreshController.refreshCompleted();
                    },
                    onLoading: () async {
                      await Future.delayed(const Duration(seconds: 1));
                      setState(() {});
                      _refreshController.loadComplete();
                    },
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      children: [
                        vpad(24),
                        ...notifications.map((e) => PrimaryCard(
                              onTap: () {},
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
                                                      vertical: 5),
                                              child: Text(
                                                e['title'] ?? "",
                                                style: txtBold(
                                                    14, grayScaleColorBase),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5),
                                              child: Text(e['content'] ?? "",
                                                  style: txtRegular(
                                                      14, grayScaleColorBase)),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5),
                                              child: Text(e['date'] ?? "",
                                                  style: txtRegular(
                                                      14, grayScaleColorBase)),
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
                                        // e.value.isRead == true
                                        //     ? S.of(context).al_read
                                        //     :
                                        S.of(context).not_read,
                                        style: txtRegular(
                                            12,
                                            // e.value.isRead == true
                                            //     ? grayScaleColorBase
                                            //     :
                                            greenColorBase),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                );
              }),
        );
      },
    );
  }
}
