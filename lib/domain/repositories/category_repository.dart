import 'package:bloc_clean_architecture/core/error/failures.dart';
import 'package:bloc_clean_architecture/domain/entities/category/categories.dart';
import 'package:dartz/dartz.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<Categories>>> getCategories();
}