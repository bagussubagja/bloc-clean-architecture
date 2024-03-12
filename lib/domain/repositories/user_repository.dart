import 'package:bloc_clean_architecture/core/error/failures.dart';
import 'package:bloc_clean_architecture/data/models/user/auth_signin_response_model.dart';
import 'package:bloc_clean_architecture/data/models/user/auth_signup_response_model.dart';
import 'package:bloc_clean_architecture/domain/entities/user/user_profile.dart';
import 'package:bloc_clean_architecture/domain/entities/user/user_signin.dart';
import 'package:bloc_clean_architecture/domain/entities/user/user_signup.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, UserSignIn>> signIn(SignInParams params);
  Future<Either<Failure, UserSignUp>> signUp(SignUpParams params);
  Future<Either<Failure, UserProfile>> userProfile(String token);
}