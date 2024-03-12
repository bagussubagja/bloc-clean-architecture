import 'package:bloc_clean_architecture/core/constant/colors.dart';
import 'package:bloc_clean_architecture/core/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customButton(
    {required Function() onTap,
    Color? color,
    required String text,
    required bool isLoading}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color ?? AppColor.greenLightMossColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: isLoading
          ? const CupertinoActivityIndicator()
          : Text(
              text,
              style: AppTheme.paragraph2.copyWith(color: AppColor.whiteColor),
            ),
    ),
  );
}
