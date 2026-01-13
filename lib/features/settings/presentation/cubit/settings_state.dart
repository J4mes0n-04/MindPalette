import 'package:flutter/material.dart';

part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final bool isDarkMode;
  final bool notificationsEnabled;
  final DateTime? lastExportDate;
  final Locale? locale;

  const SettingsState({
    this.isDarkMode = false,
    this.notificationsEnabled = true,
    this.lastExportDate,
    this.locale = const Locale('ru'), // Default to Russian
  });

  SettingsState copyWith({
    bool? isDarkMode,
    bool? notificationsEnabled,
    DateTime? lastExportDate,
    Locale? locale,
  }) {
    return SettingsState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      lastExportDate: lastExportDate ?? this.lastExportDate,
      locale: locale ?? this.locale,
    );
  }

  @override
  List<Object?> get props => [isDarkMode, notificationsEnabled, lastExportDate, locale];
}