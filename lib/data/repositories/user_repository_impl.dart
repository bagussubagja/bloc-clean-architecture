import 'package:bloc_clean_architecture/core/error/failures.dart';
import 'package:bloc_clean_architecture/data/data_source/remote/user_remote_data_source.dart';
import 'package:bloc_clean_architecture/data/models/user/auth_signin_response_model.dart';
import 'package:bloc_clean_architecture/data/models/user/auth_signup_response_model.dart';
import 'package:bloc_clean_architecture/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImpl({required this.userRemoteDataSource});
  @override
  Future<Either<Failure, AuthSignInResponseModel>> signIn(
      SignInParams params) async {
    try {
      final user = await userRemoteDataSource.signIn(params);
      return Right(user);
    } catch (e) {
      return Left(ExceptionFailure());
    }
  }

  @override
  Future<Either<Failure, AuthSignUpResponseModel>> signUp(
      SignUpParams params) async {
    try {
      final user = await userRemoteDataSource.signUp(params);
      return Right(user);
    } catch (e) {
      return Left(ExceptionFailure());
    }
  }
}
