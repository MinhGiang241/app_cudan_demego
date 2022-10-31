import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/response_bantinduan_list.dart';
import '../../../widgets/primary_card.dart';
import '../../../widgets/primary_image_netword.dart';
import '../prv/home_prv.dart';
import 'home_title_widget.dart';

class ProjectInfoHome extends StatelessWidget {
  const ProjectInfoHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var listExamples = [
      BTDAItems(
        tieuDe: "Tiêu đề",
        publishedUtc: "sjsjj",
        contentItemId: '1',
        contentType: "Hello",
        createdUtc: "jj",
        danhMuc: DanhMuc(
            taxonomyContentItemId: 'd1',
            termContentItemIds: ['dsldkas', 'asdasdas']),
        displayText: "Display",
        hinhAnh: HinhAnh(paths: [
          'https://unsplash.it/120/256',
          'https://unsplash.it/120/256'
        ], urls: [
          'https://unsplash.it/120/256',
          'https://unsplash.it/120/256'
        ]),
        list: UsersLike(
            contentItems: [ContentItems(contentItemId: "ct1", owner: "Giang")]),
        noiDung: "dây là nội dung",
        owner: "MINHGIANG",
        privateBanTin: PrivateBanTin(soLuongComment: 12, soLuongLike: 11),
        privateCreator: PrivateCreator(
            anhDaiDien: AnhDaiDien(
              paths: [
                'https://unsplash.it/120/256',
                'https://unsplash.it/120/256'
              ],
              urls: [
                'https://unsplash.it/120/256',
                'https://unsplash.it/120/256'
              ],
            ),
            creatorId: "cra1",
            fullName: "tmg"),
      ),
      BTDAItems(
        tieuDe: "Tiêu đề",
        publishedUtc: "sjsjj",
        contentItemId: '1',
        contentType: "Hello",
        createdUtc: "jj",
        danhMuc: DanhMuc(
            taxonomyContentItemId: 'd1',
            termContentItemIds: ['dsldkas', 'asdasdas']),
        displayText: "Display",
        hinhAnh: HinhAnh(paths: [
          'https://unsplash.it/120/256',
          'https://unsplash.it/120/256'
        ], urls: [
          'https://unsplash.it/120/256',
          'https://unsplash.it/120/256'
        ]),
        list: UsersLike(
            contentItems: [ContentItems(contentItemId: "ct1", owner: "Giang")]),
        noiDung: "dây là nội dung",
        owner: "MINHGIANG",
        privateBanTin: PrivateBanTin(soLuongComment: 12, soLuongLike: 11),
        privateCreator: PrivateCreator(
            anhDaiDien: AnhDaiDien(
              paths: [
                'https://unsplash.it/120/256',
                'https://unsplash.it/120/256'
              ],
              urls: [
                'https://unsplash.it/120/256',
                'https://unsplash.it/120/256'
              ],
            ),
            creatorId: "cra1",
            fullName: "tmg"),
      ),
    ];

    final list = context.watch<HomePrv>().btdaList;
    // if (list == null) {
    //   return const Center(child: PrimaryLoading());
    // } else if (list.isEmpty) {
    //   return vpad(0);
    // }

    return HomeTitleWidget(
      title: S.of(context).news,
      onTapShowAll: () {
        // Utils.pushScreen(context, const ListProjectInfoScreen());
      },
      child: SizedBox(
        height: 200,
        child: ListView.builder(
            itemCount: listExamples.length,
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => RepaintBoundary(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: PrimaryCard(
                        width: 256 + 32,
                        onTap: () async {
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
                              Text(listExamples[index].tieuDe ?? "",
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
                                        listExamples[index].hinhAnh?.paths?[0]),
                              ),
                              vpad(8),
                              Text(listExamples[index].noiDung ?? "",
                                  style: txtBodySmallRegular(
                                      color: grayScaleColorBase),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis)
                            ],
                          ),
                        )),
                  ),
                )),
      ),
    );
  }
}
