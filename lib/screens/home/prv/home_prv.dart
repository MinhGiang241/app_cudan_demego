import 'package:app_cudan/services/api_new.dart';

import '../../../models/new.dart';
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
  bool isNewLoading = false;
  late BuildContext context;
  List<New> newList = [];

  HomePrv(ctx) {
    context = ctx;
    _initial();
  }

  Future _initial() async {
    // isLoading = true;
    // notifyListeners();
    var filter = {
      "skip": 0,
      "limit": 10,
    };
    isNewLoading = true;
    notifyListeners();
    await APINew.getNewList(filter).then((v) {
      isNewLoading = false;
      notifyListeners();
      newList.clear();
      for (var i in v) {
        newList.add(New.fromJson(i));
      }
    }).catchError((e) {
      isNewLoading = false;
      notifyListeners();
      Utils.showErrorMessage(context, e);
    });
  }
}
