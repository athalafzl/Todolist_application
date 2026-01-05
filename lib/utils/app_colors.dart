import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF4F39F6);
  static const Color secondary = Color(0xFF2B7FFF);
  static const Color background = Color(0xFFF5F7FA);
  static const Color white = Colors.white;
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF8C8C8C);
  static const Color accent = Color(0xFF155DFC);
  static const Color delete = Color(0xFFFF4B4B);

  static const Gradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [secondary, primary],
  );
}
