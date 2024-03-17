import 'package:bloc_clean_architecture/core/error/failures.dart';
import 'package:bloc_clean_architecture/core/usecases/usecase.dart';
import 'package:bloc_clean_architecture/data/models/user/auth_signup_response_model.dart';
import 'package:bloc_clean_architecture/domain/entities/user/user_signup.dart';
import 'package:dartz/dartz.dart';

import '../../repositories/user_repository.dart';

class SignUpUsecase implements UseCase<UserSignUp, SignUpParams> {
  final UserRepository repository;

  SignUpUsecase(this.repository);

  @override
  Future<Either<Failure, UserSignUp>> call(SignUpParams params) async {
    return await repository.signUp(params);
  }
}
