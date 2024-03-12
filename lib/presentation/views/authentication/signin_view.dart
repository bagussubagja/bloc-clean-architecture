import 'package:bloc_clean_architecture/core/constant/strings.dart';
import 'package:bloc_clean_architecture/core/router/app_router.dart';
import 'package:bloc_clean_architecture/core/theme/app_theme.dart';
import 'package:bloc_clean_architecture/data/models/user/auth_signin_response_model.dart';
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
  final emailController = TextEditingController(text: 'bagus@email.com');
  final passwordController = TextEditingController(text: '1234');
  bool isLoading = false;
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
      body: BlocListener<SigninBloc, SigninState>(
        listener: (context, state) {
          if (state is SignInLoadingState) {
            setState(() {
              isLoading = true;
            });
          }
          if (state is SignInSuccessState) {
            Navigator.pushReplacementNamed(context, AppRouter.main);
          }
          if (state is SignInFailedState) {
            const snackBar = SnackBar(content: Text('Failed To Login'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            setState(() {
              isLoading = false;
            });
          }
        },
        child: _buildBody(emailController, passwordController),
      ),
    );
  }

  Widget _buildBody(
    TextEditingController emailController,
    TextEditingController passwordController,
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
                isLoading: isLoading,
                onTap: () {
                  var params = SignInParams(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  context.read<SigninBloc>().add(SignInUser(params));
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
