import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Every component-level theme in one place.
/// [AppTheme.buildThemeData] pulls these in — widget code stays clean.
abstract class AppComponentThemes {
  // ── Shared shape tokens ───────────────────────────────────────────────────
  static const _radiusSmall = BorderRadius.all(Radius.circular(8));
  static const _radiusMedium = BorderRadius.all(Radius.circular(12));
  static const _radiusLarge = BorderRadius.all(Radius.circular(16));
  static const _radiusPill = BorderRadius.all(Radius.circular(50));

  // ── AppBar ────────────────────────────────────────────────────────────────
  static const appBar = AppBarTheme(
    backgroundColor: AppColors.backgroundDark,
    foregroundColor: AppColors.textPrimary,
    surfaceTintColor: AppColors.backgroundLight,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.goldPrimary,
      letterSpacing: 0.5,
    ),
    iconTheme: IconThemeData(color: AppColors.goldPrimary),
  );

  // ── TextField / InputDecoration ───────────────────────────────────────────
  static final inputDecoration = InputDecorationTheme(
    filled: true,
    fillColor: AppColors.goldPrimary,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    // Default border
    border: OutlineInputBorder(
      borderRadius: _radiusMedium,
      borderSide: const BorderSide(color: AppColors.divider),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: _radiusMedium,
      borderSide: const BorderSide(color: AppColors.divider),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: _radiusMedium,
      borderSide: const BorderSide(color: AppColors.goldSubtle, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: _radiusMedium,
      borderSide: const BorderSide(color: AppColors.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: _radiusMedium,
      borderSide: const BorderSide(color: AppColors.error, width: 1.5),
    ),
    labelStyle: const TextStyle(color: AppColors.goldSubtle, fontSize: 14),
    hintStyle: const TextStyle(color: AppColors.goldSubtle, fontSize: 14),
    floatingLabelStyle: const TextStyle(
      color: AppColors.goldLight,
      fontSize: 12,
    ),
    prefixIconColor: AppColors.goldSubtle,
    suffixIconColor: AppColors.goldSubtle,
  );

  // ── TextSelection ─────────────────────────────────────────────────────────
  static final textSelection = TextSelectionThemeData(
    cursorColor: AppColors.bluish,
    selectionColor: AppColors.bluish,
    selectionHandleColor: AppColors.bluish,
  );

  // ── DropdownMenu ──────────────────────────────────────────────────────────
  static final dropdownMenu = DropdownMenuThemeData(
    inputDecorationTheme: inputDecoration,
    menuStyle: MenuStyle(
      backgroundColor: WidgetStatePropertyAll(AppColors.surfaceCard),
      elevation: const WidgetStatePropertyAll(4),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: _radiusMedium),
      ),
    ),
  );

  // ── ElevatedButton ────────────────────────────────────────────────────────
  static final elevatedButton = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: AppColors.textOnGold,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      disabledBackgroundColor: AppColors.bluish,
      disabledForegroundColor: AppColors.textOnGold,
      backgroundBuilder: (context, states, child) {
        return Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1),
            gradient: const LinearGradient(
              colors: [AppColors.goldPrimary, AppColors.goldSubtle],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: child,
        );
      },
      elevation: 0,
      shape: const RoundedRectangleBorder(borderRadius: _radiusPill),
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
      textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
    ),
  );

  // ── OutlinedButton ────────────────────────────────────────────────────────
  static final outlinedButton = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.goldPrimary,
      side: const BorderSide(color: AppColors.goldPrimary),
      shape: const RoundedRectangleBorder(borderRadius: _radiusPill),
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
      textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
    ),
  );

  // ── TextButton ────────────────────────────────────────────────────────────
  static final textButton = TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.goldLight,
      textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    ),
  );

  // ── FloatingActionButton ──────────────────────────────────────────────────
  static final fab = FloatingActionButtonThemeData(
    backgroundColor: AppColors.goldPrimary,
    foregroundColor: AppColors.textOnGold,
    elevation: 4,
    shape: const RoundedRectangleBorder(borderRadius: _radiusLarge),
  );

  // ── Card ──────────────────────────────────────────────────────────────────
  static final card = CardThemeData(
    color: AppColors.surfaceCard,
    elevation: 0,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: _radiusLarge,
      side: const BorderSide(color: AppColors.divider, width: 0.5),
    ),
  );

  // ── BottomNavigationBar ───────────────────────────────────────────────────
  static const bottomNav = BottomNavigationBarThemeData(
    backgroundColor: AppColors.backgroundLight,
    selectedItemColor: AppColors.goldPrimary,
    unselectedItemColor: AppColors.textSecondary,
    elevation: 0,
    type: BottomNavigationBarType.fixed,
    selectedLabelStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
    unselectedLabelStyle: TextStyle(fontSize: 11),
  );

  // ── NavigationBar (Material 3) ────────────────────────────────────────────
  static final navigationBar = NavigationBarThemeData(
    backgroundColor: AppColors.surfaceCard,
    indicatorColor: AppColors.goldSubtle,
    iconTheme: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const IconThemeData(color: AppColors.goldLight);
      }
      return const IconThemeData(color: AppColors.textSecondary);
    }),
    labelTextStyle: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const TextStyle(
          color: AppColors.goldPrimary,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        );
      }
      return const TextStyle(color: AppColors.textSecondary, fontSize: 11);
    }),
  );

  // ── Chip ──────────────────────────────────────────────────────────────────
  static final chip = ChipThemeData(
    backgroundColor: AppColors.surfaceElevated,
    selectedColor: AppColors.goldSubtle,
    disabledColor: AppColors.surfaceCard,
    labelStyle: const TextStyle(color: AppColors.textPrimary, fontSize: 13),
    secondaryLabelStyle: const TextStyle(
      color: AppColors.goldLight,
      fontSize: 13,
    ),
    side: const BorderSide(color: AppColors.divider, width: 0.5),
    shape: const RoundedRectangleBorder(borderRadius: _radiusPill),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
  );

  // ── Switch ────────────────────────────────────────────────────────────────
  static final switchTheme = SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return AppColors.textOnGold;
      return AppColors.textSecondary;
    }),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return AppColors.goldPrimary;
      return AppColors.surfaceElevated;
    }),
  );

  // ── Checkbox ──────────────────────────────────────────────────────────────
  static final checkbox = CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return AppColors.goldPrimary;
      return Colors.transparent;
    }),
    checkColor: const WidgetStatePropertyAll(AppColors.textOnGold),
    side: const BorderSide(color: AppColors.textSecondary, width: 1.5),
    shape: const RoundedRectangleBorder(borderRadius: _radiusSmall),
  );

  // ── Slider ────────────────────────────────────────────────────────────────
  static const slider = SliderThemeData(
    activeTrackColor: AppColors.goldPrimary,
    inactiveTrackColor: AppColors.divider,
    thumbColor: AppColors.goldLight,
    overlayColor: Color(0x29C9A27C), // goldPrimary @ 16% opacity
    valueIndicatorColor: AppColors.goldPrimary,
    valueIndicatorTextStyle: TextStyle(color: AppColors.textOnGold),
  );

  // ── Dialog ────────────────────────────────────────────────────────────────
  static final dialog = DialogThemeData(
    backgroundColor: AppColors.surfaceCard,
    elevation: 8,
    shape: const RoundedRectangleBorder(borderRadius: _radiusLarge),
    titleTextStyle: const TextStyle(
      color: AppColors.textPrimary,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    contentTextStyle: const TextStyle(
      color: AppColors.textSecondary,
      fontSize: 14,
    ),
  );

  // ── BottomSheet ───────────────────────────────────────────────────────────
  static final bottomSheet = BottomSheetThemeData(
    backgroundColor: AppColors.surfaceCard,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    dragHandleColor: AppColors.divider,
    showDragHandle: true,
  );

  // ── SnackBar ──────────────────────────────────────────────────────────────
  static final snackBar = SnackBarThemeData(
    backgroundColor: AppColors.surfaceElevated,
    contentTextStyle: const TextStyle(color: AppColors.textPrimary),
    actionTextColor: AppColors.goldPrimary,
    shape: const RoundedRectangleBorder(borderRadius: _radiusMedium),
    behavior: SnackBarBehavior.floating,
  );

  // ── Divider ───────────────────────────────────────────────────────────────
  static const divider = DividerThemeData(
    color: AppColors.divider,
    thickness: 0.5,
    space: 1,
  );

  // ── ListTile ──────────────────────────────────────────────────────────────
  static const listTile = ListTileThemeData(
    iconColor: AppColors.goldPrimary,
    textColor: AppColors.textPrimary,
    contentPadding: EdgeInsets.symmetric(horizontal: 16),
  );

  // ── TabBar ────────────────────────────────────────────────────────────────
  static const tabBar = TabBarThemeData(
    labelColor: AppColors.goldPrimary,
    unselectedLabelColor: AppColors.textSecondary,
    indicatorColor: AppColors.goldPrimary,
    indicatorSize: TabBarIndicatorSize.label,
    labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    unselectedLabelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
  );

  // ── ProgressIndicator ─────────────────────────────────────────────────────
  static const progressIndicator = ProgressIndicatorThemeData(
    color: AppColors.goldPrimary,
    linearTrackColor: AppColors.divider,
    circularTrackColor: AppColors.divider,
  );
}
