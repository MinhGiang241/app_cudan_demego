import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/response_apartment.dart';
import '../screens/auth/apartment_selection_screen.dart';
import '../screens/auth/fogot_pass/phone_num_forgot_pass.dart';
import '../screens/auth/prv/auth_prv.dart';
import '../screens/auth/prv/sign_in_prv.dart';
import '../screens/auth/sign_in_screen.dart';
import '../screens/auth/sign_up_screen.dart';
import '../screens/splash/splash_screen.dart';

class AppRoutes {
  Route onGenerateRoute(RouteSettings routeSetting) {
    switch (routeSetting.name) {
      case SplashScreen.routeName:
        return MaterialPageRoute(
          settings: routeSetting,
          builder: (_) => const SplashScreen(isUnathen: true),
        );
      case SignInScreen.routeName:
        return MaterialPageRoute(
            settings: routeSetting,
            builder: (_) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                      create: (context) => AuthPrv()..start(),
                    ),
                    ChangeNotifierProvider(
                      create: (context) =>
                          SingInPrv(authPrv: context.read<AuthPrv>()),
                    ),
                  ],
                  builder: ((context, child) => const SignInScreen()),
                ));
      case SignUpScreen.routeName:
        return MaterialPageRoute(
          settings: routeSetting,
          builder: (_) => const SignUpScreen(),
        );
      case PhoneNumForgotPassScreen.routeName:
        return MaterialPageRoute(
          settings: routeSetting,
          builder: (_) => const PhoneNumForgotPassScreen(),
        );
      case ApartmentSeletionScreen.routeName:
        return MaterialPageRoute(
          settings: routeSetting,
          builder: (_) => ApartmentSeletionScreen(),
        );
      default:
        return MaterialPageRoute(
          settings: routeSetting,
          builder: (_) => const SplashScreen(isUnathen: true),
        );
    }
  }
}
