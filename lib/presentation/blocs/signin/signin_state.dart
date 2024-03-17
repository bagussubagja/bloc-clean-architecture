part of 'signin_bloc.dart';

abstract class SigninState extends Equatable {
  const SigninState();

  @override
  List<Object> get props => [];
}


class SigninInitial extends SigninState {}

class SignInLoadingState extends SigninState {}

class SignInSuccessState extends SigninState {
  final UserSignIn userSignIn;

  const SignInSuccessState(this.userSignIn);
}

class SignInFailedState extends SigninState {
  final Failure failure;

  const SignInFailedState(this.failure);
}
