import 'package:bloc_clean_architecture/core/constant/colors.dart';
import 'package:bloc_clean_architecture/core/theme/app_theme.dart';
import 'package:bloc_clean_architecture/domain/entities/products/detail_product.dart';
import 'package:bloc_clean_architecture/presentation/blocs/detail_product/detail_product_bloc.dart';
import 'package:bloc_clean_architecture/presentation/widgets/custom_button.dart';
import 'package:bloc_clean_architecture/presentation/widgets/custom_spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailProductView extends StatefulWidget {
  const DetailProductView({super.key, required this.productId});
  final int productId;

  @override
  State<DetailProductView> createState() => _DetailProductViewState();
}

class _DetailProductViewState extends State<DetailProductView> {
  @override
  void initState() {
    super.initState();
    context
        .read<DetailProductBloc>()
        .add(DetailProductFetchDataEvent(id: widget.productId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DetailProductBloc, DetailProductState>(
        builder: (context, state) {
          if (state is DetailProductSuccessFetchState) {
            return _mainBody(detailProduct: state.detailProduct);
          }
          if (state is DetailProductFailedFetchState) {
            return _failedBody();
          }
          if (state is DetailProductLoadingFetchState) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          return const SizedBox();
        },
        listener: (context, state) {},
      ),
    );
  }

  _mainBody({DetailProduct? detailProduct}) {
    return Stack(
      children: [
        ListView(
          children: [
            Stack(
              children: [
                CarouselSlider(
                  items: detailProduct!.images!
                      .map((image) => CachedNetworkImage(
                            imageUrl: image,
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width,
                          ))
                      .toList(),
                  options: CarouselOptions(),
                ),
                Container(
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColor.grayColor100.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                ),
              ],
            ),
            verticalSpacing(16),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          detailProduct.title!,
                          style: AppTheme.header2,
                        ),
                      ),
                      Text(
                        '\$${detailProduct.price}',
                        style: AppTheme.header2,
                      ),
                    ],
                  ),
                  verticalSpacing(8),
                  Row(
                    children: [
                      CachedNetworkImage(
                        placeholder: (context, url) {
                          return const Center(
                            child: CupertinoActivityIndicator(),
                          );
                        },
                        imageUrl: detailProduct.category!.image!,
                        imageBuilder: (context, imageProvider) => Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: imageProvider,
                            ),
                          ),
                        ),
                      ),
                      horizontalSpacing(16),
                      Text(
                        detailProduct.category!.name!,
                        style: AppTheme.paragraph3,
                      ),
                    ],
                  ),
                  verticalSpacing(12),
                  Text(
                    detailProduct.description!,
                    style: AppTheme.paragraph2
                        .copyWith(color: AppColor.grayColor100),
                  ),
                  verticalSpacing(16),
                  const Text(
                    'Gallery Item',
                    style: AppTheme.header2,
                  ),
                  Wrap(
                    direction: Axis.horizontal,
                    children: detailProduct.images!
                        .map(
                          (image) => CachedNetworkImage(
                            imageUrl: image,
                            imageBuilder: (context, imageProvider) => Container(
                              height: 100,
                              width: 100,
                              margin: EdgeInsets.symmetric(
                                  horizontal: image != detailProduct.images![0]
                                      ? 10
                                      : 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: imageProvider,
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  )
                ],
              ),
            )
          ],
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Row(
            children: [
              Expanded(
                child: customButton(
                  onTap: () {},
                  icon: const Icon(Icons.shopping_cart),
                  enableBorderRadius: false,
                  text: 'Save to Cart',
                  color: AppColor.whiteColor,
                  isSecondary: true,
                  isLoading: false,
                ),
              ),
              Expanded(
                child: customButton(
                  onTap: () {},
                  enableBorderRadius: false,
                  text: 'Buy Now!',
                  isLoading: false,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  _failedBody() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.warning),
          Text(
            'Product Cannot be loaded!',
            style: AppTheme.paragraph1,
          ),
        ],
      ),
    );
  }
}
