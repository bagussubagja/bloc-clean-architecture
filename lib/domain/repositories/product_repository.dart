import 'package:bloc_clean_architecture/core/error/failures.dart';
import 'package:bloc_clean_architecture/domain/entities/products/detail_product.dart';
import 'package:bloc_clean_architecture/domain/entities/products/products.dart';
import 'package:dartz/dartz.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Products>>> getProducts();

  Future<Either<Failure, DetailProduct>> getDetailProduct(int id);

  Future<Either<Failure, List<Products>>> getProductByCategory(int id);

  Future<Either<Failure, List<Products>>> searchProductByName(String name);
}
