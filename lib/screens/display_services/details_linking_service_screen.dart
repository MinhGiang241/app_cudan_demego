import 'dart:math';

import 'package:app_cudan/models/linking_service.dart';
import 'package:app_cudan/screens/display_services/prv/linking_service_details_prv.dart';
import 'package:app_cudan/screens/display_services/tabs/product_tab.dart';
import 'package:app_cudan/screens/display_services/tabs/shop_info_tab.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_card.dart';
import 'package:app_cudan/widgets/primary_image_netword.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../../services/api_linkingservice.dart';
import '../../services/api_service.dart';
import '../../widgets/primary_text_field.dart';

class DetailsLinkingServiceScreen extends StatefulWidget {
  const DetailsLinkingServiceScreen({super.key});
  static const routeName = '/linking-service/detail';

  @override
  State<DetailsLinkingServiceScreen> createState() =>
      _DetailsLinkingServiceScreenState();
}

class _DetailsLinkingServiceScreenState
    extends State<DetailsLinkingServiceScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int tabIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: tabIndex,
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    var arg = ModalRoute.of(context)!.settings.arguments as Map;
    var service = arg['linking-service'] as LinkingService;
    return ChangeNotifierProvider(
      create: (_) => LinkingServiceDetailsPrv(service: service),
      builder: (context, builder) {
        var searchController =
            context.read<LinkingServiceDetailsPrv>().searchController;
        return PrimaryScreen(
          appBar: PrimaryAppbar(
            titleWidget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
              child: PrimaryTextField(
                textInputAction: TextInputAction.go,
                onFieldSubmitted: (_) {
                  context
                      .read<LinkingServiceDetailsPrv>()
                      .getProductListInShop(context, true);
                },
                controller: searchController,
                hint: S.of(context).search_product,
                border: Border.all(color: grayScaleColorBase),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    context
                        .read<LinkingServiceDetailsPrv>()
                        .getProductListInShop(context, true);
                  },
                ),
              ),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                vpad(12),
                PrimaryCard(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Stack(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipOval(
                            child: PrimaryImageNetwork(
                              canShowPhotoView: true,
                              width: 130,
                              height: 130,
                              path:
                                  '${ApiService.shared.uploadURL}/?load=${service.image}&regcode=${ApiService.shared.regCode}',
                            ),
                            // Hero(
                            //   tag: service.id ?? '',
                            //   child: CachedNetworkImage(
                            //     errorWidget: (_, __, ___) => Icon(
                            //       Icons.broken_image,
                            //       color: Colors.black45,
                            //     ),
                            //     placeholder: (context, url) {
                            //       return Center(
                            //         child: Icon(
                            //           Icons.image,
                            //           color: grayScaleColor1.withOpacity(0.6),
                            //           size: 30,
                            //         ),
                            //       );
                            //     },
                            //     imageUrl:
                            //         '${ApiService.shared.uploadURL}/?load=${service.image}&regcode=${ApiService.shared.regCode}',
                            //     width: 130,
                            //     height: 130,
                            //     // canShowPhotoView: false,
                            //     // path:
                            //     //     '${ApiService.shared.uploadURL}/?load=${service.image}&regcode=${ApiService.shared.regCode}',
                            //     fit: BoxFit.cover,
                            //     alignment: Alignment.topCenter,
                            //   ),
                            // ),
                          ),
                          hpad(14),
                          Expanded(
                            child: Container(
                              height: 130,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  AutoSizeText(
                                    service.name ?? '',
                                    style: txtBold(
                                      16,
                                      primaryColorBase,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  AutoSizeText(
                                    service.address ?? '',
                                    style: txtRegular(
                                      14,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  AutoSizeText(
                                    '${(service.time_start ?? '     ').substring(0, 5)} - ${(service.time_end ?? '     ').substring(0, 5)}',
                                    style: txtRegular(
                                      14,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  AutoSizeText(
                                    service.i?.name ?? '',
                                    style: txtRegular(
                                      14,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          hpad(30),
                        ],
                      ),
                      Positioned(
                        right: 5,
                        child: IconButton(
                          onPressed: () {
                            APILinkingService.countHit(
                              service.id,
                            );
                            launchUrl(Uri.parse(service.link ?? ""));
                          },
                          icon: Transform.rotate(
                            angle: -pi / 4,
                            child: Icon(
                              Icons.send_outlined,
                              color: primaryColorBase,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                vpad(20),
                TabBar(
                  controller: tabController,
                  tabs: [
                    Tab(text: S.of(context).shop),
                    Tab(text: S.of(context).product),
                  ],
                  unselectedLabelColor: grayScaleColor2,
                  unselectedLabelStyle: txtRegular(),
                  labelColor: grayScaleColor1,
                  labelStyle: txtLinkSmall(),
                  indicatorColor: primaryColor1,
                  indicatorWeight: 4,
                  isScrollable: false,
                  onTap: (int index) {
                    setState(() {
                      tabIndex = index;
                      tabController.animateTo(index);
                    });
                  },
                ),
                Expanded(
                  child: IndexedStack(
                    children: [
                      Visibility(
                        visible: tabIndex == 0,
                        maintainState: true,
                        child: ShopInfoTab(),
                      ),
                      Visibility(
                        visible: tabIndex == 1,
                        maintainState: true,
                        child: ProductTab(),
                      ),
                    ],
                    index: tabIndex,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
