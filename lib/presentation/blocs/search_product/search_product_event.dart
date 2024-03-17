part of 'search_product_bloc.dart';

abstract class SearchProductEvent extends Equatable {
  const SearchProductEvent();

  @override
  List<Object> get props => [];
}

class SearchProductByNameEvent extends SearchProductEvent {
  final String name;

  const SearchProductByNameEvent(this.name);
}
