import 'dart:developer';

import 'package:bloc_clean_architecture/core/error/exceptions.dart';
import 'package:bloc_clean_architecture/presentation/views/authentication/signin_view.dart';
import 'package:bloc_clean_architecture/presentation/views/authentication/signup_view.dart';
import 'package:bloc_clean_architecture/presentation/views/detail_product/detail_product_view.dart';
import 'package:bloc_clean_architecture/presentation/views/main/main_view.dart';
import 'package:bloc_clean_architecture/presentation/views/search_screen/search_screen.dart';
import 'package:bloc_clean_architecture/presentation/views/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AppRouter {
  static const String root = '/';
  static const String signin = '/signin';
  static const String signup = '/signup';
  static const String main = '/main';
  static const String detailProduct = '/detail-product';
  static const String searchProduct = '/search-product';

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    log('Current Route : ${routeSettings.name}');
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
      case main:
        return PageTransition(
          child: const MainView(),
          type: PageTransitionType.rightToLeft,
        );
      case detailProduct:
        return PageTransition(
          child: DetailProductView(productId: routeSettings.arguments as int),
          type: PageTransitionType.rightToLeft,
        );
      case searchProduct:
        return PageTransition(
            child: const SearchScreen(), type: PageTransitionType.fade);
      default:
        throw RouteException('Route Not Found!');
    }
  }
}
