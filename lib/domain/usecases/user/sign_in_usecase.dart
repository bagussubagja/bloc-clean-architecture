import 'package:bloc_clean_architecture/core/error/failures.dart';
import 'package:bloc_clean_architecture/core/usecases/usecase.dart';
import 'package:bloc_clean_architecture/data/models/user/auth_signin_response_model.dart';
import 'package:bloc_clean_architecture/domain/entities/user/user_signin.dart';
import 'package:bloc_clean_architecture/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class SignInUseCase implements UseCase<UserSignIn, SignInParams> {
  final UserRepository repository;

  SignInUseCase(this.repository);

  @override
  Future<Either<Failure, UserSignIn>> call(
      SignInParams params) async {
    return await repository.signIn(params);
  }
}
