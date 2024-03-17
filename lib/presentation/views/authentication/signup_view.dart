import 'package:bloc_clean_architecture/core/constant/strings.dart';
import 'package:bloc_clean_architecture/core/router/app_router.dart';
import 'package:bloc_clean_architecture/core/theme/app_theme.dart';
import 'package:bloc_clean_architecture/data/models/user/auth_signup_response_model.dart';
import 'package:bloc_clean_architecture/presentation/blocs/signup/signup_bloc.dart';
import 'package:bloc_clean_architecture/presentation/widgets/auth_nav_text.dart';
import 'package:bloc_clean_architecture/presentation/widgets/custom_button.dart';
import 'package:bloc_clean_architecture/presentation/widgets/custom_spacing.dart';
import 'package:bloc_clean_architecture/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SignupBloc, SignupState>(
        listenWhen: (previous, current) => current is SignUpAfterState,
        buildWhen: (previous, current) => current is! SignUpAfterState,
        builder: (context, state) {
          if (state is SignupInitial) {
            return _buildBody(
              emailController,
              passwordController,
              nameController,
            );
          }
          return const SizedBox.shrink();
        },
        listener: (context, state) {
          if (state is SignUpSuccessState) {
            const snackBar =
                SnackBar(content: Text('Success to Signup, please Login!'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            setState(() {
              isLoading = false;
            });
            Navigator.pushReplacementNamed(context, AppRouter.signin);
          }
          if (state is SignUpLoadingState) {
            setState(() {
              isLoading = true;
            });
          }
          if (state is SignUpFailedState) {
            setState(() {
              isLoading = false;
            });
            const snackBar = SnackBar(content: Text('Failed to Signup!'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
      ),
    );
  }

  Widget _buildBody(
    TextEditingController emailController,
    passwordController,
    nameController,
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
                  '${StringConstant.appName} - SignUp',
                  style: AppTheme.header1,
                  textAlign: TextAlign.center,
                ),
              ),
              verticalSpacing(16),
              customTextField(
                controller: nameController,
                hintText: 'who is your name?',
                labelText: 'Full Name',
                keyboardType: TextInputType.emailAddress,
                isPassword: false,
                isReadOnly: false,
              ),
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
              authNavText(context, false),
              verticalSpacing(12),
              customButton(
                isLoading: isLoading,
                onTap: () {
                  var params = SignUpParams(
                    name: nameController.text,
                    avatar: 'https://api.lorem.space/image/face?w=640&h=480',
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  context.read<SignupBloc>().add(SignUpUserEvent(params));
                },
                text: 'Sign Up',
              )
            ],
          ),
        ),
      ),
    );
  }
}
