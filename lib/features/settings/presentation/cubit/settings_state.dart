part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final bool isDarkMode;
  final bool notificationsEnabled;
  final DateTime? lastExportDate;

  const SettingsState({
    this.isDarkMode = false,
    this.notificationsEnabled = true,
    this.lastExportDate,
  });

  SettingsState copyWith({
    bool? isDarkMode,
    bool? notificationsEnabled,
    DateTime? lastExportDate,
  }) {
    return SettingsState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      lastExportDate: lastExportDate ?? this.lastExportDate,
    );
  }

  @override
  List<Object?> get props => [isDarkMode, notificationsEnabled, lastExportDate];
}