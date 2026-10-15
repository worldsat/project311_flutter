import 'package:flutter/material.dart';
import 'nova_colors.dart';

class NovaTheme {
  static ThemeData get lightTheme {
    final colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: NovaColors.primary,
      onPrimary: NovaColors.onPrimary,
      primaryContainer: NovaColors.primaryContainer,
      onPrimaryContainer: NovaColors.onPrimaryContainer,
      secondary: NovaColors.secondary,
      onSecondary: NovaColors.onSecondary,
      secondaryContainer: NovaColors.secondaryContainer,
      onSecondaryContainer: NovaColors.onSecondaryContainer,
      error: NovaColors.error,
      onError: Colors.white,
      errorContainer: NovaColors.errorContainer,
      onErrorContainer: NovaColors.onErrorContainer,
      surface: NovaColors.surface,
      onSurface: NovaColors.onSurface,
      onSurfaceVariant: NovaColors.onSurfaceVariant,
      surfaceContainerHighest: NovaColors.surfaceContainerHighest,
      outline: NovaColors.outline,
      outlineVariant: NovaColors.outlineVariant,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: NovaColors.surface,
      fontFamily: 'Roboto',
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: NovaColors.onSurface,
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return NovaColors.outline;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return NovaColors.switchTrack;
          }
          return NovaColors.surfaceVariant;
        }),
      ),
    );
  }
}
