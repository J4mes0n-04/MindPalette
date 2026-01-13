import 'package:flutter/material.dart';

/// MindPalette Color System
class AppColors {
  // Mood Colors - Primary Palette
  static const Color calm = Color(0xFF6C63FF);       // #6C63FF - Purple/Blue
  static const Color joy = Color(0xFF00D4AA);        // #00D4AA - Teal
  static const Color anxiety = Color(0xFFFF8A65);    // #FF8A65 - Orange
  static const Color fatigue = Color(0xFFB39DDB);    // #B39DDB - Lavender
  static const Color excitement = Color(0xFFFF6B8B); // #FF6B8B - Pink/Red

  // Light Theme Colors
  static const Color lightBackground = Color(0xFFFAFAFA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceVariant = Color(0xFFF5F5F5);
  static const Color lightPrimary = calm;
  static const Color lightOnPrimary = Color(0xFFFFFFFF);
  static const Color lightOnBackground = Color(0xFF1A1A1A);
  static const Color lightOnSurface = Color(0xFF2C2C2C);
  static const Color lightSecondary = Color(0xFF757575);
  static const Color lightDivider = Color(0xFFE0E0E0);
  static const Color lightBorder = Color(0xFFEEEEEE);
  static const Color lightShadow = Color(0x1A000000);

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkSurfaceVariant = Color(0xFF2A2A2A);
  static const Color darkPrimary = calm;
  static const Color darkOnPrimary = Color(0xFFFFFFFF);
  static const Color darkOnBackground = Color(0xFFE8E8E8);
  static const Color darkOnSurface = Color(0xFFD0D0D0);
  static const Color darkSecondary = Color(0xFF9E9E9E);
  static const Color darkDivider = Color(0xFF3A3A3A);
  static const Color darkBorder = Color(0xFF2F2F2F);
  static const Color darkShadow = Color(0x33000000);

  // Semantic Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFEF5350);
  static const Color warning = Color(0xFFFFB74D);
  static const Color info = Color(0xFF42A5F5);

  // Mood Color Map
  static const Map<String, Color> moodColors = {
    'calm': calm,
    'joy': joy,
    'anxiety': anxiety,
    'fatigue': fatigue,
    'excitement': excitement,
  };

  // Get lighter shade for cards/backgrounds
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }
}