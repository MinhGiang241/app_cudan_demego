import 'package:flutter/widgets.dart';

import '../../../models/linking_service.dart';
import '../../../services/api_linkingservice.dart';
import '../../../utils/utils.dart';

class ImageListPrv extends ChangeNotifier {
  ImageListPrv({required this.service});
  LinkingService service;
  var loading = false;
  List<PhotosLSP> images = [];
  int skip = 0;
  int limit = 20;

  Future getImageListinShop(BuildContext context, bool isInit) async {
    if (isInit) {
      loading = true;
      skip = 0;
      notifyListeners();
    } else {
      skip += limit;
    }
    await APILinkingService.getImageListInShop(service.id, skip, limit)
        .then((v) {
      if (isInit) {
        images.clear();
      }
      if (v != null) {
        for (var i in v) {
          images.add(PhotosLSP.fromMap(i));
        }
      }
      loading = false;
      notifyListeners();
    }).catchError((e) {
      loading = false;
      notifyListeners();
      Utils.showErrorMessage(context, e);
    });
  }
}
