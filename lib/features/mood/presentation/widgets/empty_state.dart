import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../l10n/app_localizations.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '🎨',
              style: const TextStyle(fontSize: 80),
            ).animate().fadeIn().scale(),
            const SizedBox(height: AppSpacing.lg),
            Text(
              AppLocalizations.of(context)!.noMoodsToday,
              style: theme.textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ).animate(delay: 100.ms).fadeIn().slideY(begin: 0.2, end: 0),
            const SizedBox(height: AppSpacing.sm),
            Text(
              AppLocalizations.of(context)!.addFirstMood,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.secondary,
              ),
              textAlign: TextAlign.center,
            ).animate(delay: 200.ms).fadeIn().slideY(begin: 0.2, end: 0),
          ],
        ),
      ),
    );
  }
}
