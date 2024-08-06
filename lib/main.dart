// ignore_for_file: require_trailing_commas

import 'dart:io';

import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/screens/chat/bloc/chat_message_bloc.dart';
import 'package:app_cudan/screens/chat/new_chat/bloc/new_chat_bloc.dart';
import 'package:app_cudan/screens/ho/prv/ho_account_service_prv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'constants/theme.dart';
import 'generated/l10n.dart';
import 'routes/routes.dart';
import 'screens/account/language/cubit/lang_cubit.dart';
import 'screens/auth/prv/auth_prv.dart';
import 'screens/notification/prv/notification_prv.dart';
import 'services/firebase_api.dart';
import 'services/prf_data.dart';
import 'package:timeago/timeago.dart';

final navigatorKey = GlobalKey<NavigatorState>();
var FCMtoken;
var firebase = FirebaseApi();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FCMtoken = await firebase.initNotification();

  await FlutterDownloader.initialize(
      debug:
          true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl:
          true // option: set to false to disable working with http links (default: false)
      );

  ByteData data =
      await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());

  // Paint.enableDithering = true;

  await Hive.initFlutter();
  await PrfData.open();
  final lang = PrfData.shared.getLanguage();
  setLocaleMessages('vi', ViMessages());

  ErrorWidget.builder = (FlutterErrorDetails details) {
    bool inDebug = false;

    assert(() {
      inDebug = true;
      return true;
    }());
    if (inDebug) {
      return ErrorWidget(details.exception);
    }
    return Container(
      alignment: Alignment.center,
      child: Text(
        'Error\n${details.exception}',
        style: const TextStyle(
          color: Colors.orangeAccent,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
    );
  };

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
        // ChangeNotifierProxyProvider(create: create, update: update)
        ChangeNotifierProvider(
          create: (context) => AuthPrv()..start(context),
        ),
        ChangeNotifierProvider(
          create: (context) => HOAccountServicePrv(),
        ),
        ChangeNotifierProvider(create: (context) => LangPrv(lang, FCMtoken)),
        ChangeNotifierProvider(create: (context) => ResidentInfoPrv()),
        ChangeNotifierProvider(create: (context) => NotificationPrv())
      ],
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ChatMessageBloc()),
            BlocProvider(create: (context) => NewChatBloc()),
          ],
          child: MaterialApp(
            navigatorKey: navigatorKey,
            builder: (context, child) {
              final mediaQueryData = MediaQuery.of(context);
              final scale = mediaQueryData.textScaleFactor.clamp(1.0, 1.2);
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: scale),
                child: child!,
              );
            },
            debugShowCheckedModeBanner: false,
            title: 'DEMEPRO',
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
          ),
        );
      },
    );
  }
}
