import 'package:bloc_clean_architecture/core/constant/colors.dart';
import 'package:bloc_clean_architecture/core/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customButton(
    {required Function() onTap,
    Color? color,
    bool? isSecondary = false,
    bool? enableBorderRadius = true,
    Widget? icon,
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
        borderRadius: enableBorderRadius == true
            ? BorderRadius.circular(12)
            : BorderRadius.circular(0),
        border: isSecondary == true
            ? Border.all(
                color: AppColor.greenLightMossColor,
                width: 0.1,
              )
            : null,
      ),
      child: isLoading
          ? const CupertinoActivityIndicator(
              color: Colors.white,
            )
          : icon != null
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon,
                    Text(
                      text,
                      style: AppTheme.paragraph2.copyWith(
                          color: isSecondary == false
                              ? AppColor.whiteColor
                              : AppColor.blackColor100),
                    )
                  ],
                )
              : Text(
                  text,
                  style: AppTheme.paragraph2.copyWith(
                      color: isSecondary == false
                          ? AppColor.whiteColor
                          : AppColor.blackColor100),
                ),
    ),
  );
}
