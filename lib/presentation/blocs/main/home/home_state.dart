part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoadingFetchData extends HomeState {}

class HomeSuccessFetchData extends HomeState {}

class HomeFailedFetchData extends HomeState {}
