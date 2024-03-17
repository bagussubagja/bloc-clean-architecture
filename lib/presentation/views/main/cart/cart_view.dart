import 'package:bloc_clean_architecture/core/constant/colors.dart';
import 'package:bloc_clean_architecture/core/router/app_router.dart';
import 'package:bloc_clean_architecture/core/theme/app_theme.dart';
import 'package:bloc_clean_architecture/presentation/blocs/main/cart/cart_bloc.dart';
import 'package:bloc_clean_architecture/presentation/widgets/custom_spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/product/cart_item_model.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  void initState() {
    context.read<CartBloc>().add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CartBloc, CartState>(
        listenWhen: (previous, current) => current is CartAfterState,
        buildWhen: (previous, current) => current is! CartAfterState,
        builder: (context, state) {
          if (state is CartSuccessFetchItem) {
            if (state.item.isNotEmpty) {
              return _buildBody(state.item);
            } else {
              return const Align(
                alignment: Alignment.center,
                child: Text('Cart Item Not Found'),
              );
            }
          }
          return const SizedBox();
        },
        listener: (context, state) {
          if (state is CartDeletedState) {
            const snackBar =
                SnackBar(content: Text('Item has been successfully deleted'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
      ),
    );
  }

  Widget _buildBody(List<CartItemModel> data) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const Text(
            'Cart',
            style: AppTheme.header1,
          ),
          verticalSpacing(16),
          ListView.separated(
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(index.toString()),
                  background: Container(
                    color: Colors.red,
                    child: const Icon(
                      Icons.delete,
                      color: AppColor.whiteColor,
                    ),
                  ),
                  onDismissed: (direction) {
                    context
                        .read<CartBloc>()
                        .add(CartDeletedEvent(data[index].id));
                    context.read<CartBloc>().add(CartInitialEvent());
                  },
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, AppRouter.detailProduct,
                          arguments: int.parse(data[index].productId!));
                    },
                    leading: SizedBox(
                      height: 50,
                      width: 50,
                      child: CachedNetworkImage(
                        imageUrl: data[index].productImage!,
                      ),
                    ),
                    subtitle: Text('\$ ${data[index].productPrice!}'),
                    title: Text(data[index].productName!),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return verticalSpacing(16);
              },
              itemCount: data.length),
        ],
      ),
    );
  }
}
