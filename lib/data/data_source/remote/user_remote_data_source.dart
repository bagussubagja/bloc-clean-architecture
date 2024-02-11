import 'package:bloc_clean_architecture/core/error/exceptions.dart';
import 'package:bloc_clean_architecture/core/error/failures.dart';
import 'package:bloc_clean_architecture/data/models/user/auth_signin_response_model.dart';
import 'package:bloc_clean_architecture/data/models/user/auth_signup_response_model.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDataSource {
  Future<AuthSignInResponseModel> signIn(SignInParams params);
  Future<AuthSignUpResponseModel> signUp(SignUpParams params);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});
  @override
  Future<AuthSignInResponseModel> signIn(SignInParams params) async {
    final response = await client.post(
        Uri.parse(
          'https://api.escuelajs.co/api/v1/auth/login',
        ),
        headers: {
          'Content-Type': 'application/json',
        },
        body: signInParamsToJson(params));
    print("response.body ${response.body}");
    if (response.statusCode == 201) {
      return authSignInResponseModelFromJson(response.body);
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      throw CredentialFailure();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<AuthSignUpResponseModel> signUp(SignUpParams params) async {
    final response = await client.post(
        Uri.parse(
          'https://api.escuelajs.co/api/v1/users/',
        ),
        headers: {
          'Content-Type': 'application/json',
        },
        body: signUpParamsToJson(params));
    if (response.statusCode == 201) {
      return authSignUpResponseModelFromJson(response.body);
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      throw CredentialFailure();
    } else {
      throw ServerException();
    }
  }
}
