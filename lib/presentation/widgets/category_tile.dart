import 'package:bloc_clean_architecture/core/constant/colors.dart';
import 'package:bloc_clean_architecture/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

Widget categoryTile(
  String category,
  int id,
  int selectedId,
) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      border: Border.all(color: AppColor.greenLightMossColor),
      color:
          selectedId == id ? AppColor.greenLightMossColor : AppColor.whiteColor,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      category,
      style: AppTheme.paragraph2.copyWith(
        color: selectedId == id
            ? AppColor.whiteColor
            : AppColor.greenLightMossColor,
      ),
    ),
  );
}
