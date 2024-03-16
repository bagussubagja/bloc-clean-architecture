import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/core/error/failures.dart';
import 'package:bloc_clean_architecture/domain/entities/products/detail_product.dart';
import 'package:bloc_clean_architecture/domain/usecases/products/get_detail_product_usecase.dart';
import 'package:equatable/equatable.dart';

part 'detail_product_event.dart';
part 'detail_product_state.dart';

class DetailProductBloc extends Bloc<DetailProductEvent, DetailProductState> {
  final GetDetailProductUseCase getDetailProductUseCase;
  DetailProductBloc(this.getDetailProductUseCase)
      : super(DetailProductInitial()) {
    on<DetailProductFetchDataEvent>(onDetailProductFetchDataEvent);
  }

  void onDetailProductFetchDataEvent(
      DetailProductFetchDataEvent event, Emitter<DetailProductState> emit) async{
        emit(DetailProductLoadingFetchState());
        try {
          final result = await getDetailProductUseCase(event.id);
          result.fold((l) => emit(DetailProductFailedFetchState(failure: l)), (r) => emit(DetailProductSuccessFetchState(detailProduct: r)));
        } catch (e) {
          emit(DetailProductFailedFetchState(failure: ExceptionFailure()));
        }
      }
}
