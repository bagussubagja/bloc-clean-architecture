import 'package:bloc_clean_architecture/core/constant/strings.dart';
import 'package:bloc_clean_architecture/core/router/app_router.dart';
import 'package:bloc_clean_architecture/core/theme/app_theme.dart';
import 'package:bloc_clean_architecture/presentation/blocs/signin/signin_bloc.dart';
import 'package:bloc_clean_architecture/presentation/widgets/auth_nav_text.dart';
import 'package:bloc_clean_architecture/presentation/widgets/custom_button.dart';
import 'package:bloc_clean_architecture/presentation/widgets/custom_spacing.dart';
import 'package:bloc_clean_architecture/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigninView extends StatefulWidget {
  const SigninView({super.key});

  @override
  State<SigninView> createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SigninBloc, SigninState>(
        builder: (context, state) {
          if (state is SigninInitial) {
            return _buildBody(emailController, passwordController);
          }
          return const SizedBox.shrink();
        },
        listener: (context, state) {},
      ),
    );
  }

  Widget _buildBody(
    TextEditingController emailController,
    passwordController,
  ) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  '${StringConstant.appName} - SignIn',
                  style: AppTheme.header1,
                  textAlign: TextAlign.center,
                ),
              ),
              verticalSpacing(16),
              customTextField(
                controller: emailController,
                hintText: 'add your email here...',
                labelText: 'Email Address',
                keyboardType: TextInputType.emailAddress,
                isPassword: false,
                isReadOnly: false,
              ),
              customTextField(
                controller: passwordController,
                hintText: 'type your password here...',
                labelText: 'Password',
                keyboardType: TextInputType.text,
                isPassword: true,
                isReadOnly: false,
              ),
              verticalSpacing(12),
              authNavText(context, true),
              verticalSpacing(12),
              customButton(
                onTap: () {
                  Navigator.pushReplacementNamed(context, AppRouter.main);
                },
                text: 'Sign In',
              )
            ],
          ),
        ),
      ),
    );
  }
}
