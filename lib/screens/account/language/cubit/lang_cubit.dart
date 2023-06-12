import 'package:flutter/material.dart';

import '../../../../services/prf_data.dart';

class LangPrv extends ChangeNotifier {
  LangPrv(int lang, String Token) {
    lang == 0 ? const Locale("vi", "VN") : const Locale("en", "US");
    if (lang == 0) {
      locale = const Locale("vi", "VN");
    } else {
      locale = const Locale("en", "US");
    }
    fcmToken = Token;
  }
  String? fcmToken;
  int? themeMode;

  Locale? locale;

  setEnLang() async {
    const l = Locale("en", "US");
    locale = l;
    notifyListeners();
    await PrfData.shared.setLanguage(1);
  }

  setViLang() async {
    const l = Locale("vi", "VN");
    locale = l;
    notifyListeners();
    await PrfData.shared.setLanguage(0);
  }
}
