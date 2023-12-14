import 'package:app_cudan/models/linking_service.dart';
import 'package:app_cudan/services/api_linkingservice.dart';
import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class DisplayServicePrv extends ChangeNotifier {
  DisplayServicePrv({required this.context}) {
    getLinkingService(context);
  }
  List<LinkingService> linkingList = [];
  List<Industry> industryList = [];
  BuildContext context;
  bool showFilterSpec = false;
  bool loading = false;

  Future getLinkingService(BuildContext context) async {
    loading = true;
    notifyListeners();
    await APILinkingService.getLinkingServiceList().then((v) {
      if (v != null) {
        linkingList.clear();
        industryList.clear();
        for (var i in v['services']) {
          var service = LinkingService.fromMap(i);
          linkingList.add(service);
        }
        for (var i in v['spec']) {
          var spec = Industry.fromMap(i);
          industryList.add(spec);
        }
      }
      loading = false;
      notifyListeners();
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
      loading = false;
      notifyListeners();
    });
  }

  toggleShowFilter() {
    showFilterSpec = !showFilterSpec;
    notifyListeners();
  }
}
