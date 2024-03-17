import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/core/error/failures.dart';
import 'package:bloc_clean_architecture/data/models/user/auth_signup_response_model.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/user/sign_up_usecase.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignUpUsecase signUpUseCase;

  SignupBloc(this.signUpUseCase) : super(SignupInitial()) {
    on<SignUpUserEvent>(onSignUpUserEvent);
  }

  void onSignUpUserEvent(
      SignUpUserEvent event, Emitter<SignupState> emit) async {
    try {
      final result = await signUpUseCase(event.userSignUp);
      result.fold(
          (l) => emit(SignUpFailedState(l)), (r) => emit(SignUpSuccessState()));
    } catch (e) {
      emit(SignUpFailedState(ExceptionFailure()));
    }
  }
}
