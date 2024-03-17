import 'package:bloc_clean_architecture/core/constant/colors.dart';
import 'package:bloc_clean_architecture/core/router/app_router.dart';
import 'package:bloc_clean_architecture/core/theme/app_theme.dart';
import 'package:bloc_clean_architecture/presentation/widgets/custom_spacing.dart';
import 'package:flutter/material.dart';

Widget authNavText(BuildContext context, bool isToSignUp) => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isToSignUp
              ? "Don't have any account yet?"
              : "Already have an account?",
          style: AppTheme.paragraph3.copyWith(
            color: AppColor.grayColor50,
          ),
        ),
        horizontalSpacing(8),
        GestureDetector(
          onTap: () {
            isToSignUp
                ? Navigator.pushReplacementNamed(context, AppRouter.signup)
                : Navigator.pushReplacementNamed(context, AppRouter.signin);
          },
          child: Text(
            isToSignUp ? 'Signup Now!' : 'Signin Now!',
            style: AppTheme.paragraph3,
          ),
        )
      ],
    );
