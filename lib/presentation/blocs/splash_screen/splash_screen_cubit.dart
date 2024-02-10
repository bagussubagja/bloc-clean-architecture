import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/core/router/app_router.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'splash_screen_state.dart';

class SplashScreenCubit extends Cubit<SplashScreenState> {
  SplashScreenCubit() : super(SplashScreenInitial());

  void moveToScreen(BuildContext context) {
    Future.delayed(const Duration(seconds: 2)).then(
      (_) => Navigator.pushReplacementNamed(
        context,
        AppRouter.signin,
      ),
    );
  }
}
