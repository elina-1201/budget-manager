import 'package:budget_manager/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

import 'app_color_scheme.dart';
import 'app_component_theme.dart';
import 'app_text_theme.dart';

abstract class AppTheme {
  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // ── Colour ──────────────────────────────────────────────────────────
      colorScheme: AppColorScheme.dark,
      // scaffoldBackgroundColor: const Color(0xFF2B2F3E),
      scaffoldBackgroundColor: AppColors.backgroundDark,

      // ── Typography ──────────────────────────────────────────────────────
      textTheme: AppTextTheme.values,

      // ── System UI ───────────────────────────────────────────────────────
      // Makes the Android status bar transparent & icons light-coloured.
      appBarTheme: AppComponentThemes.appBar,

      // ── Component themes ─────────────────────────────────────────────────
      inputDecorationTheme: AppComponentThemes.inputDecoration,
      elevatedButtonTheme: AppComponentThemes.elevatedButton,
      outlinedButtonTheme: AppComponentThemes.outlinedButton,
      textButtonTheme: AppComponentThemes.textButton,
      floatingActionButtonTheme: AppComponentThemes.fab,
      cardTheme: AppComponentThemes.card,
      bottomNavigationBarTheme: AppComponentThemes.bottomNav,
      navigationBarTheme: AppComponentThemes.navigationBar,
      chipTheme: AppComponentThemes.chip,
      dropdownMenuTheme: AppComponentThemes.dropdownMenu,
      switchTheme: AppComponentThemes.switchTheme,
      checkboxTheme: AppComponentThemes.checkbox,
      sliderTheme: AppComponentThemes.slider,
      dialogTheme: AppComponentThemes.dialog,
      bottomSheetTheme: AppComponentThemes.bottomSheet,
      snackBarTheme: AppComponentThemes.snackBar,
      dividerTheme: AppComponentThemes.divider,
      listTileTheme: AppComponentThemes.listTile,
      tabBarTheme: AppComponentThemes.tabBar,
      progressIndicatorTheme: AppComponentThemes.progressIndicator,
      textSelectionTheme: AppComponentThemes.textSelection,
    );
  }
}
