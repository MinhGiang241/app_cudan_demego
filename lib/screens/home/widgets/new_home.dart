import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/api_constant.dart';
import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/response_news_list_model.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_card.dart';
import '../../../widgets/primary_image_netword.dart';
import '../../../widgets/primary_loading.dart';
import '../../news/new_details_screen.dart';
import '../../news/news_screen.dart';
import '../prv/home_prv.dart';

class NewsHome extends StatelessWidget {
  const NewsHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newList = context.watch<HomePrv>().newResidentList;
    if (context.watch<HomePrv>().isResNewsLoading) {
      return const Center(child: PrimaryLoading());
    } else if (newList.isEmpty) {
      return vpad(0);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(S.of(context).residence_news,
                style: txtLinkSmall(color: grayScaleColor2)),
            const Spacer(),
            InkWell(
              borderRadius: BorderRadius.circular(5),
              onTap: () {
                Navigator.pushNamed(context, NewListScreen.routeName,
                    arguments: "RESIDENT");
              },
              child: Text(S.of(context).all,
                  style: txtLinkSmall(color: grayScaleColor2)
                      .copyWith(decoration: TextDecoration.underline)),
            ),
          ],
        ),
        vpad(16),
        SizedBox(
          height: 250,
          child: ListView.builder(
            itemCount: newList.length,
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => RepaintBoundary(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: PrimaryCard(
                  onTap: () {
                    Navigator.pushNamed(context, NewDetailsScreen.routeName,
                        arguments: newList[index]);
                  },
                  width: 256 + 32,
                  margin: const EdgeInsets.only(right: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: dvHeight(context) / 4.3,
                        width: double.infinity,
                        child: PrimaryImageNetwork(
                            canShowPhotoView: false,
                            path:
                                "${ApiConstants.uploadURL}?load=${newList[index].image ?? ""}"),
                      ),
                      vpad(3),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(newList[index].title ?? "",
                              style: txtLinkSmall(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis)),
                      vpad(3),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(newList[index].content ?? "",
                              style: txtBodySmallRegular(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis)),
                      vpad(3),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                              Utils.dateFormat(newList[index].date ?? "", 1),
                              style: txtBodySmallRegular(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        // ...List.generate(
        //   listExamples.length,
        //   (index) => RepaintBoundary(
        //     child: Padding(
        //       padding: const EdgeInsets.only(bottom: 16),
        //       child: PrimaryCard(
        //         onTap: () async {
        //           await context
        //               .read<HomePrv>()
        //               .toNewsDetails(context, listExamples[index], index);
        //           // Utils.pushScreen(context, const DetailsNewsScreen());
        //         },
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             SizedBox(
        //               height: dvHeight(context) / 4.3,
        //               width: double.infinity,
        //               child: PrimaryImageNetwork(
        //                 canShowPhotoView: false,
        //                 path: listExamples[index].anhBia?.paths?[0],
        //               ),
        //             ),
        //             vpad(6),
        //             Padding(
        //                 padding: const EdgeInsets.symmetric(horizontal: 12),
        //                 child: Text(listExamples[index].tieuDe ?? "",
        //                     style: txtLinkSmall(),
        //                     maxLines: 1,
        //                     overflow: TextOverflow.ellipsis)),
        //             vpad(6),
        //             Padding(
        //                 padding: const EdgeInsets.symmetric(horizontal: 12),
        //                 child: Text(listExamples[index].noiDung ?? "",
        //                     style: txtBodySmallRegular(),
        //                     maxLines: 1,
        //                     overflow: TextOverflow.ellipsis)),
        //             vpad(6),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
