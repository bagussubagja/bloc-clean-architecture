import 'package:bloc_clean_architecture/core/constant/colors.dart';
import 'package:bloc_clean_architecture/core/constant/strings.dart';
import 'package:bloc_clean_architecture/core/theme/app_theme.dart';
import 'package:bloc_clean_architecture/presentation/blocs/main/home/home_bloc.dart';
import 'package:bloc_clean_architecture/presentation/widgets/category_tile.dart';
import 'package:bloc_clean_architecture/presentation/widgets/custom_spacing.dart';
import 'package:bloc_clean_architecture/presentation/widgets/loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  /// TODO : Delete Soon
  final List<String> categories = [
    'category1',
    'category2',
    'category3',
    'category4',
    'category5',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeBloc, HomeState>(
        builder: (context, state) {
          // if (state is HomeSuccessFetchData) {
          //   return _buildBody();
          // }
          // return const SizedBox.shrink();
          return _buildBody();
        },
        listener: (context, state) {},
      ),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(12),
        children: [
          _headerSection(),
          verticalSpacing(36),
          _categorySection(categories),
          verticalSpacing(36),
          _productListSection(),
        ],
      ),
    );
  }

  Widget _productListSection() {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: 20,
      primary: false,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 1 / 1,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      itemBuilder: (context, index) => Container(
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

  Widget _categorySection(
    List<String> category,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Category',
          style: AppTheme.header2,
        ),
        verticalSpacing(12),
        SizedBox(
          height: 45,
          child: ListView.separated(
            shrinkWrap: true,
            primary: false,
            itemCount: category.length,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => horizontalSpacing(12),
            itemBuilder: (context, index) => categoryTile(
              category[index],
            ),
          ),
        ),
      ],
    );
  }

  Widget _headerSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome,',
              style: AppTheme.header1,
            ),
            Text(
              'Bagus Subagja',
              style: AppTheme.paragraph2,
            )
          ],
        ),
        CachedNetworkImage(
          imageUrl: StringConstant.placeholderAvatar,
          placeholder: (context, url) => loadingWidget(),
          imageBuilder: (context, imageProvider) {
            return Container(
              height: 65,
              width: 65,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: imageProvider,
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
