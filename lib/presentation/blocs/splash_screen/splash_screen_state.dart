part of 'splash_screen_cubit.dart';

abstract class SplashScreenState extends Equatable {
  const SplashScreenState();

  @override
  List<Object> get props => [];
}

abstract class SplashScreenActionState extends SplashScreenState {}

class SplashScreenInitial extends SplashScreenState {}

class SplashScreenMoveToMainPageState extends SplashScreenActionState {}

class SplashScreenMoveToLoginPage extends SplashScreenActionState {}

class SplashScreenLoadingState extends SplashScreenState {}

class SplashScreenOutState extends SplashScreenActionState {}
