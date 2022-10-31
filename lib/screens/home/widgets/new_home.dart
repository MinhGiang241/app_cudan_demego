import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../widgets/primary_card.dart';
import '../../../widgets/primary_image_netword.dart';
import '../../../widgets/primary_loading.dart';
import '../prv/home_prv.dart';

class NewsHome extends StatelessWidget {
  const NewsHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = context.watch<HomePrv>().newsList;
    if (list == null) {
      return const Center(child: PrimaryLoading());
    } else if (list.isEmpty) {
      return vpad(0);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(S.of(context).news,
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
        ...List.generate(
            list.length,
            (index) => RepaintBoundary(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: PrimaryCard(
                        onTap: () async {
                          await context
                              .read<HomePrv>()
                              .toNewsDetails(context, list[index], index);
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
                                path: list[index].anhBia?.paths?[0],
                              ),
                            ),
                            vpad(6),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(list[index].tieuDe ?? "",
                                    style: txtLinkSmall(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis)),
                            vpad(6),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(list[index].noiDung ?? "",
                                    style: txtBodySmallRegular(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis)),
                            vpad(6),
                          ],
                        )),
                  ),
                )),
      ],
    );
  }
}
