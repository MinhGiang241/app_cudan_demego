import 'package:app_cudan/models/linking_service.dart';
import 'package:app_cudan/services/api_linkingservice.dart';
import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class DisplayServicePrv extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  List<LinkingService> linkingList = [];
  List<Map<String, dynamic>> industryList = [];
  BuildContext context;
  bool showFilterSpec = false;
  bool loading = false;
  DisplayServicePrv({required this.context}) {
    getLinkingService(context, true);
  }

  Future getLinkingService(BuildContext context, bool isInit) async {
    loading = true;
    notifyListeners();
    var industryListString = industryList
        .where((el) => el['isSelected'])
        .map<String>((e) => 'ObjectId("${e['spec']?.id}")')
        .join(',');
    await APILinkingService.getLinkingServiceList(
      searchController.text.trim(),
      industryListString,
    ).then((v) {
      if (v != null) {
        linkingList.clear();
        if (isInit) {
          industryList.clear();
          for (var i in v['spec']) {
            var spec = Industry.fromMap(i);
            industryList.add({'spec': spec, 'isSelected': false});
          }
        }
        //industryList.clear();
        for (var i in v['services']) {
          var service = LinkingService.fromMap(i);
          linkingList.add(service);
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

  toggleSelect(int index, BuildContext context) {
    industryList[index]['isSelected'] = !industryList[index]['isSelected'];
    print(industryList);
    getLinkingService(context, false);
    notifyListeners();
  }
}
