import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/core/error/failures.dart';
import 'package:bloc_clean_architecture/data/models/user/auth_signin_response_model.dart';
import 'package:bloc_clean_architecture/domain/entities/user/user_signin.dart';
import 'package:bloc_clean_architecture/domain/usecases/user/sign_in_usecase.dart';
import 'package:equatable/equatable.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final SignInUseCase signInUseCase;
  SigninBloc(this.signInUseCase) : super(SigninInitial()) {
    on<SignInUser>(onSignIn);
  }

  void onSignIn(SignInUser event, Emitter<SigninState> emit) async {
    try {
      emit(SignInLoadingState());
      final result = await signInUseCase(event.params);
      result.fold(
        (l) => emit(SignInFailedState(l)),
        (r) => emit(SignInSuccessState(r)),
      );
    } catch (e) {
      emit(SignInFailedState(ExceptionFailure()));
    }
  }
}
