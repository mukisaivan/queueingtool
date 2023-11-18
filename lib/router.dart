import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:queueingtool/models/user.dart';
import 'package:queueingtool/screens/counter_screen.dart';
import 'package:queueingtool/screens/customer_first_screen.dart';
import 'package:queueingtool/screens/customer_screen.dart';
import 'package:queueingtool/screens/login_screen.dart';
import 'package:queueingtool/screens/premium_requests_screen.dart';
import 'package:queueingtool/screens/signup_screen.dart';
import 'package:queueingtool/screens/turnto_premium_screen.dart';

Route<dynamic> genarateRoutes(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case SignUpScreen.routeName:
      return MaterialPageRoute(builder: (_) => const SignUpScreen());

    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (_) => const LoginScreen());

    case CounterScreen.routeName:
      return MaterialPageRoute(builder: (_) => const CounterScreen());

    case CustomerScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const CustomerScreen());
    case CustomerFirstScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const CustomerFirstScreen());
    case PremiumRequestsScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const PremiumRequestsScreen());
    case TurnToPremiumScreen.routeName:
      var currentUser = FirebaseAuth.instance.currentUser!;

      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => TurnToPremiumScreen(currentUser: currentUser));
    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(),
      );
  }
}
