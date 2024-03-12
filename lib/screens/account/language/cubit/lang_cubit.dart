import 'package:flutter/material.dart';

import '../../../../services/prf_data.dart';

class LangPrv extends ChangeNotifier {
  LangPrv(int lang, String Token) {
    lang == 0
        ? const Locale("vi", "VN")
        : lang == 1
            ? const Locale("en", "US")
            : const Locale("ko", "KR");
    if (lang == 0) {
      locale = const Locale("vi", "VN");
    } else if (lang == 1) {
      locale = const Locale("en", "US");
    } else if (lang == 2) {
      locale = const Locale("ko", "KR");
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

  setKoLang() async {
    const l = Locale("ko", "KR");
    locale = l;
    notifyListeners();
    await PrfData.shared.setLanguage(2);
  }
}
