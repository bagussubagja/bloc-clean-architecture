part of 'signup_bloc.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

abstract class SignUpAfterState extends SignupState {}

class SignupInitial extends SignupState {}

class SignUpLoadingState extends SignUpAfterState {}

class SignUpSuccessState extends SignUpAfterState {}

class SignUpFailedState extends SignUpAfterState {
  final Failure failure;

  SignUpFailedState(this.failure);
}
