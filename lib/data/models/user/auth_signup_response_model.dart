// To parse this JSON data, do
//
//     final authSignUpResponseModel = authSignUpResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:bloc_clean_architecture/domain/entities/user/user_signup.dart';

AuthSignUpResponseModel authSignUpResponseModelFromJson(String str) =>
    AuthSignUpResponseModel.fromJson(json.decode(str));

String authSignUpResponseModelToJson(AuthSignUpResponseModel data) =>
    json.encode(data.toJson());

class AuthSignUpResponseModel extends UserSignUp {
  // String? email;
  // String? password;
  // String? name;
  // String? avatar;
  // String? role;
  // int? id;
  // DateTime? creationAt;
  // DateTime? updatedAt;

  // AuthSignUpResponseModel({
  //     this.email,
  //     this.password,
  //     this.name,
  //     this.avatar,
  //     this.role,
  //     this.id,
  //     this.creationAt,
  //     this.updatedAt,
  // });

  AuthSignUpResponseModel(
      {required String email,
      required String password,
      required String name,
      required String avatar,
      required String role,
      required int id,
      DateTime? creationAt,
      DateTime? updatedAt})
      : super(
            avatar: avatar,
            creationAt: creationAt ?? DateTime.now(),
            email: email,
            id: id,
            name: name,
            password: password,
            role: role,
            updatedAt: DateTime.now());

  factory AuthSignUpResponseModel.fromJson(Map<String, dynamic> json) =>
      AuthSignUpResponseModel(
        email: json["email"],
        password: json["password"],
        name: json["name"],
        avatar: json["avatar"],
        role: json["role"],
        id: json["id"],
        creationAt: json["creationAt"] == null
            ? null
            : DateTime.parse(json["creationAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "name": name,
        "avatar": avatar,
        "role": role,
        "id": id,
        "creationAt": creationAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

SignUpParams signUpParamsFromJson(String str) =>
    SignUpParams.fromJson(json.decode(str));

String signUpParamsToJson(SignUpParams data) => json.encode(data.toJson());

class SignUpParams {
  String? name;
  String? email;
  String? password;
  String? avatar;

  SignUpParams({
    this.name,
    this.email,
    this.password,
    this.avatar,
  });

  factory SignUpParams.fromJson(Map<String, dynamic> json) => SignUpParams(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "avatar": avatar,
      };
}
