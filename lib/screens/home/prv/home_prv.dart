import '../../../models/response_bantinduan_list.dart' as btda;
import '../../../models/response_news_list_model.dart';
import '../../../models/response_news_list_model.dart' as newlist;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../models/response_bantinduan_list.dart';
import '../../../models/response_news_list_model.dart';
import '../../../services/api_tower.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_dialog.dart';
import '../../auth/prv/auth_prv.dart';

class HomePrv extends ChangeNotifier {
  List<NewsListItems>? newsList;
  List<BTDAItems>? btdaList;
  bool isLoading = false;
  late BuildContext context;

  HomePrv(ctx) {
    context = ctx;
    _initial();
  }

  Future _initial() async {
    await APITower.getBanTinDuAn(pageSize: 3, currentPage: 1, context: context)
        .then((value) {
      if (value.status == null) {
        btdaList = value.getBanTinDuAn?.items;
        notifyListeners();
      }
    });
    await APITower.getNewsList(pageSize: 3, currentPage: 1, context: context)
        .then((value) {
      if (value.status == null) {
        newsList = value.getAllBanTin?.items;
        notifyListeners();
      }
    });
  }

  likeNews(BuildContext context, int index) async {
    final userId = context.read<AuthPrv>().userInfo!.userId!;
    if (!newsList![index]
        .list!
        .contentItems!
        .any((element) => element.owner == userId)) {
      APITower.likeBanTin(
              idBanTin: newsList![index].contentItemId!,
              idUser: userId,
              context: context)
          .then((value) {
        if (kDebugMode) {
          print("like");
        }
        newsList![index].list!.contentItems!.add(newlist.ContentItems(
            owner: userId, contentItemId: value.contentItemId));
        notifyListeners();
      });
    } else {
      String id = newsList![index]
              .list
              ?.contentItems
              ?.firstWhere((element) => element.owner == userId)
              .contentItemId ??
          "";

      APITower.unlikeBantin(id: id, context: context).then((value) {
        if (kDebugMode) {
          print("unlike");
        }
        newsList![index]
            .list!
            .contentItems!
            .removeWhere((element) => element.owner == userId);
      });
      notifyListeners();
    }
  }

  likeBTDA(BuildContext context, int index) async {
    final userId = context.read<AuthPrv>().userInfo!.userId!;
    if (!btdaList![index]
        .list!
        .contentItems!
        .any((element) => element.owner == userId)) {
      APITower.likeBanTin(
              idBanTin: btdaList![index].contentItemId!,
              idUser: userId,
              context: context)
          .then((value) {
        if (kDebugMode) {
          print("like");
        }
        btdaList![index].list!.contentItems!.add(btda.ContentItems(
            owner: userId, contentItemId: value.contentItemId));
        notifyListeners();
      });
    } else {
      String id = btdaList![index]
              .list
              ?.contentItems
              ?.firstWhere((element) => element.owner == userId)
              .contentItemId ??
          "";

      APITower.unlikeBantin(id: id, context: context).then((value) {
        if (kDebugMode) {
          print("unlike");
        }
        btdaList![index]
            .list!
            .contentItems!
            .removeWhere((element) => element.owner == userId);
      });
      notifyListeners();
    }
  }

  toNewsDetails(
      BuildContext context, NewsListItems newsListItems, int index) async {
    isLoading = true;
    notifyListeners();
    await APITower.getDanhMucBanTin(alias: "danh-muc-ban-tin", context: context)
        .then((danhmuc) async {
      isLoading = false;
      notifyListeners();
      if (danhmuc.status == null) {
        await APITower.getNewsDetails(
          context,
          newsListItems.contentItemId!,
        ).then((value) {
          final likeNum = double.parse(
                  (value.privateBanTinPart?.soLuongLike?.value ?? 0).toString())
              .round();
          final commentNum = double.parse(
                  (value.privateBanTinPart?.soLuongComment?.value ?? 0)
                      .toString())
              .round();

          newsList
              ?.firstWhere((element) =>
                  element.contentItemId == newsListItems.contentItemId)
              .privateBanTin
              ?.soLuongLike = likeNum;
          newsList
              ?.firstWhere((element) =>
                  element.contentItemId == newsListItems.contentItemId)
              .privateBanTin
              ?.soLuongComment = commentNum;

          if (value.status == null) {
            // Utils.pushScreen(
            //     context,
            //     DetailsNewsScreen(
            //       details: value,
            //       items: newsListItems,
            //       likeUpdate: () async {
            //         await likeNews(context, index);
            //       },
            //       danhMucItems: danhmuc.getTaxonomyByAlias?.items?[0].taxonomy
            //               ?.contentItems ??
            //           [],
            //     ));
          } else {
            if (value.status == 'internet_error') {
              Utils.showDialog(
                  context: context,
                  dialog:
                      PrimaryDialog.error(msg: 'S.of(context).network_error'));
            } else {
              Utils.showDialog(
                  context: context,
                  dialog: PrimaryDialog.error(
                      msg: S.of(context).err_x(value.message ?? "")));
            }
          }
        });
      } else {
        if (danhmuc.status == 'internet_error') {
          Utils.showDialog(
              context: context,
              dialog: PrimaryDialog.error(msg: ' S.of(context).network_error'));
        } else {
          Utils.showDialog(
              context: context,
              dialog: PrimaryDialog.error(
                  msg: S.of(context).err_x(danhmuc.message ?? "")));
        }
      }
    });
  }

  toBTDADetails(BuildContext context, BTDAItems btdaItems, int index) async {
    isLoading = true;
    notifyListeners();
    await APITower.getDanhMucBanTin(alias: "danh-muc-du-an", context: context)
        .then((danhmuc) async {
      isLoading = false;
      notifyListeners();
      if (danhmuc.status == null) {
        await APITower.getBTDADetails(btdaItems.contentItemId!, context)
            .then((value) {
          final likeNum = double.parse(
                  (value.privateBanTinPart?.soLuongLike?.value ?? 0).toString())
              .round();
          final commentNum = double.parse(
                  (value.privateBanTinPart?.soLuongComment?.value ?? 0)
                      .toString())
              .round();

          btdaList
              ?.firstWhere(
                  (element) => element.contentItemId == btdaItems.contentItemId)
              .privateBanTin
              ?.soLuongLike = likeNum;
          btdaList
              ?.firstWhere(
                  (element) => element.contentItemId == btdaItems.contentItemId)
              .privateBanTin
              ?.soLuongComment = commentNum;

          if (value.status == null) {
            // Utils.pushScreen(
            //     context,
            //     DetailsProjectScreen(
            //       details: value,
            //       items: btdaItems,
            //       likeUpdate: () async {
            //         await likeBTDA(context, index);
            //       },
            //       danhMucItems: danhmuc.getTaxonomyByAlias?.items?[0].taxonomy
            //               ?.contentItems ??
            //           [],
            //     ));
          } else {
            if (value.status == 'internet_error') {
              Utils.showDialog(
                  context: context,
                  dialog:
                      PrimaryDialog.error(msg: 'S.of(context).network_error'));
            } else {
              Utils.showDialog(
                  context: context,
                  dialog: PrimaryDialog.error(
                      msg: S.of(context).err_x(value.message ?? "")));
            }
          }
        });
      } else {
        if (danhmuc.status == 'internet_error') {
          Utils.showDialog(
              context: context,
              dialog: PrimaryDialog.error(msg: 'S.of(context).network_error'));
        } else {
          Utils.showDialog(
              context: context,
              dialog: PrimaryDialog.error(
                  msg: S.of(context).err_x(danhmuc.message ?? "")));
        }
      }
    });
  }
}
