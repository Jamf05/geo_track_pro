import 'package:auth_package/auth_package.dart' as auth_package;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


final class AuthRoutes {
  static const String whiteRoute = '/white-auth';

  static Widget buildWhitePage(BuildContext context, GoRouterState state) {
    return const auth_package.WhitePage();
  }
}