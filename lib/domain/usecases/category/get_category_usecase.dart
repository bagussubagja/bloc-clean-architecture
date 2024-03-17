import 'package:bloc_clean_architecture/core/error/failures.dart';
import 'package:bloc_clean_architecture/core/usecases/usecase.dart';
import 'package:bloc_clean_architecture/domain/entities/category/categories.dart';
import 'package:bloc_clean_architecture/domain/repositories/category_repository.dart';
import 'package:dartz/dartz.dart';

class GetCategoryUseCase implements UseCase<List<Categories>, void> {
  final CategoryRepository repository;

  GetCategoryUseCase({required this.repository});
  @override
  Future<Either<Failure, List<Categories>>> call(params) async {
    return await repository.getCategories();
  }
}
