import 'package:flutter/material.dart';
import 'package:queueingtool/screens/home_screen.dart';
import 'package:queueingtool/screens/login_screen.dart';
import 'package:queueingtool/screens/signup_screen.dart';

Route<dynamic> genarateRoutes(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case SignUpScreen.routeName:
      return MaterialPageRoute(builder: (_) => const SignUpScreen());

    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (_) => const LoginScreen());

    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const HomeScreen());
    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(),
      );
  }
}
