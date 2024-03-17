import 'package:bloc_clean_architecture/core/constant/colors.dart';
import 'package:flutter/cupertino.dart';

Widget loadingWidget() => const Center(
      child: CupertinoActivityIndicator(
        color: AppColor.greenLightMossColor,
      ),
    );
