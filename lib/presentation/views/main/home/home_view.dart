import 'package:bloc_clean_architecture/core/constant/strings.dart';
import 'package:bloc_clean_architecture/core/theme/app_theme.dart';
import 'package:bloc_clean_architecture/domain/entities/category/categories.dart';
import 'package:bloc_clean_architecture/domain/entities/products/products.dart';
import 'package:bloc_clean_architecture/presentation/blocs/main/home/home_bloc.dart';
import 'package:bloc_clean_architecture/presentation/widgets/category_tile.dart';
import 'package:bloc_clean_architecture/presentation/widgets/custom_spacing.dart';
import 'package:bloc_clean_architecture/presentation/widgets/loading_widget.dart';
import 'package:bloc_clean_architecture/presentation/widgets/product_item_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    context.read<HomeBloc>().add(HomeFetchDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeSuccessFetchData) {
            return SafeArea(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(12),
                children: [
                  _headerSection(),
                  verticalSpacing(36),
                  _categorySection(state.categories),
                  verticalSpacing(36),
                  _productListSection(products: state.products!),
                ],
              ),
            );
          }
          if (state is HomeFailedFetchData) {
            return Center(
              child: Text(state.failure.toString()),
            );
          }
          return const SizedBox.shrink();
        },
        listener: (context, state) {},
      ),
    );
  }

  Widget _productListSection({required List<Products> products}) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: products.length,
      primary: false,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 4,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      itemBuilder: (context, index) =>
          productItemCard(context, products[index]),
    );
  }

  Widget _categorySection(
    List<Categories> category,
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
              category[index].name!,
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
