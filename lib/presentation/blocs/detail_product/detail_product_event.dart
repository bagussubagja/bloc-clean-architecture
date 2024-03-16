part of 'detail_product_bloc.dart';

abstract class DetailProductEvent extends Equatable {
  const DetailProductEvent();

  @override
  List<Object> get props => [];
}

class DetailProductFetchDataEvent extends DetailProductEvent {
  final int id;

  const DetailProductFetchDataEvent({required this.id});
}
