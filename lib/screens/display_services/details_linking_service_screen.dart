import 'package:app_cudan/models/linking_service.dart';
import 'package:app_cudan/screens/display_services/details_product_screen.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_image_netword.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../../services/api_service.dart';
import '../../widgets/primary_text_field.dart';
import '../payment/widget/payment_item.dart';

class DetailsLinkingServiceScreen extends StatefulWidget {
  const DetailsLinkingServiceScreen({super.key});
  static const routeName = '/linking-service/detail';

  @override
  State<DetailsLinkingServiceScreen> createState() =>
      _DetailsLinkingServiceScreenState();
}

class _DetailsLinkingServiceScreenState
    extends State<DetailsLinkingServiceScreen> {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var arg = ModalRoute.of(context)!.settings.arguments as Map;
    var service = arg['linking-service'] as LinkingService;
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
        children: [
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
          vpad(20),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            mainAxisSpacing: 18,
            crossAxisSpacing: 15,
            // childAspectRatio: 1,
            children: [
              ...(service.list_products ?? []).map(
                (e) => InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      DetailsProductScreen.routeName,
                      arguments: {'product': e, 'linking-service': service},
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: grayScaleColor3),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PrimaryImageNetwork(
                          canShowPhotoView: false,
                          height: 155,
                          width: dvWidth(context) / 2,
                          path:
                              '${ApiService.shared.uploadURL}/?load=${e.image?[0].id}&regcode=${ApiService.shared.regCode}',
                        ),
                        vpad(5),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: AutoSizeText(
                            e.name ?? '',
                            style: txtSemiBold(
                              14,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: AutoSizeText(
                            formatCurrency.format(e.listed_price ?? 0),
                            //.replaceAll("₫", "VND"),
                            style: txtSemiBold(
                              14,
                              redColorBase,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: AutoSizeText(
                            '',
                            style: txtRegular(
                              14,
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
        ],
      ),
    );
  }
}
