import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/constants/mood_constants.dart';

class MoodTypeSelector extends StatelessWidget {
  final MoodType? selectedType;
  final ValueChanged<MoodType> onTypeSelected;

  const MoodTypeSelector({
    super.key,
    this.selectedType,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.md,
      children: MoodType.values.map((type) {
        final isSelected = type == selectedType;
        final color = MoodColorPalette.getColor(type);
        final emoji = MoodEmojis.getEmoji(type);
        final name = MoodNames.getName(type);

        return GestureDetector(
          onTap: () => onTypeSelected(type),
          child: AnimatedContainer(
            duration: 300.ms,
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            decoration: BoxDecoration(
              color: isSelected
                  ? color.withOpacity(0.2)
                  : color.withOpacity(0.08),
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
              border: Border.all(
                color: isSelected
                    ? color
                    : color.withOpacity(0.2),
                width: isSelected ? 2 : 1,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: color.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  emoji,
                  style: TextStyle(
                    fontSize: isSelected ? 28 : 24,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: isSelected ? 16 : 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: color,
                  ),
                ),
              ],
            ),
          ).animate(target: isSelected ? 1 : 0).scale(
            begin: const Offset(1, 1),
            end: const Offset(1.05, 1.05),
            duration: 200.ms,
          ),
        );
      }).toList(),
    );
  }
}