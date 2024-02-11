import 'package:bloc_clean_architecture/data/data_source/remote/user_remote_data_source.dart';
import 'package:bloc_clean_architecture/data/repositories/user_repository_impl.dart';
import 'package:bloc_clean_architecture/domain/repositories/user_repository.dart';
import 'package:bloc_clean_architecture/domain/usecases/user/sign_in_usecase.dart';
import 'package:bloc_clean_architecture/presentation/blocs/main/cart/cart_bloc.dart';
import 'package:bloc_clean_architecture/presentation/blocs/main/home/home_bloc.dart';
import 'package:bloc_clean_architecture/presentation/blocs/main/main_cubit.dart';
import 'package:bloc_clean_architecture/presentation/blocs/signin/signin_bloc.dart';
import 'package:bloc_clean_architecture/presentation/blocs/signup/signup_bloc.dart';
import 'package:bloc_clean_architecture/presentation/blocs/splash_screen/splash_screen_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // BLoC and Cubit
  sl.registerFactory(() => SplashScreenCubit());
  sl.registerFactory(() => SigninBloc(sl()));
  sl.registerFactory(() => SignupBloc());
  sl.registerFactory(() => MainCubit());
  sl.registerFactory(() => HomeBloc());
  sl.registerFactory(() => CartBloc());

  // Usecase
  sl.registerLazySingleton(() => SignInUseCase(sl()));

  // Repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      userRemoteDataSource: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  // External
  sl.registerLazySingleton(() => http.Client());
}
