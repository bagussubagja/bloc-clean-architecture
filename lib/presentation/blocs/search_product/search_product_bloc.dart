import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/core/error/failures.dart';
import 'package:bloc_clean_architecture/domain/usecases/products/get_search_product_by_name.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/products/products.dart';

part 'search_product_event.dart';
part 'search_product_state.dart';

class SearchProductBloc extends Bloc<SearchProductEvent, SearchProductState> {
  final GetSearchProductByNameUseCase getSearchProductByNameUseCase;

  SearchProductBloc(this.getSearchProductByNameUseCase)
      : super(SearchProductInitial()) {
    // on<SearchProductEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
    on<SearchProductByNameEvent>(onSearchProductByNameEvent);
  }

  void onSearchProductByNameEvent(
      SearchProductByNameEvent event, Emitter<SearchProductState> emit) async {
    try {
      emit(SearchProductLoading());
      final result = await getSearchProductByNameUseCase(event.name);
      result.fold((l) => emit(SearchProductFailed(l)),
          (r) => emit(SearchProductSuccess(r)));
    } catch (e) {
      emit(SearchProductFailed(ExceptionFailure()));
    }
  }
}
