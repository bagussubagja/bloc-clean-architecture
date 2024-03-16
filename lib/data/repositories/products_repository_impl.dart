import 'package:bloc_clean_architecture/core/error/failures.dart';
import 'package:bloc_clean_architecture/data/data_source/remote/product_remote_data_source.dart';
import 'package:bloc_clean_architecture/data/models/product/products_model.dart';
import 'package:bloc_clean_architecture/domain/entities/products/detail_product.dart';

import 'package:dartz/dartz.dart';

import '../../domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;

  ProductRepositoryImpl({required this.productRemoteDataSource});
  @override
  Future<Either<Failure, List<ProductsModel>>> getProducts() async {
    try {
      final products = await productRemoteDataSource.getProducts();
      return Right(products);
    } catch (e) {
      return Left(ExceptionFailure());
    }
  }

  @override
  Future<Either<Failure, DetailProduct>> getDetailProduct(int id) async {
    try {
      final detailProduct = await productRemoteDataSource.getDetailProduct(id);
      return Right(detailProduct);
    } catch (e) {
      return Left(ExceptionFailure());
    }
  }
}
