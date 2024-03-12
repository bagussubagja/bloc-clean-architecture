import 'package:bloc_clean_architecture/core/error/failures.dart';
import 'package:bloc_clean_architecture/core/usecases/usecase.dart';
import 'package:bloc_clean_architecture/domain/entities/user/user_profile.dart';
import 'package:dartz/dartz.dart';

import '../../repositories/user_repository.dart';

class GetProfileUserUseCase implements UseCase<UserProfile, String> {
   final UserRepository repository;

  GetProfileUserUseCase(this.repository);
  @override
  Future<Either<Failure, UserProfile>> call(String params) async {
    return await repository.userProfile(params);
  }

}