import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/add_mood_cubit.dart';
import '../widgets/mood_type_selector.dart';

class AddMoodPage extends StatefulWidget {
  const AddMoodPage({super.key});

  @override
  State<AddMoodPage> createState() => _AddMoodPageState();
}

class _AddMoodPageState extends State<AddMoodPage> {
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<AddMoodCubit, AddMoodState>(
      listener: (context, state) {
        if (state is AddMoodSuccess) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Mood added successfully'),
              backgroundColor: AppColors.success,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
            ),
          );
        } else if (state is AddMoodError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('How are you feeling?'),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: BlocBuilder<AddMoodCubit, AddMoodState>(
          builder: (context, state) {
            final isSubmitting = state is AddMoodSubmitting;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Select your mood',
                    style: theme.textTheme.titleLarge,
                  ).animate().fadeIn().slideY(begin: 0.2, end: 0),
                  const SizedBox(height: AppSpacing.md),
                  
                  // Mood Type Selector
                  MoodTypeSelector(
                    selectedType: state is AddMoodInProgress
                        ? state.selectedType
                        : null,
                    onTypeSelected: (type) {
                      context.read<AddMoodCubit>().selectMoodType(type);
                    },
                  ).animate(delay: 100.ms).fadeIn().slideY(begin: 0.2, end: 0),

                  const SizedBox(height: AppSpacing.xxl),

                  Text(
                    'Add a note (optional)',
                    style: theme.textTheme.titleLarge,
                  ).animate(delay: 200.ms).fadeIn().slideY(begin: 0.2, end: 0),
                  const SizedBox(height: AppSpacing.md),

                  // Note Input
                  TextField(
                    controller: _noteController,
                    maxLines: 5,
                    maxLength: 500,
                    enabled: !isSubmitting,
                    decoration: InputDecoration(
                      hintText: 'What\'s on your mind?',
                      counterStyle: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                    onChanged: (value) {
                      context.read<AddMoodCubit>().updateNote(value);
                    },
                  ).animate(delay: 300.ms).fadeIn().slideY(begin: 0.2, end: 0),

                  const SizedBox(height: AppSpacing.xl),

                  // Submit Button
                  FilledButton(
                    onPressed: isSubmitting || state is! AddMoodInProgress
                        ? null
                        : () {
                            context.read<AddMoodCubit>().submitMood();
                          },
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.md,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                      ),
                    ),
                    child: isSubmitting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('Save Mood'),
                  ).animate(delay: 400.ms).fadeIn().scale(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}