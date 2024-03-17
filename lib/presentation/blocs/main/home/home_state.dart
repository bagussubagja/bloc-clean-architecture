part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

abstract class HomeAfterState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingFetchData extends HomeState {}

class HomeSuccessFetchData extends HomeState {
  final List<Products>? products;
  final List<Categories> categories;
  final UserProfile user;

  const HomeSuccessFetchData({
    required this.products,
    required this.categories,
    required this.user,
  });
}

class HomeFailedFetchData extends HomeState {
  final Failure failure;

  const HomeFailedFetchData({required this.failure});
}

class HomeFetchProductByCategoryLoadingState extends HomeAfterState {}

class HomeFetchProductByCategorySuccessState extends HomeAfterState {
  final List<Products>? products;

  HomeFetchProductByCategorySuccessState(this.products);
}

class HomeFetchProductByCategoryFailedState extends HomeAfterState {
  final Failure failure;

  HomeFetchProductByCategoryFailedState(this.failure);
}

class HomeAddItemToCart extends HomeAfterState {}
