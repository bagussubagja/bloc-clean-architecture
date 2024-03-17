import 'package:bloc_clean_architecture/core/error/failures.dart';
import 'package:bloc_clean_architecture/core/usecases/usecase.dart';
import 'package:bloc_clean_architecture/domain/entities/products/products.dart';
import 'package:bloc_clean_architecture/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class GetSearchProductByNameUseCase implements UseCase<List<Products>, String> {
  final ProductRepository repository;

  GetSearchProductByNameUseCase(this.repository);

  @override
  Future<Either<Failure, List<Products>>> call(String params) async {
    return await repository.searchProductByName(params);
  }
}
