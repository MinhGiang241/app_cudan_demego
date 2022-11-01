import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/response_news_list_model.dart';
import '../../../widgets/primary_card.dart';
import '../../../widgets/primary_image_netword.dart';
import '../../../widgets/primary_loading.dart';
import '../prv/home_prv.dart';

var listExamples = [
  NewsListItems(
    anhBia: AnhBia(
      paths: [
        'https://unsplash.it/120/256',
        'https://unsplash.it/120/256',
      ],
      urls: [
        'https://unsplash.it/120/256',
        'https://unsplash.it/120/256',
      ],
    ),
    author: "Giang",
    contentItemId: "1",
    contentType: "type",
    createdUtc: 'createUtc',
    danhMuc: DanhMuc(
      taxonomyContentItemId: "dm1",
      termContentItemIds: ['tm1'],
    ),
    list: UsersLike(
      contentItems: [
        ContentItems(
          contentItemId: 'ct1',
          owner: 'Giang',
        ),
      ],
    ),
    noiDung: "Đây là nội dung",
    owner: 'Giang',
    privateBanTin: PrivateBanTin(
      soLuongComment: 11,
      soLuongLike: 23,
    ),
    privateCreator: PrivateCreator(
      anhDaiDien: AnhDaiDien(
        paths: [
          'https://unsplash.it/120/256',
          'https://unsplash.it/120/256',
        ],
        urls: [
          'https://unsplash.it/120/256',
          'https://unsplash.it/120/256',
        ],
      ),
      creatorId: 'cr1',
      fullName: "Trương Minh Giang",
    ),
    publishedUtc: "publicUtc",
    tieuDe: "Tiêu đề",
  ),
  NewsListItems(
    anhBia: AnhBia(
      paths: [
        'https://unsplash.it/120/256',
        'https://unsplash.it/120/256',
      ],
      urls: [
        'https://unsplash.it/120/256',
        'https://unsplash.it/120/256',
      ],
    ),
    author: "Giang",
    contentItemId: "2",
    contentType: "type",
    createdUtc: 'createUtc',
    danhMuc: DanhMuc(
      taxonomyContentItemId: "dm2",
      termContentItemIds: ['tm2'],
    ),
    list: UsersLike(
      contentItems: [
        ContentItems(
          contentItemId: 'ct2',
          owner: 'Giang',
        ),
      ],
    ),
    noiDung: "Đây là nội dung",
    owner: 'Giang',
    privateBanTin: PrivateBanTin(
      soLuongComment: 11,
      soLuongLike: 23,
    ),
    privateCreator: PrivateCreator(
      anhDaiDien: AnhDaiDien(
        paths: [
          'https://unsplash.it/120/256',
          'https://unsplash.it/120/256',
        ],
        urls: [
          'https://unsplash.it/120/256',
          'https://unsplash.it/120/256',
        ],
      ),
      creatorId: 'cr2',
      fullName: "Trương Minh Giang",
    ),
    publishedUtc: "publicUtc",
    tieuDe: "Tiêu đề",
  ),
];

class NewsHome extends StatelessWidget {
  const NewsHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = context.watch<HomePrv>().newsList;
    if (listExamples == null) {
      return const Center(child: PrimaryLoading());
    } else if (listExamples.isEmpty) {
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
                // Utils.pushScreen(context, const ListNewsScreen());
              },
              child: Text(S.of(context).all,
                  style: txtLinkSmall(color: grayScaleColor2)
                      .copyWith(decoration: TextDecoration.underline)),
            ),
          ],
        ),
        vpad(16),
        SizedBox(
          height: 230,
          child: ListView.builder(
            itemCount: listExamples.length,
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => RepaintBoundary(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: PrimaryCard(
                  width: 256 + 32,
                  margin: const EdgeInsets.only(left: 12),
                  onTap: () async {
                    await context
                        .read<HomePrv>()
                        .toNewsDetails(context, listExamples[index], index);
                    // Utils.pushScreen(context, const DetailsNewsScreen());
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: dvHeight(context) / 4.3,
                        width: double.infinity,
                        child: PrimaryImageNetwork(
                          canShowPhotoView: false,
                          path: listExamples[index].anhBia?.paths?[0],
                        ),
                      ),
                      vpad(6),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(listExamples[index].tieuDe ?? "",
                              style: txtLinkSmall(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis)),
                      vpad(6),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(listExamples[index].noiDung ?? "",
                              style: txtBodySmallRegular(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis)),
                      vpad(6),
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
