import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/core/error/failures.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/data_source/local/local_database_data_source.dart';
import '../../../../data/models/product/cart_item_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final LocalDatabaseDataSource databaseDataSource;

  CartBloc(this.databaseDataSource) : super(CartInitial()) {
    on<CartEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<CartInitialEvent>(onCartInitialEvent);
    on<CartDeletedEvent>(onCartDeletedEvent);
  }

  void onCartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingFetchItem());
    try {
      final result = await databaseDataSource.getAllCartItem();
      print('resultresultresult $result');
      emit(CartSuccessFetchItem(result));
    } catch (e) {
      emit(CartFailedFetchItem(ExceptionFailure()));
    }
  }

  void onCartDeletedEvent(
      CartDeletedEvent event, Emitter<CartState> emit) async {
    await databaseDataSource.deleteCartItem(event.id);
    emit(CartDeletedState());
  }
}
