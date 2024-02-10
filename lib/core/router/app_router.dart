import 'package:bloc_clean_architecture/core/error/exceptions.dart';
import 'package:bloc_clean_architecture/presentation/views/authentication/signin_view.dart';
import 'package:bloc_clean_architecture/presentation/views/authentication/signup_view.dart';
import 'package:bloc_clean_architecture/presentation/views/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AppRouter {
  static const String root = '/';
  static const String signin = '/signin';
  static const String signup = '/signup';
  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case root:
        return PageTransition(
          child: const SplashScreen(),
          type: PageTransitionType.fade,
        );
      case signin:
        return PageTransition(
          child: const SigninView(),
          type: PageTransitionType.fade,
        );
      case signup:
        return PageTransition(
          child: const SignUpView(),
          type: PageTransitionType.leftToRight,
        );
      default:
        throw RouteException('Route Not Found!');
    }
  }
}
