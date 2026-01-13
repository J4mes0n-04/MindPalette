import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_spacing.dart';
import '../cubit/statistics_cubit.dart';
import '../widgets/weekly_mood_chart.dart';
import '../widgets/mood_distribution_chart.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Load statistics when the page is built for the first time
    context.read<StatisticsCubit>().loadWeeklyStatistics();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
      ),
      body: BlocBuilder<StatisticsCubit, StatisticsState>(
        builder: (context, state) {
          if (state is StatisticsLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: theme.colorScheme.primary,
              ),
            );
          }

          if (state is StatisticsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64),
                  const SizedBox(height: AppSpacing.md),
                  Text('Error: ${state.message}'),
                ],
              ),
            );
          }

          if (state is StatisticsLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                await context.read<StatisticsCubit>().loadWeeklyStatistics();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Weekly Overview',
                      style: theme.textTheme.headlineMedium,
                    ).animate().fadeIn().slideY(begin: 0.2, end: 0),
                    const SizedBox(height: AppSpacing.md),

                    // Weekly Line Chart
                    WeeklyMoodChart(
                      moods: state.weeklyMoods,
                      startDate: state.startDate,
                      endDate: state.endDate,
                    ).animate(delay: 100.ms).fadeIn().slideY(begin: 0.2, end: 0),

                    const SizedBox(height: AppSpacing.xxl),

                    Text(
                      'Mood Distribution',
                      style: theme.textTheme.headlineMedium,
                    ).animate(delay: 200.ms).fadeIn().slideY(begin: 0.2, end: 0),
                    const SizedBox(height: AppSpacing.md),

                    // Pie Chart
                    MoodDistributionChart(
                      moodCounts: state.moodCounts,
                    ).animate(delay: 300.ms).fadeIn().scale(),
                  ],
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}