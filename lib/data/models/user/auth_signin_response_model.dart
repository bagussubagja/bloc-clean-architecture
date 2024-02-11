// To parse this JSON data, do
//
//     final authSignInResponseModel = authSignInResponseModelFromJson(jsonString);

import 'dart:convert';

import '../../../domain/entities/user/user_signin.dart';

AuthSignInResponseModel authSignInResponseModelFromJson(String str) =>
    AuthSignInResponseModel.fromJson(json.decode(str));

String authSignInResponseModelToJson(AuthSignInResponseModel data) =>
    json.encode(data.toJson());

class AuthSignInResponseModel extends UserSignIn {

  const AuthSignInResponseModel({
    required String accessToken,
    required String refreshToken,
  }) : super(
          accessToken: accessToken,
          refreshToken: refreshToken,
        );

  factory AuthSignInResponseModel.fromJson(Map<String, dynamic> json) =>
      AuthSignInResponseModel(
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "refresh_token": refreshToken,
      };
}

SignInParams signInParamsFromJson(String str) =>
    SignInParams.fromJson(json.decode(str));

String signInParamsToJson(SignInParams data) => json.encode(data.toJson());

class SignInParams {
  String? email;
  String? password;

  SignInParams({
    this.email,
    this.password,
  });

  factory SignInParams.fromJson(Map<String, dynamic> json) => SignInParams(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
