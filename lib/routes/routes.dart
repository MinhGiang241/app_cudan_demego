import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/response_apartment.dart';
import '../screens/account/personal_info/personal_info_screen.dart';
import '../screens/auth/apartment_selection_screen.dart';
import '../screens/auth/fogot_pass/phone_num_forgot_pass.dart';
import '../screens/auth/fogot_pass/reset_pass_screen.dart';
import '../screens/auth/project_selection_screen.dart';
import '../screens/auth/prv/auth_prv.dart';
import '../screens/auth/prv/sign_in_prv.dart';
import '../screens/auth/prv/sign_up_prv.dart';
import '../screens/auth/sign_in_screen.dart';
import '../screens/auth/sign_up_screen.dart';
import '../screens/bills/bills_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/services/delivery/delivery_list_screen.dart';
import '../screens/services/delivery/package_details_screen.dart';
import '../screens/services/delivery/register_delivery_screen.dart';
import '../screens/services/gym_card/add_gym_card_screen.dart';
import '../screens/services/gym_card/gym_card_list_screen.dart';
import '../screens/services/parcel/parcels_list_screen.dart';
import '../screens/services/parking_card/register_parking_card.dart';
import '../screens/services/parking_card/transport_card_list_screen.dart';
import '../screens/services/parking_card/transportation_details_screen.dart';
import '../screens/services/resident_card/register_resident_card.dart';
import '../screens/services/resident_card/resident_card_details.dart';
import '../screens/services/resident_card/resident_card_screen.dart';
import '../screens/services/service_screen.dart';
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
            builder: ((context, child) => SignInScreen(
                  context: context,
                )),
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

      case HomeScreen.routeName:
        return MaterialPageRoute(
            settings: routeSetting,
            builder: (_) => ChangeNotifierProvider(
                create: (context) =>
                    SignUpPrv(authPrv: context.read<AuthPrv>()),
                builder: (context, child) => const HomeScreen()));
      case ProjectSelectionScreen.routeName:
        return MaterialPageRoute(
          settings: routeSetting,
          builder: (context) => const ProjectSelectionScreen(),
        );
      case ApartmentSeletionScreen.routeName:
        return MaterialPageRoute(
          settings: routeSetting,
          builder: (context) => ApartmentSeletionScreen(
            context: context,
          ),
        );
      case PersonalInfoScreen.routeName:
        return MaterialPageRoute(
          settings: routeSetting,
          builder: (_) => const PersonalInfoScreen(),
        );
      case BillsScreen.routeName:
        return MaterialPageRoute(
          settings: routeSetting,
          builder: (_) => const BillsScreen(),
        );
      case ServiceScreen.routeName:
        return MaterialPageRoute(
          settings: routeSetting,
          builder: (_) => const ServiceScreen(),
        );
      case GymCardListScreen.routeName:
        return MaterialPageRoute(
          settings: routeSetting,
          builder: (_) => const GymCardListScreen(),
        );
      case AddGymCardScreen.routeName:
        return MaterialPageRoute(
          settings: routeSetting,
          builder: (_) => const AddGymCardScreen(),
        );
      case TransportationCardListScreen.routeName:
        return MaterialPageRoute(
          settings: routeSetting,
          builder: (context) => TransportationCardListScreen(ctx: context),
        );
      case TransportationCardDetails.routeName:
        return MaterialPageRoute(
          settings: routeSetting,
          builder: (_) => const TransportationCardDetails(),
        );
      case RegisterTransportationCard.routeName:
        return MaterialPageRoute(
          settings: routeSetting,
          builder: (_) => const RegisterTransportationCard(),
        );
      case ResidentCardListScreen.routeName:
        return MaterialPageRoute(
          settings: routeSetting,
          builder: (_) => const ResidentCardListScreen(),
        );
      case DeliveryListScreen.routeName:
        return MaterialPageRoute(
          settings: routeSetting,
          builder: (_) => const DeliveryListScreen(),
        );
      case PackageDetailScreen.routeName:
        return MaterialPageRoute(
          settings: routeSetting,
          builder: (_) => const PackageDetailScreen(),
        );
      case RegisterDelivery.routeName:
        return MaterialPageRoute(
          settings: routeSetting,
          builder: (_) => const RegisterDelivery(),
        );
      case ResidentCardDetails.routeName:
        return MaterialPageRoute(
          settings: routeSetting,
          builder: (_) => const ResidentCardDetails(),
        );
      case RegisterResidentCard.routeName:
        return MaterialPageRoute(
          settings: routeSetting,
          builder: (_) => const RegisterResidentCard(),
        );
      case ParcelListScreen.routeName:
        return MaterialPageRoute(
          settings: routeSetting,
          builder: (_) => const ParcelListScreen(),
        );
      default:
        return MaterialPageRoute(
          settings: routeSetting,
          builder: (_) => const SplashScreen(isUnathen: true),
        );
    }
  }
}
