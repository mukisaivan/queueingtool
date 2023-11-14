import 'package:flutter/material.dart';
import 'package:queueingtool/screens/customer_first_screen.dart';
import 'package:queueingtool/screens/customer_screen.dart';
import 'package:queueingtool/screens/login_screen.dart';
import 'package:queueingtool/screens/signup_screen.dart';

Route<dynamic> genarateRoutes(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case SignUpScreen.routeName:
      return MaterialPageRoute(builder: (_) => const SignUpScreen());

    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (_) => const LoginScreen());

    case CustomerScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const CustomerScreen());
    case CustomerFirstScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const CustomerFirstScreen());
    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(),
      );
  }
}
