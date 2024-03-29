part of 'detail_product_bloc.dart';

abstract class DetailProductState extends Equatable {
  const DetailProductState();

  @override
  List<Object> get props => [];
}

abstract class DetailProductAfterState extends DetailProductState {}

class DetailProductInitial extends DetailProductState {}

class DetailProductLoadingFetchState extends DetailProductState {}

class DetailProductSuccessFetchState extends DetailProductState {
  final DetailProduct detailProduct;

  const DetailProductSuccessFetchState({required this.detailProduct});
}

class DetailProductFailedFetchState extends DetailProductState {
  final Failure failure;

  const DetailProductFailedFetchState({required this.failure});
}

class DetailProductAddItemToCartSuccessState extends DetailProductAfterState {}

class DetailProductAddItemToCartFailedState extends DetailProductAfterState {
  final String message;

  DetailProductAddItemToCartFailedState(this.message);
}
