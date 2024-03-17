import 'package:bloc_clean_architecture/core/constant/colors.dart';
import 'package:bloc_clean_architecture/core/router/app_router.dart';
import 'package:bloc_clean_architecture/core/theme/app_theme.dart';
import 'package:bloc_clean_architecture/data/models/product/cart_item_model.dart';
import 'package:bloc_clean_architecture/domain/entities/category/categories.dart';
import 'package:bloc_clean_architecture/domain/entities/products/products.dart';
import 'package:bloc_clean_architecture/presentation/blocs/main/home/home_bloc.dart';
import 'package:bloc_clean_architecture/presentation/widgets/category_tile.dart';
import 'package:bloc_clean_architecture/presentation/widgets/custom_spacing.dart';
import 'package:bloc_clean_architecture/presentation/widgets/loading_widget.dart';
import 'package:bloc_clean_architecture/presentation/widgets/product_item_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Products> products = [];
  int selectedId = 1;
  bool isLoading = false;

  @override
  void initState() {
    context.read<HomeBloc>().add(HomeFetchDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeBloc, HomeState>(
        buildWhen: (previous, current) => current is! HomeAfterState,
        listenWhen: (previous, current) => current is HomeAfterState,
        builder: (context, state) {
          if (state is HomeSuccessFetchData) {
            return SafeArea(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(12),
                children: [
                  _headerSection(state.user.name!, state.user.avatar!),
                  verticalSpacing(36),
                  _searchWidget(),
                  verticalSpacing(36),
                  _categorySection(state.categories),
                  verticalSpacing(36),
                  Visibility(
                    replacement: const Center(
                      child: CupertinoActivityIndicator(),
                    ),
                    visible: !isLoading,
                    child: _productListSection(
                      products: products.isEmpty ? state.products! : products,
                    ),
                  ),
                  verticalSpacing(75),
                ],
              ),
            );
          }
          if (state is HomeFailedFetchData) {
            return Center(
              child: Text(state.failure.toString()),
            );
          }
          if (state is HomeLoadingFetchData) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          return const SizedBox.shrink();
        },
        listener: (context, state) {
          if (state is HomeFetchProductByCategorySuccessState) {
            setState(() {
              isLoading = false;
              products = state.products!;
            });
          }
          if (state is HomeFetchProductByCategoryLoadingState) {
            setState(() {
              isLoading = true;
            });
          }
          if (state is HomeAddItemToCart) {
            const snackBar =
                SnackBar(content: Text('Item Successfully Added to Cart!'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
      ),
    );
  }

  Widget _searchWidget() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRouter.searchProduct);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppColor.grayColor10,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.search,
              color: AppColor.grayColor100,
            ),
            horizontalSpacing(24),
            const Text(
              'Search here...',
              style: AppTheme.paragraph2,
            ),
          ],
        ),
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
      itemBuilder: (context, index) => productItemCard(
        context,
        products[index],
        products[index].id!,
        () {
          var params = CartItemModel(
            productId: products[index].id.toString(),
            productName: products[index].title,
            productImage: products[index].images![0],
            productPrice: products[index].price.toString(),
          );
          context.read<HomeBloc>().add(HomeAddItemToCartEvent(params));
        },
      ),
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
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                context.read<HomeBloc>().add(
                    HomeFetchProductDataByCategoryEvent(category[index].id!));
                setState(() {
                  selectedId = category[index].id!;
                });
              },
              child: categoryTile(
                  category[index].name!, category[index].id!, selectedId),
            ),
          ),
        ),
      ],
    );
  }

  Widget _headerSection(String name, String profileUrl) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome,',
              style: AppTheme.header1,
            ),
            Text(
              '$name.',
              style: AppTheme.paragraph2,
            )
          ],
        ),
        CachedNetworkImage(
          imageUrl: profileUrl,
          placeholder: (context, url) => loadingWidget(),
          imageBuilder: (context, imageProvider) {
            return ClipRRect(
              child: Container(
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
