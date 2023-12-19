import 'package:app_cudan/generated/l10n.dart';
import 'package:app_cudan/screens/payment/widget/payment_item.dart';
import 'package:app_cudan/widgets/primary_image_netword.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/constants.dart';
import '../../models/linking_service.dart';
import '../../services/api_service.dart';
import '../../widgets/primary_appbar.dart';
import '../../widgets/primary_screen.dart';
import '../../widgets/primary_text_field.dart';

class DetailsProductScreen extends StatefulWidget {
  const DetailsProductScreen({super.key});
  static const routeName = '/linking-service/product';

  @override
  State<DetailsProductScreen> createState() => _DetailsProductScreenState();
}

class _DetailsProductScreenState extends State<DetailsProductScreen> {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var arg = ModalRoute.of(context)!.settings.arguments as Map;
    var service = arg['linking-service'] as LinkingService;
    var product = arg['product'] as Product;
    return PrimaryScreen(
      appBar: PrimaryAppbar(
        titleWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
          child: PrimaryTextField(
            controller: searchController,
            hint: S.of(context).search_product,
            border: Border.all(color: grayScaleColorBase),
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          vpad(12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipOval(
                child: Hero(
                  tag: service.id ?? '',
                  child: CachedNetworkImage(
                    errorWidget: (_, __, ___) => Icon(
                      Icons.broken_image,
                      color: Colors.black45,
                    ),
                    placeholder: (context, url) {
                      return Center(
                        child: Icon(
                          Icons.image,
                          color: grayScaleColor1.withOpacity(0.6),
                          size: 30,
                        ),
                      );
                    },
                    imageUrl:
                        '${ApiService.shared.uploadURL}/?load=${service.image}&regcode=${ApiService.shared.regCode}',
                    width: 130,
                    height: 130,
                    // canShowPhotoView: false,
                    // path:
                    //     '${ApiService.shared.uploadURL}/?load=${service.image}&regcode=${ApiService.shared.regCode}',
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
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
                        '${service.time_start ?? ''} - ${service.time_end ?? ''}',
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
            ],
          ),
          vpad(16),
          PrimaryImageNetwork(
            width: dvWidth(context) - 24,
            path:
                '${ApiService.shared.uploadURL}/?load=${service.image}&regcode=${ApiService.shared.regCode}',
          ),
          vpad(12),
          Text(product.name ?? '', style: txtSemiBold(16)),
          vpad(12),
          Text(
            formatCurrency.format(product.listed_price ?? 0),
            style: txtRegular(14, redColorBase),
          ),
          vpad(12),
          Row(
            children: [
              Text("Mã giảm giá: HT01"),
              Spacer(),
              InkWell(
                onTap: () {
                  launchUrl(Uri.parse(product.link ?? ''));
                },
                child: Text(
                  "Truy cập",
                  style: txtRegular(12, primaryColorBase),
                ),
              ),
            ],
          ),
          Divider(),
          Text("Mô tả sản phẩm", style: txtBold(14)),
          vpad(12),
          Text(product.describe ?? "", style: txtRegular(12)),
        ],
      ),
    );
  }
}
