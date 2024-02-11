import 'package:equatable/equatable.dart';

class UserSignUp extends Equatable {
  final String email;
  final String password;
  final String name;
  final String avatar;
  final String role;
  final int id;
  final DateTime creationAt;
  final DateTime updatedAt;

  const UserSignUp(
      {required this.email,
      required this.password,
      required this.name,
      required this.avatar,
      required this.role,
      required this.id,
      required this.creationAt,
      required this.updatedAt});
  @override
  List<Object?> get props => throw [
        email,
        password,
        name,
        avatar,
        role,
        id,
        creationAt,
        updatedAt,
      ];
}
