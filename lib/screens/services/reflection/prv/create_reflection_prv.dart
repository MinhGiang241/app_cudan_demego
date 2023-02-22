import 'package:app_cudan/models/reflection.dart';
import 'package:app_cudan/services/api_reflection.dart';
import 'package:flutter/material.dart';

import '../../../../utils/utils.dart';

class CreateReflectionPrv extends ChangeNotifier {
  List<ComplainReason> listReasons = [];
  getReflectionReason(BuildContext context) async {
    await APIReflection.getComplainReaction().then((v) {
      listReasons.clear();
      for (var i in v) {
        listReasons.add(ComplainReason.fromJson(i));
      }
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }
}
