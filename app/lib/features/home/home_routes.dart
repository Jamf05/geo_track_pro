import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_package/home_package.dart' as home_package;


final class HomeRoutes {
  static const String whiteRoute = '/white-home';

  static Widget buildWhitePage(BuildContext context, GoRouterState state) {
    return const home_package.WhitePage();
  }

  // static Widget buildAuthenticatedHomePage(BuildContext context, GoRouterState state) {
  //   return const home_package.HomePage();
  // }
}