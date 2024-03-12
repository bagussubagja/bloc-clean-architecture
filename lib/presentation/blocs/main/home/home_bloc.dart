import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/core/error/failures.dart';
import 'package:bloc_clean_architecture/domain/entities/category/categories.dart';
import 'package:bloc_clean_architecture/domain/entities/products/products.dart';
import 'package:bloc_clean_architecture/domain/usecases/category/get_category_usecase.dart';
import 'package:bloc_clean_architecture/domain/usecases/products/get_product_usecase.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetProductUseCase getProductUseCase;
  final GetCategoryUseCase getCategoryUseCase;
  HomeBloc(this.getProductUseCase, this.getCategoryUseCase)
      : super(HomeInitial()) {
    on<HomeFetchDataEvent>(onHomeFetchDataEvent);
  }

  void onHomeFetchDataEvent(
      HomeFetchDataEvent event, Emitter<HomeState> emit) async {
    try {
      emit(HomeLoadingFetchData());
      final resultProduct = await getProductUseCase(event.props);
      final resultCategory = await getCategoryUseCase(event.props);
      resultProduct.fold(
          (failProduct) => emit(HomeFailedFetchData(failure: failProduct)),
          (product) {
        return resultCategory.fold(
            (failCategory) => emit(HomeFailedFetchData(failure: failCategory)),
            (category) => emit(
                HomeSuccessFetchData(products: product, categories: category)));
      });
    } catch (e) {
      emit(HomeFailedFetchData(failure: ExceptionFailure()));
    }
  }
}
