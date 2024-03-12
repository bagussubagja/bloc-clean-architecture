import 'package:bloc_clean_architecture/core/router/app_router.dart';
import 'package:bloc_clean_architecture/core/theme/app_theme.dart';
import 'package:bloc_clean_architecture/presentation/blocs/splash_screen/splash_screen_cubit.dart';
import 'package:bloc_clean_architecture/presentation/widgets/custom_spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    context.read<SplashScreenCubit>().isLogin(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SplashScreenCubit, SplashScreenState>(
        buildWhen: (previous, current) => current is! SplashScreenActionState,
        listenWhen: (previous, current) => current is SplashScreenActionState,
        listener: (context, state) {
          print('state splash $state');
          if (state is SplashScreenMoveToLoginPage) {
            Navigator.pushReplacementNamed(context, AppRouter.signin);
          }
          if (state is SplashScreenMoveToMainPageState) {
            Navigator.pushReplacementNamed(context, AppRouter.main);
          }
        },
        builder: (context, state) {
          if (state is SplashScreenLoadingState) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CupertinoActivityIndicator(color: Colors.teal),
                  verticalSpacing(10),
                  const Text(
                    'Loading...',
                    style: AppTheme.paragraph3,
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
