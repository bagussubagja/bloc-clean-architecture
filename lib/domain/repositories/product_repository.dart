import 'package:bloc_clean_architecture/core/error/failures.dart';
import 'package:bloc_clean_architecture/domain/entities/products/products.dart';
import 'package:dartz/dartz.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Products>>> getProducts ();
}