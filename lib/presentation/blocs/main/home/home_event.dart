part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeFetchDataEvent extends HomeEvent {
}

class HomeFetchProductDataByCategoryEvent extends HomeEvent {
  final int id;

  const HomeFetchProductDataByCategoryEvent(this.id);
}