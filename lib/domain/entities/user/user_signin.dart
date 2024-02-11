import 'package:equatable/equatable.dart';

class UserSignIn extends Equatable {
  final String accessToken;
  final String refreshToken;

  const UserSignIn({required this.accessToken, required this.refreshToken});

  @override
  List<Object?> get props => [accessToken, refreshToken];
}
