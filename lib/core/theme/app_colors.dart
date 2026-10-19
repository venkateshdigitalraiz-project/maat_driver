import 'package:flutter/material.dart';

class AppColors {
  // Primary brand palette
  static const Color primary = Color(0xFF1E40AF); // Deep Sapphire
  static const Color primaryLight = Color(0xFF3B82F6); // Electric Blue
  static const Color primarySubtle = Color(0xFFEFF6FF); // Soft tint
  static const Color accent = Color(0xFF0D9488); // Modern Teal

  // Captain & Driver accents
  static const Color captainYellow = Color(0xFFFFC000); // Captain Yellow
  static const Color captainYellowDark = Color(0xFFE5A900);
  static const Color darkCard = Color(0xFF0F172A); // Driver Obsidian Black
  static const Color darkCardSurface = Color(0xFF1E293B);

  // Neutral palette
  static const Color background = Color(0xFFF8FAFC); // Slate 50
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceElevated = Color(0xFFFFFFFF);
  static const Color surfaceMuted = Color(0xFFF1F5F9); // Light Gray/Slate
  static const Color textPrimary = Color(0xFF0F172A); // Slate 900
  static const Color textSecondary = Color(0xFF475569); // Slate 600
  static const Color textMuted = Color(0xFF94A3B8); // Slate 400
  static const Color border = Color(0xFFE2E8F0); // Slate 200
  static const Color borderFocused = Color(0xFF2563EB); // Slate 500

  // Status colors
  static const Color success = Color(0xFF10B981); // Emerald
  static const Color successLight = Color(0xFFECFDF5);
  static const Color onlineGreen = Color(0xFF10B981);
  static const Color offlineRed = Color(0xFFEF4444);
  static const Color error = Color(0xFFEF4444); // Red
  static const Color errorLight = Color(0xFFFEF2F2);
  static const Color warning = Color(0xFFF59E0B); // Amber

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF1E3A8A),
      Color(0xFF2563EB),
    ],
  );

  static const LinearGradient driverDarkGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF0B132B),
      Color(0xFF1C2541),
    ],
  );

  static const LinearGradient captainYellowGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFC000),
      Color(0xFFFFA000),
    ],
  );
}
