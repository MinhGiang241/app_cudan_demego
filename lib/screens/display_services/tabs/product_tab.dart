import 'package:app_cudan/models/linking_service.dart';
import 'package:app_cudan/screens/display_services/details_product_screen.dart';
import 'package:app_cudan/screens/display_services/prv/linking_service_details_prv.dart';
import 'package:app_cudan/widgets/primary_empty_widget.dart';
import 'package:app_cudan/widgets/primary_icon.dart';
import 'package:app_cudan/widgets/primary_loading.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../services/api_service.dart';
import '../../../widgets/custom_footer_refresh.dart';
import '../../../widgets/primary_image_netword.dart';
import '../../payment/widget/payment_item.dart';

class ProductTab extends StatelessWidget {
  ProductTab({super.key});
  final RefreshController controller = RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    var products = context.watch<LinkingServiceDetailsPrv>().products;
    var service = context.read<LinkingServiceDetailsPrv>().service;
    var loading = context.watch<LinkingServiceDetailsPrv>().productLoad;
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: SmartRefresher(
        footer: customFooter(),
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropMaterialHeader(
          backgroundColor: Theme.of(context).primaryColor,
        ),
        onLoading: () {
          context
              .read<LinkingServiceDetailsPrv>()
              .getProductListInShop(context, false);
          controller.loadComplete();
        },
        onRefresh: () {
          context
              .read<LinkingServiceDetailsPrv>()
              .getProductListInShop(context, true);
          controller.refreshCompleted();
        },
        controller: controller,
        child: loading
            ? Center(
                child: PrimaryLoading(),
              )
            : products.isEmpty
                ? PrimaryEmptyWidget(
                    icons: PrimaryIcons.star,
                    emptyText: S.of(context).not_have_product,
                  )
                : GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 18,
                    crossAxisSpacing: 15,
                    childAspectRatio: 1,
                    children: [
                      ...(products).map(
                        (e) => InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              DetailsProductScreen.routeName,
                              arguments: {
                                'product': e,
                                'linking-service': service,
                              },
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1, color: grayScaleColor3),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PrimaryImageNetwork(
                                  canShowPhotoView: false,
                                  height:
                                      ((dvWidth(context) / 2) - 15 - 24) * 0.75,
                                  width: dvWidth(context) / 2,
                                  path:
                                      '${ApiService.shared.uploadURL}/?load=${e.image}&regcode=${ApiService.shared.regCode}',
                                ),
                                vpad(5),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: AutoSizeText(
                                    e.name ?? '',
                                    style: txtSemiBold(
                                      12,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: AutoSizeText(
                                    formatCurrency.format(e.price ?? 0),
                                    //.replaceAll("₫", "VND"),
                                    style: txtSemiBold(
                                      12,
                                      redColorBase,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                if (e.old_price != null)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: AutoSizeText(
                                      formatCurrency.format(e.old_price ?? 0),
                                      style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        fontFamily: family,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
