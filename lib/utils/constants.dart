import 'package:flutter/material.dart';

class AppColors {
  // Modern Palette
  static const Color primary = Color(0xFF6366F1); // Indigo
  static const Color secondary = Color(0xFFA5B4FC); // Light Indigo
  static const Color background = Color(0xFF0F172A); // Dark Slate
  static const Color surface = Color(0xFF1E293B); // Slate
  static const Color accent = Color(0xFF8B5CF6); // Violet
  static const Color text = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color error = Color(0xFFEF4444);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, accent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient scanLineGradient = LinearGradient(
    colors: [Colors.transparent, Color(0xFFEF4444), Colors.transparent],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}

class AppTextStyles {
  // Defined mostly by GoogleFonts in main.dart, but here for reference
}
