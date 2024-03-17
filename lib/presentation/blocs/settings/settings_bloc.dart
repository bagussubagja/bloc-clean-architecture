import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/core/error/failures.dart';
import 'package:bloc_clean_architecture/data/models/product/cart_item_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../data/data_source/local/local_database_data_source.dart';
import '../../../data/data_source/local/user_local_data_source.dart';
import '../../../domain/entities/user/user_profile.dart';
import '../../../domain/usecases/user/get_profile_usecase.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetProfileUserUseCase userUseCase;
  final FlutterSecureStorage secureStorage;
  final UserLocalDataSource userLocalDataSource;
  final LocalDatabaseDataSource localDatabaseDataSource;

  SettingsBloc(this.userUseCase, this.secureStorage, this.userLocalDataSource,
      this.localDatabaseDataSource)
      : super(SettingsInitial()) {
    on<SettingInitialEvent>(onSettingInitialEvent);
    on<SettingLogoutEvent>(onSettingLogoutEvent);
  }

  void onSettingInitialEvent(
      SettingInitialEvent event, Emitter<SettingsState> emit) async {
    try {
      String? token = await secureStorage.read(key: cachedToken);
      final result = await userUseCase(token!);
      result.fold((l) => emit(SettingFailedState(l)),
          (r) => emit(SettingSuccessState(r)));
    } catch (e) {
      emit(SettingFailedState(ExceptionFailure()));
    }
  }

  void onSettingLogoutEvent(
      SettingLogoutEvent event, Emitter<SettingsState> emit) async {
    await userLocalDataSource.clearCache();
    await localDatabaseDataSource.deleteDatabase(tableCart);
    emit(SettingToLogout());
  }
}
