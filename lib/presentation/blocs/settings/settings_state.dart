part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingLoadingState extends SettingsState {}

class SettingSuccessState extends SettingsState {
  final UserProfile user;

  const SettingSuccessState(this.user);
}

class SettingFailedState extends SettingsState {
  final Failure failure;

  const SettingFailedState(this.failure);
}

class SettingToLogout extends SettingsState {}
