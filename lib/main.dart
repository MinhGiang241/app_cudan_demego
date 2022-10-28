import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'constants/theme.dart';
import 'generated/l10n.dart';
import 'routes/routes.dart';
import 'screens/account/language/cubit/lang_cubit.dart';
import 'screens/auth/prv/auth_prv.dart';
import 'services/prf_data.dart';
import 'package:timeago/timeago.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ByteData data =
      await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());

  Paint.enableDithering = true;
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await PrfData.open();
  final lang = PrfData.shared.getLanguage();
  setLocaleMessages('vi', ViMessages());

  runApp(MyApp(lang: lang ?? 0));
}

class MyApp extends StatelessWidget {
  final AppRoutes _appRouter = AppRoutes();
  MyApp({super.key, required this.lang});
  final int lang;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthPrv()..start(),
        ),
        ChangeNotifierProvider(create: (context) => LangPrv(lang))
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'DEMEGO',
          theme: AppTheme.lightTheme(),
          locale: context.watch<LangPrv>().locale,
          onGenerateRoute: _appRouter.onGenerateRoute,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
        );
      },
    );
  }
}
