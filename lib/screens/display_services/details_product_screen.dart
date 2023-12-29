import 'dart:math';

import 'package:app_cudan/generated/l10n.dart';
import 'package:app_cudan/screens/payment/widget/payment_item.dart';
import 'package:app_cudan/widgets/primary_image_netword.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/constants.dart';
import '../../constants/regex_text.dart';
import '../../models/linking_service.dart';
import '../../services/api_linkingservice.dart';
import '../../services/api_service.dart';
import '../../widgets/primary_appbar.dart';
import '../../widgets/primary_screen.dart';
import '../../widgets/primary_text_field.dart';
import 'shop_image_list_screen.dart';

class DetailsProductScreen extends StatefulWidget {
  const DetailsProductScreen({super.key});
  static const routeName = '/linking-service/product';

  @override
  State<DetailsProductScreen> createState() => _DetailsProductScreenState();
}

class _DetailsProductScreenState extends State<DetailsProductScreen> {
  var searchController = TextEditingController();
  var isExpanded = false;
  @override
  Widget build(BuildContext context) {
    var arg = ModalRoute.of(context)!.settings.arguments as Map;
    var service = arg['linking-service'] as LinkingService;
    var product = arg['product'] as LSProduct;
    return PrimaryScreen(
      appBar: PrimaryAppbar(
        title: S.of(context).product,
        // titleWidget: Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
        //   child: PrimaryTextField(
        //     controller: searchController,
        //     hint: S.of(context).search_product,
        //     border: Border.all(color: grayScaleColorBase),
        //     suffixIcon: IconButton(
        //       icon: Icon(Icons.search),
        //       onPressed: () {},
        //     ),
        //   ),
        // ),
      ),
      body: ListView(
        children: <Widget>[
          vpad(12),
          Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipOval(
                    child: PrimaryImageNetwork(
                      width: 130,
                      height: 130,
                      canShowPhotoView: true,
                      path:
                          '${ApiService.shared.uploadURL}/?load=${service.image}&regcode=${ApiService.shared.regCode}',
                    ),
                  ),
                  hpad(14),
                  Expanded(
                    child: Container(
                      height: 130,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
          vpad(16),
          PrimaryImageNetwork(
            width: dvWidth(context) - 24,
            path:
                '${ApiService.shared.uploadURL}/?load=${product.image}&regcode=${ApiService.shared.regCode}',
          ),
          vpad(12),
          Row(
            children: [
              AutoSizeText(product.name ?? '', style: txtSemiBold(16)),
              Spacer(),
              InkWell(
                onTap: () {
                  APILinkingService.countHit(
                    service.id,
                  );
                  launchUrl(Uri.parse(product.link ?? ''));
                },
                child: Text(
                  "Truy cập",
                  style: txtRegular(12, primaryColorBase),
                ),
              ),
            ],
          ),
          vpad(12),
          if (product.price != null)
            AutoSizeText(
              formatCurrency.format(product.price ?? 0),
              //.replaceAll("₫", "VND"),
              style: txtSemiBold(
                14,
                redColorBase,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          vpad(12),
          if (product.old_price != null)
            AutoSizeText(
              formatCurrency.format(product.old_price ?? 0),
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                fontFamily: family,
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                overflow: TextOverflow.ellipsis,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          Divider(),
          Text(S.of(context).pro_images, style: txtBold(14)),
          vpad(12),
          GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 3,
            mainAxisSpacing: 18,
            crossAxisSpacing: 15,
            childAspectRatio: 1.4,
            children: [
              ...(product.l == null
                      ? []
                      : (product.l!.length <= 6
                          ? product.l
                          : product.l!.sublist(0, 6)))!
                  .map(
                (c) => PrimaryImageNetwork(
                  canShowPhotoView: true,
                  path: RegexText.isUrl(c.photo ?? '')
                      ? c.photo
                      : '${ApiService.shared.uploadURL}/?load=${c.photo}&regcode=${ApiService.shared.regCode}',
                ),
              ),
            ],
          ),
          vpad(12),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  ShopImageListScreen.routeName,
                  arguments: {
                    'service': service,
                    'product': product,
                  },
                );
              },
              child: Text(
                S.of(context).more,
                style: txtRegular(14, primaryColorBase),
              ),
            ),
          ),
          vpad(12),
          Divider(),
          Text(S.of(context).pro_des, style: txtBold(14)),
          vpad(12),
          ClipRect(
            child: Align(
              alignment: Alignment.topCenter,
              widthFactor: 1,
              heightFactor: isExpanded ? 1 : 0.1,
              child: HtmlWidget(
                '''${product.describe ?? ''}''',
                onTapUrl: (url) {
                  launchUrl(Uri.parse(url));
                  return false;
                },
                textStyle: txtBodyMediumRegular(),
                onTapImage: (ImageMetadata data) {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          PhotoViewer(
                        heroTag: 'hero',
                        link: data.sources.first.url,
                        listLink: [
                          data.sources.first.url,
                        ],
                        initIndex: 0,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  isExpanded ? S.of(context).less : S.of(context).more,
                  style: txtRegular(14, primaryColorBase),
                ),
              ),
            ),
          ),
          vpad(50),
        ],
      ),
    );
  }
}
