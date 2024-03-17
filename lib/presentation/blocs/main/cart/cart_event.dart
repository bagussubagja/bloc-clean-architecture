part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartInitialEvent extends CartEvent {}

class CartDeletedEvent extends CartEvent {
  final int? id;

  const CartDeletedEvent(this.id);
}
