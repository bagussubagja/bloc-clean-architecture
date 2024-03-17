part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

abstract class CartAfterState extends CartState {}

class CartInitial extends CartState {}

class CartLoadingFetchItem extends CartState {}

class CartSuccessFetchItem extends CartState {
  final List<CartItemModel> item;

  const CartSuccessFetchItem(this.item);
}

class CartFailedFetchItem extends CartState {
  final Failure failure;

  const CartFailedFetchItem(this.failure);
}

class CartDeletedState extends CartAfterState {}
