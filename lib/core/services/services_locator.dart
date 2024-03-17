import 'package:bloc_clean_architecture/core/network/network_info.dart';
import 'package:bloc_clean_architecture/core/services/database_services.dart';
import 'package:bloc_clean_architecture/data/data_source/local/local_database_data_source.dart';
import 'package:bloc_clean_architecture/data/data_source/local/user_local_data_source.dart';
import 'package:bloc_clean_architecture/data/data_source/remote/category_remote_data_source.dart';
import 'package:bloc_clean_architecture/data/data_source/remote/product_remote_data_source.dart';
import 'package:bloc_clean_architecture/data/data_source/remote/user_remote_data_source.dart';
import 'package:bloc_clean_architecture/data/repositories/category_repository_impl.dart';
import 'package:bloc_clean_architecture/data/repositories/products_repository_impl.dart';
import 'package:bloc_clean_architecture/data/repositories/user_repository_impl.dart';
import 'package:bloc_clean_architecture/domain/repositories/category_repository.dart';
import 'package:bloc_clean_architecture/domain/repositories/product_repository.dart';
import 'package:bloc_clean_architecture/domain/repositories/user_repository.dart';
import 'package:bloc_clean_architecture/domain/usecases/category/get_category_usecase.dart';
import 'package:bloc_clean_architecture/domain/usecases/products/get_detail_product_usecase.dart';
import 'package:bloc_clean_architecture/domain/usecases/products/get_product_usecase.dart';
import 'package:bloc_clean_architecture/domain/usecases/products/get_products_by_category.dart';
import 'package:bloc_clean_architecture/domain/usecases/products/get_search_product_by_name.dart';
import 'package:bloc_clean_architecture/domain/usecases/user/get_profile_usecase.dart';
import 'package:bloc_clean_architecture/domain/usecases/user/sign_in_usecase.dart';
import 'package:bloc_clean_architecture/presentation/blocs/detail_product/detail_product_bloc.dart';
import 'package:bloc_clean_architecture/presentation/blocs/main/cart/cart_bloc.dart';
import 'package:bloc_clean_architecture/presentation/blocs/main/home/home_bloc.dart';
import 'package:bloc_clean_architecture/presentation/blocs/main/main_cubit.dart';
import 'package:bloc_clean_architecture/presentation/blocs/search_product/search_product_bloc.dart';
import 'package:bloc_clean_architecture/presentation/blocs/settings/settings_bloc.dart';
import 'package:bloc_clean_architecture/presentation/blocs/signin/signin_bloc.dart';
import 'package:bloc_clean_architecture/presentation/blocs/signup/signup_bloc.dart';
import 'package:bloc_clean_architecture/presentation/blocs/splash_screen/splash_screen_cubit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // BLoC and Cubit
  sl.registerFactory(() => SplashScreenCubit(sl(), sl()));
  sl.registerFactory(() => SigninBloc(sl()));
  sl.registerFactory(() => SignupBloc());
  sl.registerFactory(() => MainCubit());
  sl.registerFactory(() => HomeBloc(sl(), sl(), sl(), sl(), sl(), sl(), sl()));
  sl.registerFactory(() => CartBloc(sl()));
  sl.registerFactory(() => DetailProductBloc(sl(), sl()));
  sl.registerFactory(() => SearchProductBloc(sl()));
  sl.registerFactory(() => SettingsBloc(sl(), sl(), sl()));

  // Usecase
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(
    () => GetProductUseCase(repository: sl()),
  );
  sl.registerLazySingleton(() => GetCategoryUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetProfileUserUseCase(sl()));
  sl.registerLazySingleton(() => GetDetailProductUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetProductsByCategory(sl()));
  sl.registerLazySingleton(() => GetSearchProductByNameUseCase(sl()));

  // Repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
        userRemoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()),
  );
  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(productRemoteDataSource: sl()));
  sl.registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImpl(categoryRemoteDataSource: sl()));

  // Data Sources
  sl.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(sharedPreferences: sl(), secureStorage: sl()),
  );
  sl.registerLazySingleton<LocalDatabaseDataSource>(
      () => LocalDatabaseDataSourceImpl(sl()));
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(
      client: sl(),
    ),
  );
  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<CategoryRemoteDataSource>(
      () => CategoryRemoteDataSourceImpl(client: sl()));

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  const secureStorage = FlutterSecureStorage();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => secureStorage);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton<DatabaseService>(() => DatabaseService.instance);
}
