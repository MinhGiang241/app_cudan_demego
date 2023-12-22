import 'package:app_cudan/constants/regex_text.dart';
import 'package:app_cudan/screens/display_services/prv/linking_service_details_prv.dart';
import 'package:app_cudan/widgets/primary_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../services/api_service.dart';
import '../../../widgets/primary_card.dart';
import '../../../widgets/primary_image_netword.dart';
import '../shop_image_list_screen.dart';

class ShopInfoTab extends StatelessWidget {
  const ShopInfoTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var service = context.read<LinkingServiceDetailsPrv>().service;

    return ListView(
      children: [
        vpad(12),
        PrimaryCard(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).shop_intro,
                style: txtBold(14),
              ),
              vpad(12),
              HtmlWidget(
                '''${service.describe ?? ''}''',
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
            ],
          ),
        ),
        vpad(12),
        PrimaryCard(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).shop_pro_images,
                style: txtBold(14),
              ),
              vpad(20),
              FutureBuilder(
                future: context
                    .read<LinkingServiceDetailsPrv>()
                    .getImageListinShop(context, 0, 6),
                builder: (context, snapshot) {
                  var images = context.watch<LinkingServiceDetailsPrv>().images;
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: PrimaryLoading(),
                    );
                  }
                  return GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    mainAxisSpacing: 18,
                    crossAxisSpacing: 15,
                    childAspectRatio: 1.4,
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
                  );
                },
              ),
              vpad(6),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      ShopImageListScreen.routeName,
                      arguments: {
                        'service':
                            context.read<LinkingServiceDetailsPrv>().service,
                      },
                    );
                  },
                  child: Text(
                    S.of(context).more,
                    style: txtRegular(14, primaryColorBase),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
