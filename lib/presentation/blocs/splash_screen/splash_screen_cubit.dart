import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/core/error/failures.dart';
import 'package:bloc_clean_architecture/core/router/app_router.dart';
import 'package:bloc_clean_architecture/data/data_source/local/user_local_data_source.dart';
import 'package:bloc_clean_architecture/domain/usecases/user/get_profile_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'splash_screen_state.dart';

class SplashScreenCubit extends Cubit<SplashScreenState> {
  final FlutterSecureStorage secureStorage;
  final GetProfileUserUseCase getProfileUserUseCase;
  SplashScreenCubit(this.secureStorage, this.getProfileUserUseCase)
      : super(SplashScreenInitial());

  void isLogin(BuildContext context) async {
    try {
      String? token = await secureStorage.read(key: cachedToken);
      print('token $token');
      final result = await getProfileUserUseCase(token ?? '');
      print('result $result');
      result.fold((notLoginState) => emit(SplashScreenMoveToLoginPage()),
          (loginState) => emit(SplashScreenMoveToMainPageState()));
    } catch (e) {
      debugPrint('$e');
    }
  }
}
