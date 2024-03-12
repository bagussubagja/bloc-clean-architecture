import 'package:bloc_clean_architecture/core/error/failures.dart';
import 'package:bloc_clean_architecture/core/network/network_info.dart';
import 'package:bloc_clean_architecture/data/data_source/local/user_local_data_source.dart';
import 'package:bloc_clean_architecture/data/data_source/remote/user_remote_data_source.dart';
import 'package:bloc_clean_architecture/data/models/user/auth_signin_response_model.dart';
import 'package:bloc_clean_architecture/data/models/user/auth_signup_response_model.dart';
import 'package:bloc_clean_architecture/domain/entities/user/user_signin.dart';
import 'package:bloc_clean_architecture/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

typedef _DataSourceChooser = Future<AuthSignInResponseModel> Function();

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;
  final UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.userRemoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
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

  Future<Either<Failure, UserSignIn>> _authenticate(
    _DataSourceChooser getDataSource,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteResponse = await getDataSource();
        localDataSource.saveToken(remoteResponse.refreshToken);
        localDataSource.saveUser(remoteResponse);
        return Right(remoteResponse);
      } on Failure catch (failure) {
        return Left(failure);
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
