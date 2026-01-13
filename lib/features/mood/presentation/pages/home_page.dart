import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../cubit/mood_list_cubit.dart';
import '../widgets/mood_card.dart';
import '../widgets/empty_state.dart';
import 'add_mood_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<MoodListCubit>().watchMoods();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.appTitle,
              style: theme.textTheme.headlineMedium,
            ),
            Text(
              DateFormat('EEEE, MMMM d').format(DateTime.now()),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.secondary,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ).animate().fadeIn(delay: 200.ms).scale(delay: 200.ms),
        ],
      ),
      body: BlocBuilder<MoodListCubit, MoodListState>(
        builder: (context, state) {
          if (state is MoodListLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: theme.colorScheme.primary,
              ),
            );
          }

          if (state is MoodListError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: AppColors.error.withOpacity(0.5),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Something went wrong',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    state.message,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.secondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          if (state is MoodListLoaded) {
            if (state.moods.isEmpty) {
              return const EmptyState();
            }

            return ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: state.moods.length,
              itemBuilder: (context, index) {
                final mood = state.moods[index];
                return MoodCard(
                      mood: mood,
                      onDelete: () {
                        context.read<MoodListCubit>().removeMood(mood.id);
                      },
                    )
                    .animate()
                    .fadeIn(delay: (100 * index).ms, duration: 400.ms)
                    .slideY(
                      begin: 0.2,
                      end: 0,
                      delay: (100 * index).ms,
                      duration: 400.ms,
                      curve: Curves.easeOutCubic,
                    );
              },
            );
          }

          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddMoodPage()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Mood'),
      ).animate().fadeIn(delay: 300.ms).scale(delay: 300.ms),
    );
  }
}
