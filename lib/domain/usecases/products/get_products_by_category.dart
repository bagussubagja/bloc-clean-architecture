import 'package:bloc_clean_architecture/core/error/failures.dart';
import 'package:bloc_clean_architecture/core/usecases/usecase.dart';
import 'package:bloc_clean_architecture/domain/entities/products/products.dart';
import 'package:dartz/dartz.dart';

import '../../repositories/product_repository.dart';

class GetProductsByCategory implements UseCase<List<Products>, int> {
  final ProductRepository repository;

  GetProductsByCategory(this.repository);
  @override
  Future<Either<Failure, List<Products>>> call(int params) async {
    return await repository.getProductByCategory(params);
  }

}