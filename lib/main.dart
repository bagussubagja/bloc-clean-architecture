import 'package:bloc_clean_architecture/core/router/app_router.dart';
import 'package:bloc_clean_architecture/core/services/services_locator.dart';
import 'package:bloc_clean_architecture/presentation/blocs/main/cart/cart_bloc.dart';
import 'package:bloc_clean_architecture/presentation/blocs/main/home/home_bloc.dart';
import 'package:bloc_clean_architecture/presentation/blocs/main/main_cubit.dart';
import 'package:bloc_clean_architecture/presentation/blocs/signin/signin_bloc.dart';
import 'package:bloc_clean_architecture/presentation/blocs/signup/signup_bloc.dart';
import 'package:bloc_clean_architecture/presentation/blocs/splash_screen/splash_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SplashScreenCubit(sl(), sl()),
        ),
        BlocProvider(
          create: (context) => SigninBloc(sl()),
        ),
        BlocProvider(
          create: (context) => SignupBloc(),
        ),
        BlocProvider(
          create: (context) => MainCubit(),
        ),
        BlocProvider(
          create: (context) => HomeBloc(sl(), sl(), sl(), sl()),
        ),
        BlocProvider(
          create: (context) => CartBloc(),
        )
      ],
      child: MaterialApp(
        title: 'BLoC Clean Architecture',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
          fontFamily: 'Nunito',
        ),
        initialRoute: AppRouter.root,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
