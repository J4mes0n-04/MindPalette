import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/constants/mood_constants.dart';

class MoodDistributionChart extends StatelessWidget {
  final Map<String, int> moodCounts;

  const MoodDistributionChart({
    super.key,
    required this.moodCounts,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final total = moodCounts.values.fold(0, (sum, count) => sum + count);

    if (total == 0) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xxl),
          child: Center(
            child: Text(
              'No data available',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.secondary,
              ),
            ),
          ),
        ),
      );
    }

    final sections = MoodType.values.asMap().entries.map((entry) {
      final type = entry.value;
      final count = moodCounts[type.name] ?? 0;
      final percentage = (count / total * 100);

      return PieChartSectionData(
        color: MoodColorPalette.getColor(type),
        value: count.toDouble(),
        title: count > 0 ? '${percentage.toStringAsFixed(0)}%' : '',
        radius: 80,
        titleStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      );
    }).toList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: sections,
                  centerSpaceRadius: 50,
                  sectionsSpace: 2,
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            
            // Legend
            Wrap(
              spacing: AppSpacing.md,
              runSpacing: AppSpacing.sm,
              children: MoodType.values.map((type) {
                final count = moodCounts[type.name] ?? 0;
                final color = MoodColorPalette.getColor(type);
                final name = MoodNames.getName(type);
                final emoji = MoodEmojis.getEmoji(type);

                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      '$emoji $name',
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      '($count)',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}