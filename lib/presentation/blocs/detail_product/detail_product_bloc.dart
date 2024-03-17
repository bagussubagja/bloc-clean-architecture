import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/core/error/failures.dart';
import 'package:bloc_clean_architecture/data/models/product/cart_item_model.dart';
import 'package:bloc_clean_architecture/domain/entities/products/detail_product.dart';
import 'package:bloc_clean_architecture/domain/usecases/products/get_detail_product_usecase.dart';
import 'package:equatable/equatable.dart';

import '../../../data/data_source/local/local_database_data_source.dart';

part 'detail_product_event.dart';
part 'detail_product_state.dart';

class DetailProductBloc extends Bloc<DetailProductEvent, DetailProductState> {
  final GetDetailProductUseCase getDetailProductUseCase;
  final LocalDatabaseDataSource localDatabaseDataSource;

  DetailProductBloc(this.getDetailProductUseCase, this.localDatabaseDataSource)
      : super(DetailProductInitial()) {
    on<DetailProductFetchDataEvent>(onDetailProductFetchDataEvent);
    on<DetailProductAddToCartEvent>(onDetailProductAddToCartEvent);
  }

  void onDetailProductFetchDataEvent(DetailProductFetchDataEvent event,
      Emitter<DetailProductState> emit) async {
    emit(DetailProductLoadingFetchState());
    try {
      final result = await getDetailProductUseCase(event.id);
      result.fold((l) => emit(DetailProductFailedFetchState(failure: l)),
          (r) => emit(DetailProductSuccessFetchState(detailProduct: r)));
    } catch (e) {
      emit(DetailProductFailedFetchState(failure: ExceptionFailure()));
    }
  }

  void onDetailProductAddToCartEvent(DetailProductAddToCartEvent event,
      Emitter<DetailProductState> emit) async {
    try {
      await localDatabaseDataSource.createCartItem(event.cartItemModel);
      emit(DetailProductAddItemToCartSuccessState());
    } catch (e) {
      emit(DetailProductAddItemToCartFailedState(e.toString()));
    }
  }
}
