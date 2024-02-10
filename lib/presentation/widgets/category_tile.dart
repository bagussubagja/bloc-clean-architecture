import 'package:bloc_clean_architecture/core/constant/colors.dart';
import 'package:bloc_clean_architecture/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

Widget categoryTile(
  String category,
) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: AppColor.greenLightMossColor,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      category,
      style: AppTheme.paragraph2.copyWith(
        color: AppColor.whiteColor,
      ),
    ),
  );
}
