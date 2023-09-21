import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../services/api_revenues.dart';
import '../../../utils/utils.dart';
import '../../auth/prv/resident_info_prv.dart';

class RevenuesPrv extends ChangeNotifier {
  String? htmlWidget;
  Future get(BuildContext context) async {
    var apartmentId =
        context.read<ResidentInfoPrv>().selectedApartment?.apartmentId;
    var now = DateTime.now();

    await APIRevenues.get(apartmentId, now.month, now.year).then((v) {
      if (v != null) {
        htmlWidget = v;
        notifyListeners();
      }
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }
}
