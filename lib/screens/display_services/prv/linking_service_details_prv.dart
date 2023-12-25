import 'package:app_cudan/models/linking_service.dart';
import 'package:app_cudan/services/api_linkingservice.dart';
import 'package:app_cudan/utils/utils.dart';
import 'package:flutter/material.dart';

class LinkingServiceDetailsPrv extends ChangeNotifier {
  LinkingServiceDetailsPrv({required this.service});
  LinkingService service;
  TextEditingController searchController = TextEditingController();
  var imageLoad = false;
  var productLoad = false;
  List<PhotosLSP> images = [];
  List<LSProduct> products = [];

  int skipPro = 0;
  int limitPro = 30;

  Future getImageListinShop(BuildContext context, int skip, int limit) async {
    await APILinkingService.getImageListInShop(service.id, null, skip, limit)
        .then((v) {
      images.clear();
      if (v != null) {
        for (var i in v) {
          images.add(PhotosLSP.fromMap(i));
        }
      }
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }

  Future getProductListInShop(BuildContext context, bool isInit) async {
    if (isInit) {
      skipPro = 0;
      productLoad = true;
      notifyListeners();
    } else {
      skipPro += limitPro;
    }

    await APILinkingService.getProductListInShop(
      service.id,
      skipPro,
      limitPro,
      searchController.text.trim(),
    ).then((v) {
      if (isInit) {
        productLoad = false;
        products.clear();
        notifyListeners();
      }

      if (v != null) {
        for (var i in v) {
          products.add(LSProduct.fromMap(i));
        }
      }
      notifyListeners();
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
      productLoad = false;
      notifyListeners();
    });
  }
}
