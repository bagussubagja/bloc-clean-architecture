import 'package:bloc_clean_architecture/core/error/exceptions.dart';
import 'package:bloc_clean_architecture/presentation/views/authentication/signin_view.dart';
import 'package:bloc_clean_architecture/presentation/views/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const String root = '/';
  static const String signin = '/signin';
  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case root:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case signin:
        return MaterialPageRoute(
          builder: (_) => const SigninView(),
        );
      default:
        throw RouteException('Route Not Found!');
    }
  }
}
