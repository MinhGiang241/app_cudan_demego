import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/response_apartment.dart';
import '../screens/auth/apartment_selection_screen.dart';
import '../screens/auth/fogot_pass/phone_num_forgot_pass.dart';
import '../screens/auth/fogot_pass/reset_pass_screen.dart';
import '../screens/auth/prv/auth_prv.dart';
import '../screens/auth/prv/sign_in_prv.dart';
import '../screens/auth/prv/sign_up_prv.dart';
import '../screens/auth/sign_in_screen.dart';
import '../screens/auth/sign_up_screen.dart';
import '../screens/bills/bills_screen.dart';
import '../screens/home/home_screen.dart';
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
          builder: (_) => ChangeNotifierProvider(
            create: (context) => SingInPrv(authPrv: context.read<AuthPrv>()),
            builder: ((context, child) => const SignInScreen()),
          ),
        );
      case SignUpScreen.routeName:
        return MaterialPageRoute(
            settings: routeSetting,
            builder: (_) => ChangeNotifierProvider(
                create: (context) =>
                    SignUpPrv(authPrv: context.read<AuthPrv>()),
                builder: (context, child) => const SignUpScreen()));

      case PhoneNumForgotPassScreen.routeName:
        return MaterialPageRoute(
          settings: routeSetting,
          builder: (_) => const PhoneNumForgotPassScreen(),
        );

      // case ResetPassScreen.routeName:
      //   return MaterialPageRoute(
      //     settings: routeSetting,
      //     builder: (_) => const ResetPassScreen(),
      //   );
      case HomeScreen.routeName:
        return MaterialPageRoute(
            settings: routeSetting,
            builder: (_) => ChangeNotifierProvider(
                create: (context) =>
                    SignUpPrv(authPrv: context.read<AuthPrv>()),
                builder: (context, child) => const HomeScreen()));
      case ApartmentSeletionScreen.routeName:
        return MaterialPageRoute(
          settings: routeSetting,
          builder: (_) => ChangeNotifierProvider(
              create: (context) => AuthPrv()..start(),
              builder: (context, child) => ApartmentSeletionScreen()),
        );
      case BillsScreen.routeName:
        return MaterialPageRoute(
          settings: routeSetting,
          builder: (_) => ChangeNotifierProvider(
              create: (context) => AuthPrv()..start(),
              builder: (context, child) => const BillsScreen()),
        );
      default:
        return MaterialPageRoute(
          settings: routeSetting,
          builder: (_) => const SplashScreen(isUnathen: true),
        );
    }
  }
}
