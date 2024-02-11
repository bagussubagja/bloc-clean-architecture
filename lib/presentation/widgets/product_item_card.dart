import 'package:bloc_clean_architecture/core/constant/colors.dart';
import 'package:bloc_clean_architecture/core/constant/strings.dart';
import 'package:bloc_clean_architecture/core/router/app_router.dart';
import 'package:bloc_clean_architecture/core/theme/app_theme.dart';
import 'package:bloc_clean_architecture/presentation/widgets/custom_spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget productItemCard(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, AppRouter.detailProduct);
    },
    child: Container(
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: AppColor.grayColor10,
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: Offset(
              5.0,
              5.0,
            ),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: StringConstant.placeholderProduct,
            imageBuilder: (context, imageProvider) {
              return Container(
                height: 100,
                alignment: Alignment.center,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fill,
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'name_of_product',
                  style: AppTheme.paragraph2,
                ),
                verticalSpacing(12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$10',
                      style: AppTheme.paragraph1,
                    ),
                    Icon(
                      Icons.shopping_cart_checkout,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}
