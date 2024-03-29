part of 'signin_bloc.dart';

abstract class SigninEvent extends Equatable {
  const SigninEvent();

  @override
  List<Object> get props => [];
}

class SignInEventInitial extends SigninEvent {}

class SignInUser extends SigninEvent {
  final SignInParams params;

  const SignInUser(this.params);
}