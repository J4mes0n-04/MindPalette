import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../l10n/app_localizations.dart';
import '../cubit/settings_cubit.dart';
import '../../../mood/data/datasources/mood_local_data_source.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.settings)),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              Text(
                AppLocalizations.of(context)!.appearance,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ).animate().fadeIn().slideY(begin: 0.2, end: 0),
              const SizedBox(height: AppSpacing.sm),

              Card(
                child: SwitchListTile(
                  title: Text(AppLocalizations.of(context)!.darkMode),
                  subtitle: const Text('Toggle dark theme'),
                  value: state.isDarkMode,
                  onChanged: (value) {
                    context.read<SettingsCubit>().toggleTheme();
                  },
                  secondary: Icon(
                    state.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                  ),
                ),
              ).animate(delay: 100.ms).fadeIn().slideY(begin: 0.2, end: 0),

              const SizedBox(height: AppSpacing.lg),

              Text(
                AppLocalizations.of(context)!.language,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ).animate(delay: 150.ms).fadeIn().slideY(begin: 0.2, end: 0),
              const SizedBox(height: AppSpacing.sm),

              Card(
                child: Column(
                  children: [
                    RadioListTile<Locale>(
                      title: Text(AppLocalizations.of(context)!.russian),
                      value: const Locale('ru'),
                      groupValue: state.locale,
                      onChanged: (value) {
                        if (value != null) {
                          context.read<SettingsCubit>().setLocale(value);
                        }
                      },
                    ),
                    RadioListTile<Locale>(
                      title: Text(AppLocalizations.of(context)!.english),
                      value: const Locale('en'),
                      groupValue: state.locale,
                      onChanged: (value) {
                        if (value != null) {
                          context.read<SettingsCubit>().setLocale(value);
                        }
                      },
                    ),
                  ],
                ),
              ).animate(delay: 200.ms).fadeIn().slideY(begin: 0.2, end: 0),

              const SizedBox(height: AppSpacing.lg),

              Text(
                AppLocalizations.of(context)!.notifications,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ).animate(delay: 200.ms).fadeIn().slideY(begin: 0.2, end: 0),
              const SizedBox(height: AppSpacing.sm),

              Card(
                child: SwitchListTile(
                  title: Text(AppLocalizations.of(context)!.dailyReminders),
                  subtitle: Text(AppLocalizations.of(context)!.getReminded),
                  value: state.notificationsEnabled,
                  onChanged: (value) {
                    context.read<SettingsCubit>().toggleNotifications();
                  },
                  secondary: const Icon(Icons.notifications_outlined),
                ),
              ).animate(delay: 300.ms).fadeIn().slideY(begin: 0.2, end: 0),

              const SizedBox(height: AppSpacing.lg),

              Text(
                AppLocalizations.of(context)!.data,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ).animate(delay: 400.ms).fadeIn().slideY(begin: 0.2, end: 0),
              const SizedBox(height: AppSpacing.sm),

              Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(AppLocalizations.of(context)!.exportData),
                      subtitle: state.lastExportDate != null
                          ? Text(
                              '${AppLocalizations.of(context)!.lastExported}: ${DateFormat('MMM d, y').format(state.lastExportDate!)}',
                            )
                          : Text(AppLocalizations.of(context)!.exportYourData),
                      leading: const Icon(Icons.download_outlined),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        context.read<SettingsCubit>().exportData();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Data export feature coming soon!'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      title: const Text('Clear All Data'),
                      subtitle: const Text('Delete all mood entries'),
                      leading: Icon(
                        Icons.delete_outline,
                        color: theme.colorScheme.error,
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Clear All Data?'),
                            content: const Text(
                              'This will permanently delete all your mood entries. This action cannot be undone.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancel'),
                              ),
                              FilledButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  final dataSource = MoodLocalDataSource();
                                  await dataSource.init();
                                  await dataSource.clearAll();
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('All data cleared'),
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  }
                                },
                                style: FilledButton.styleFrom(
                                  backgroundColor: theme.colorScheme.error,
                                ),
                                child: const Text('Delete'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ).animate(delay: 500.ms).fadeIn().slideY(begin: 0.2, end: 0),

              const SizedBox(height: AppSpacing.lg),

              Text(
                'About',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ).animate(delay: 600.ms).fadeIn().slideY(begin: 0.2, end: 0),
              const SizedBox(height: AppSpacing.sm),

              Card(
                child: Column(
                  children: [
                    const ListTile(
                      title: Text('Version'),
                      subtitle: Text('1.0.0+1'),
                      leading: Icon(Icons.info_outline),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      title: const Text('MindPalette'),
                      subtitle: const Text('A minimalist mood diary'),
                      leading: const Text('🎨', style: TextStyle(fontSize: 24)),
                      onTap: () {},
                    ),
                  ],
                ),
              ).animate(delay: 700.ms).fadeIn().slideY(begin: 0.2, end: 0),
            ],
          );
        },
      ),
    );
  }
}
