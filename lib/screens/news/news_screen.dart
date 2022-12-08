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
import '../../widgets/primary_screen.dart';
import 'new_details_screen.dart';
import 'prv/news_list_prv.dart';

class NewListScreen extends StatefulWidget {
  NewListScreen({super.key});
  static const routeName = '/news';

  @override
  State<NewListScreen> createState() => _NewListScreenState();
}

class _NewListScreenState extends State<NewListScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as List<New>;
    return ChangeNotifierProvider(
      create: (context) => NewListPrv(),
      builder: (context, child) {
        return PrimaryScreen(
          appBar: PrimaryAppbar(
            title: S.of(context).news,
          ),
          body: SafeArea(
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: WaterDropMaterialHeader(
                  backgroundColor: Theme.of(context).primaryColor),
              controller: _refreshController,
              onRefresh: () async {
                await Future.delayed(const Duration(milliseconds: 1000));
                if (mounted) setState(() {});
                _refreshController.refreshCompleted();
              },
              onLoading: () async {
                await Future.delayed(const Duration(milliseconds: 1000));
                if (mounted) setState(() {});
                _refreshController.loadComplete();
              },
              child: ListView(
                children: [
                  vpad(24),
                  ...arg.map<Widget>(
                    (e) {
                      return PrimaryCard(
                        onTap: () {
                          Navigator.pushNamed(
                              context, NewDetailsScreen.routeName,
                              arguments: e);
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
                            ListTile(
                                horizontalTitleGap: 12,
                                minVerticalPadding: 12,
                                visualDensity:
                                    VisualDensity.adaptivePlatformDensity,
                                leading: Transform.translate(
                                  offset: const Offset(0, 6),
                                  child: ClipRRect(
                                    child: Image.network(
                                      "${ApiConstants.uploadURL}?load=${e.image}",
                                      fit: BoxFit.cover,
                                      width: 100,
                                      height: 120,
                                    ),
                                  ),
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(e.title ?? '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Text(e.content ?? "",
                                          maxLines: 1,
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                    Text(Utils.dateFormat(e.date ?? "", 1),
                                        maxLines: 1,
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis),
                                  ],
                                ),
                                trailing: hpad(0)),
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
