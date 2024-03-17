part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignUpUserEvent extends SignupEvent {
  final SignUpParams userSignUp;

  const SignUpUserEvent(this.userSignUp);
}
