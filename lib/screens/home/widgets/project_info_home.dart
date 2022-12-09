import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/api_constant.dart';
import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/response_bantinduan_list.dart';
import '../../../utils/convert_date_time.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_card.dart';
import '../../../widgets/primary_image_netword.dart';
import '../../../widgets/primary_loading.dart';
import '../../news/new_details_screen.dart';
import '../../news/news_screen.dart';
import '../prv/home_prv.dart';
import 'home_title_widget.dart';

class ProjectInfoHome extends StatelessWidget {
  const ProjectInfoHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var list = context.watch<HomePrv>().newProjectList;

    if (context.watch<HomePrv>().isProNewsLoading) {
      return const Center(child: PrimaryLoading());
    } else if (list.isEmpty) {
      return vpad(0);
    }

    return HomeTitleWidget(
      title: S.of(context).news,
      onTapShowAll: () {
        Navigator.pushNamed(context, NewListScreen.routeName,
            arguments: "PROJECT");
        // Utils.pushScreen(context, const ListProjectInfoScreen());
      },
      child: SizedBox(
        height: 200 + 27,
        child: ListView.builder(
            itemCount: list.length,
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => RepaintBoundary(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: PrimaryCard(
                        width: 256 + 32,
                        onTap: () async {
                          Navigator.pushNamed(
                              context, NewDetailsScreen.routeName,
                              arguments: list[index]);
                          // await context
                          //     .read<HomePrv>()
                          //     .toBTDADetails(context, list[index], index);
                          // Utils.pushScreen(
                          //     context, const DetailsProjectScreen());
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  list[index].title != null
                                      ? list[index].title!
                                      : "",
                                  style: txtLinkSmall(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                              vpad(8),
                              SizedBox(
                                width: 256,
                                height: 120,
                                child: PrimaryImageNetwork(
                                    canShowPhotoView: false,
                                    path:
                                        "${ApiConstants.uploadURL}?load=${list[index].image}"),
                              ),
                              vpad(8),
                              Text(
                                  list[index].content != null
                                      ? list[index].content!
                                      : "",
                                  style: txtBodySmallRegular(
                                      color: grayScaleColorBase),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                              vpad(8),
                              Text(
                                Utils.dateFormat(
                                    list[index].createdTime ?? "", 1),
                                style: txtBodySmallRegular(
                                    color: grayScaleColorBase),
                                maxLines: 1,
                              )
                            ],
                          ),
                        )),
                  ),
                )),
      ),
    );
  }
}
