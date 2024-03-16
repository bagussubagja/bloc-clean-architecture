import 'package:bloc_clean_architecture/core/constant/colors.dart';
import 'package:bloc_clean_architecture/core/router/app_router.dart';
import 'package:bloc_clean_architecture/core/theme/app_theme.dart';
import 'package:bloc_clean_architecture/domain/entities/products/products.dart';
import 'package:bloc_clean_architecture/presentation/widgets/custom_spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget productItemCard(BuildContext context, Products products, int productId) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, AppRouter.detailProduct,
          arguments: productId);
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
            imageUrl: products.images![0],
            placeholder: (context, url) => const Center(
              child: CupertinoActivityIndicator(),
            ),
            errorWidget: (context, url, error) => const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error),
                Text('Image Not Found'),
              ],
            ),
            imageBuilder: (context, imageProvider) {
              return Container(
                height: 120,
                alignment: Alignment.center,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
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
                  products.title!,
                  style: AppTheme.paragraph2,
                ),
                verticalSpacing(12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${products.price}',
                      style: AppTheme.paragraph1,
                    ),
                    const Icon(
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
