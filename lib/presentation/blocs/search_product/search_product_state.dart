part of 'search_product_bloc.dart';

abstract class SearchProductState extends Equatable {
  const SearchProductState();

  @override
  List<Object> get props => [];
}

abstract class SearchProductAfterState extends SearchProductState {}

class SearchProductInitial extends SearchProductState {}

class SearchProductLoading extends SearchProductAfterState {}

class SearchProductSuccess extends SearchProductAfterState {
  final List<Products> products;

  SearchProductSuccess(this.products);
}

class SearchProductFailed extends SearchProductAfterState {
  final Failure failure;

  SearchProductFailed(this.failure);
}
