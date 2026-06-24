import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppColorScheme {
  static const dark = ColorScheme.dark(
    // ── Core roles ───────────────────────────────────────────────────────────
    primary: AppColors.goldPrimary, // buttons, FAB, active icons
    onPrimary: AppColors.textOnGold, // content ON primary-coloured things
    primaryContainer: AppColors.goldSubtle, // chips, selected tabs bg
    onPrimaryContainer: AppColors.goldLight, // content inside primaryContainer

    secondary: AppColors.goldLight,
    onSecondary: AppColors.textOnGold,
    secondaryContainer: AppColors.surfaceElevated,
    onSecondaryContainer: AppColors.textPrimary,

    // ── Surfaces ─────────────────────────────────────────────────────────────
    surface: AppColors.surfaceCard,
    onSurface: AppColors.textPrimary,
    surfaceContainerHighest: AppColors.surfaceElevated,

    // ── Semantic ─────────────────────────────────────────────────────────────
    error: AppColors.error,
    onError: AppColors.textOnGold,

    // ── Outlines / dividers ──────────────────────────────────────────────────
    outline: AppColors.divider,
    outlineVariant: AppColors.surfaceElevated,

    // ── Text helpers ─────────────────────────────────────────────────────────
    onSurfaceVariant: AppColors.textSecondary,
  );
}
