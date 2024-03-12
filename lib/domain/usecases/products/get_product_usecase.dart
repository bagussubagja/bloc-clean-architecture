import 'package:bloc_clean_architecture/core/error/failures.dart';
import 'package:bloc_clean_architecture/core/usecases/usecase.dart';
import 'package:bloc_clean_architecture/domain/entities/products/products.dart';
import 'package:bloc_clean_architecture/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class GetProductUseCase implements UseCase<List<Products>, void>{
  final ProductRepository repository;

  GetProductUseCase({required this.repository});
  @override
  Future<Either<Failure, List<Products>>> call(void params) async {
    return await repository.getProducts();
  }

}