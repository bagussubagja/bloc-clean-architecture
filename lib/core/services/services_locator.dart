import 'package:bloc_clean_architecture/presentation/blocs/main/main_cubit.dart';
import 'package:bloc_clean_architecture/presentation/blocs/signin/signin_bloc.dart';
import 'package:bloc_clean_architecture/presentation/blocs/signup/signup_bloc.dart';
import 'package:bloc_clean_architecture/presentation/blocs/splash_screen/splash_screen_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // BLoC and Cubit
  sl.registerFactory(() => SplashScreenCubit());
  sl.registerFactory(() => SigninBloc());
  sl.registerFactory(() => SignupBloc());
  sl.registerFactory(() => MainCubit());
}
