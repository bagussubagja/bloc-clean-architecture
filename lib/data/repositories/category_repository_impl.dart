import 'package:bloc_clean_architecture/core/error/failures.dart';
import 'package:bloc_clean_architecture/data/data_source/remote/category_remote_data_source.dart';
import 'package:bloc_clean_architecture/domain/entities/category/categories.dart';
import 'package:bloc_clean_architecture/domain/repositories/category_repository.dart';
import 'package:dartz/dartz.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource categoryRemoteDataSource;

  CategoryRepositoryImpl({required this.categoryRemoteDataSource});
  @override
  Future<Either<Failure, List<Categories>>> getCategories() async {
   try {
     final response = await categoryRemoteDataSource.getCategories();
     return Right(response);
   } catch (e) {
     return Left(ExceptionFailure());
   }
  }

}