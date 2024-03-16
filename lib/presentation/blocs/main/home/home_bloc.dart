import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/core/error/failures.dart';
import 'package:bloc_clean_architecture/data/data_source/local/user_local_data_source.dart';
import 'package:bloc_clean_architecture/domain/entities/category/categories.dart';
import 'package:bloc_clean_architecture/domain/entities/products/products.dart';
import 'package:bloc_clean_architecture/domain/entities/user/user_profile.dart';
import 'package:bloc_clean_architecture/domain/usecases/category/get_category_usecase.dart';
import 'package:bloc_clean_architecture/domain/usecases/products/get_product_usecase.dart';
import 'package:bloc_clean_architecture/domain/usecases/products/get_products_by_category.dart';
import 'package:bloc_clean_architecture/domain/usecases/user/get_profile_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetProductUseCase getProductUseCase;
  final GetCategoryUseCase getCategoryUseCase;
  final GetProfileUserUseCase getProfileUserUseCase;
  final GetProductsByCategory getProductsByCategory;
  final FlutterSecureStorage secureStorage;

  HomeBloc(
      this.getProductUseCase,
      this.getCategoryUseCase,
      this.getProfileUserUseCase,
      this.secureStorage,
      this.getProductsByCategory)
      : super(HomeInitial()) {
    on<HomeFetchDataEvent>(onHomeFetchDataEvent);
    on<HomeFetchProductDataByCategoryEvent>(
        onHomeFetchProductDataByCategoryEvent);
  }

  void onHomeFetchDataEvent(
      HomeFetchDataEvent event, Emitter<HomeState> emit) async {
    try {
      emit(HomeLoadingFetchData());
      String? token = await secureStorage.read(key: cachedToken);
      final resultUserProfile = await getProfileUserUseCase(token!);
      final resultProduct = await getProductUseCase(event.props);
      final resultCategory = await getCategoryUseCase(event.props);
      resultUserProfile.fold(
          (failUser) => emit(HomeFailedFetchData(failure: failUser)), (user) {
        return resultProduct.fold(
            (failProduct) => emit(HomeFailedFetchData(failure: failProduct)),
            (product) {
          return resultCategory.fold(
              (failCategory) =>
                  emit(HomeFailedFetchData(failure: failCategory)),
              (category) => emit(HomeSuccessFetchData(
                  products: product, categories: category, user: user)));
        });
      });
    } catch (e) {
      emit(HomeFailedFetchData(failure: ExceptionFailure()));
    }
  }

  void onHomeFetchProductDataByCategoryEvent(
      HomeFetchProductDataByCategoryEvent event,
      Emitter<HomeState> emit) async {
    try {
      emit(HomeFetchProductByCategoryLoadingState());
      final productCategoryResult = await getProductsByCategory(event.id);
      productCategoryResult.fold(
        (l) => emit(HomeFetchProductByCategoryFailedState(l)),
        (r) => emit(
          HomeFetchProductByCategorySuccessState(r),
        ),
      );
    } catch (e) {
      emit(HomeFetchProductByCategoryFailedState(ExceptionFailure()));
    }
  }
}
