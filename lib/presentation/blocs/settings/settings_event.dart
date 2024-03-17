part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class SettingInitialEvent extends SettingsEvent {}

class SettingLogoutEvent extends SettingsEvent {}
