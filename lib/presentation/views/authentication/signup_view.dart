import 'package:bloc_clean_architecture/core/constant/strings.dart';
import 'package:bloc_clean_architecture/core/theme/app_theme.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SignupBloc, SignupState>(
        builder: (context, state) {
          if (state is SignupInitial) {
            return _buildBody(
                emailController, passwordController, nameController);
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
                onTap: () {},
                text: 'Sign Up',
              )
            ],
          ),
        ),
      ),
    );
  }
}
