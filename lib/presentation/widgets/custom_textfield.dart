import 'package:bloc_clean_architecture/core/constant/colors.dart';
import 'package:bloc_clean_architecture/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

Widget customTextField({
  required TextEditingController controller,
  required String hintText,
  required String labelText,
  required TextInputType keyboardType,
  required bool isPassword,
  required bool isReadOnly,
  Function(String)? onChanged,
  Widget? prefixIcon,
  Widget? prefixAction,
  Widget? suffixIcon,
  Widget? suffixAction,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        labelText,
        style: AppTheme.paragraph2,
      ),
      Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColor.grayColor50,
          ),
        ),
        child: TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: isPassword,
          readOnly: isReadOnly,
          obscuringCharacter: '*',
          onChanged: onChanged,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(12),
              hintText: hintText,
              border: InputBorder.none,
              suffix: suffixAction,
              suffixIcon: suffixIcon,
              prefix: prefixAction,
              prefixIcon: prefixIcon),
        ),
      )
    ],
  );
}
