import 'package:bloc_clean_architecture/core/error/failures.dart';
import 'package:bloc_clean_architecture/core/usecases/usecase.dart';
import 'package:bloc_clean_architecture/domain/entities/products/detail_product.dart';
import 'package:bloc_clean_architecture/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class GetDetailProductUseCase implements UseCase<DetailProduct, int> {
  final ProductRepository repository;

  GetDetailProductUseCase({required this.repository});
  @override
  Future<Either<Failure, DetailProduct>> call(int params) async {
    return await repository.getDetailProduct(params);
  }
}
