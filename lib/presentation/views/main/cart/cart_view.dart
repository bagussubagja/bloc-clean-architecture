import 'package:bloc_clean_architecture/core/theme/app_theme.dart';
import 'package:bloc_clean_architecture/presentation/blocs/main/cart/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CartBloc, CartState>(
        builder: (context, state) {
          return _buildBody();
        },
        listener: (context, state) {},
      ),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Text(
            'Cart',
            style: AppTheme.header1,
          )
        ],
      ),
    );
  }
}
