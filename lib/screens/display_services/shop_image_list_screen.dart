import 'package:app_cudan/widgets/custom_footer_refresh.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_empty_widget.dart';
import 'package:app_cudan/widgets/primary_icon.dart';
import 'package:app_cudan/widgets/primary_loading.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../constants/regex_text.dart';
import '../../generated/l10n.dart';
import '../../models/linking_service.dart';
import '../../services/api_service.dart';
import '../../widgets/primary_image_netword.dart';
import 'prv/image_list_prv.dart';

class ShopImageListScreen extends StatelessWidget {
  const ShopImageListScreen({super.key});
  static const routeName = '/linkingservice-image';

  @override
  Widget build(BuildContext context) {
    var arg = ModalRoute.of(context)!.settings.arguments as Map;
    var service = arg['service'] as LinkingService;
    var controller = RefreshController(initialRefresh: true);
    return ChangeNotifierProvider(
      create: (_) => ImageListPrv(service: service),
      builder: (context, builder) {
        var images = context.watch<ImageListPrv>().images;
        var loading = context.watch<ImageListPrv>().loading;
        return PrimaryScreen(
          appBar: PrimaryAppbar(
            title: S.of(context).shop_pro_images,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: SmartRefresher(
                footer: customFooter(),
                enablePullDown: true,
                enablePullUp: true,
                header: WaterDropMaterialHeader(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                onLoading: () {
                  context
                      .read<ImageListPrv>()
                      .getImageListinShop(context, false);
                  controller.loadComplete();
                },
                onRefresh: () {
                  context
                      .read<ImageListPrv>()
                      .getImageListinShop(context, true);
                  controller.refreshCompleted();
                },
                controller: controller,
                child: loading
                    ? Center(
                        child: PrimaryLoading(),
                      )
                    : images.isEmpty
                        ? PrimaryEmptyWidget(
                            icons: PrimaryIcons.image,
                            emptyText: S.of(context).not_have_image,
                          )
                        : GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 3,
                            mainAxisSpacing: 18,
                            crossAxisSpacing: 15,
                            childAspectRatio: 1,
                            children: [
                              ...images.map(
                                (c) => PrimaryImageNetwork(
                                  canShowPhotoView: true,
                                  path: RegexText.isUrl(c.photo ?? '')
                                      ? c.photo
                                      : '${ApiService.shared.uploadURL}/?load=${c.photo}&regcode=${ApiService.shared.regCode}',
                                ),
                              ),
                            ],
                          ),
              ),
            ),
          ),
        );
      },
    );
  }
}
