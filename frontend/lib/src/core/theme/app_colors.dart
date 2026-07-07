import 'package:flutter/material.dart';

abstract class AppColors {
  // ── Backgrounds ────────────────────────────────────────────────────────────
  static const backgroundLight = Color(0xFF2B2F3E); // scaffold / page bg
  static const backgroundDark = Color(0xFF1C202D); // scaffold / page bg

  static const surfaceCard = Color(0xFF353A4D); // cards, sheets, modals
  static const surfaceElevated = Color(0xFF3D4259); // slightly lifted surfaces

  // ── Gold accent palette ────────────────────────────────────────────────────
  // static const goldPrimary = Color(0xFFC9A27C); // primary CTA, active states
  static const goldPrimary = Color(0xFFA98A6B); // primary CTA, active states
  static const goldLight = Color(0xFFEECFA7); // secondary / highlight tint
  static const goldSubtle = Color(0xFF8C6A4A); // muted / disabled gold

  // ── Text ───────────────────────────────────────────────────────────────────
  static const textPrimary = Color(0xFFD4B896); // body text on dark
  static const textSecondary = Color(0xFF8E8FA3); // captions, placeholders
  static const textOnGold = Color(0xFF1D202B); // text placed on gold buttons

  // ── Utility ────────────────────────────────────────────────────────────────
  static const divider = Color(0xFF454A60);
  static const error = Color(0xFFCF6679);
  static const errorTrans = Color.fromARGB(171, 207, 102, 121);
  static const success = Color(0xFF7BBFA5);

  static const backgroundDelete = Color(0xFF851B13);
  static const bluish = Color(0xFF7D8B8E);
}
