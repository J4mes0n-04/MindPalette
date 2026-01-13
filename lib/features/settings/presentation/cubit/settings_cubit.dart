import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  void toggleTheme() {
    emit(state.copyWith(isDarkMode: !state.isDarkMode));
  }

  void toggleNotifications() {
    emit(state.copyWith(notificationsEnabled: !state.notificationsEnabled));
  }

  void setLocale(Locale locale) {
    emit(state.copyWith(locale: locale));
  }

  void exportData() {
    // TODO: Implement data export
    emit(state.copyWith(lastExportDate: DateTime.now()));
  }
}
