import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Mood Type Definitions
enum MoodType {
  calm,
  joy,
  anxiety,
  fatigue,
  excitement,
}

/// Mood Emoji Definitions
class MoodEmojis {
  static const String calm = '😌';
  static const String joy = '😊';
  static const String anxiety = '😰';
  static const String fatigue = '😴';
  static const String excitement = '🤩';

  static const Map<MoodType, String> emojiMap = {
    MoodType.calm: calm,
    MoodType.joy: joy,
    MoodType.anxiety: anxiety,
    MoodType.fatigue: fatigue,
    MoodType.excitement: excitement,
  };

  static String getEmoji(MoodType type) => emojiMap[type] ?? calm;
}

/// Mood Color Definitions
class MoodColorPalette {
  static const Map<MoodType, Color> colorMap = {
    MoodType.calm: AppColors.calm,
    MoodType.joy: AppColors.joy,
    MoodType.anxiety: AppColors.anxiety,
    MoodType.fatigue: AppColors.fatigue,
    MoodType.excitement: AppColors.excitement,
  };

  static Color getColor(MoodType type) => colorMap[type] ?? AppColors.calm;
}

/// Mood Display Names
class MoodNames {
  static const Map<MoodType, String> nameMap = {
    MoodType.calm: 'Calm',
    MoodType.joy: 'Joy',
    MoodType.anxiety: 'Anxiety',
    MoodType.fatigue: 'Fatigue',
    MoodType.excitement: 'Excitement',
  };

  static String getName(MoodType type) => nameMap[type] ?? 'Unknown';
}