import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/theme/app_theme.dart';
import 'core/di/injection.dart';
import 'core/navigation/app_navigation.dart';
import 'features/mood/data/models/mood_model.dart';
import 'features/mood/presentation/cubit/mood_list_cubit.dart';
import 'features/mood/presentation/cubit/add_mood_cubit.dart';
import 'features/statistics/presentation/cubit/statistics_cubit.dart';
import 'features/settings/presentation/cubit/settings_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(MoodModelAdapter());

  // Initialize dependencies
  await Injection.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MoodListCubit(
            getMoodsByDate: Injection.getMoodsByDate,
            deleteMood: Injection.deleteMood,
            repository: Injection.moodRepository,
          ),
        ),
        BlocProvider(
          create: (context) => AddMoodCubit(
            addMood: Injection.addMood,
          ),
        ),
        BlocProvider(
          create: (context) => StatisticsCubit(
            getMoodsByDateRange: Injection.getMoodsByDateRange,
            repository: Injection.moodRepository,
          ),
        ),
        BlocProvider(
          create: (context) => SettingsCubit(),
        ),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, settingsState) {
          return MaterialApp(
            title: 'MindPalette',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: settingsState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const AppNavigation(),
          );
        },
      ),
    );
  }
}