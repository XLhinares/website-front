import "package:flutter/material.dart";
import "package:x_containers/x_containers.dart";

// MODE MANAGEMENT =============================================================

/// A preset theme for dark mode.
ThemeData defaultTheme = getTheme(
  mode: ThemeMode.dark,
  primary: const Color(0xFF464245),
  secondary: const Color(0xFFAF3131),
  surface: const Color(0xFF282627),
);

// SPECIAL COLORS ==============================================================

// TEXT COLORS -----------------------------------------------------------------

/// The color of input hints.
final Color cInputHint = Colors.grey.withAlpha(100);

// THEME GENERATOR =============================================================

/// Returns a custom theme based on simplified arguments.
ThemeData getTheme({
  Color? surface,
  Color? onSurface,
  Color? primary,
  Color? onPrimary,
  Color? secondary,
  Color? onSecondary,
  Color? tertiary,
  Color? onTertiary,
  Color? shadowColor,
  Color? splashColor,
  Color? surfaceVariant,
  ThemeMode mode = ThemeMode.dark,
  // TYPOGRAPHY & ICONOGRAPHY
  TextTheme? textTheme,
}) {
  final bool isDarkMode = mode == ThemeMode.dark;
  onPrimary = onPrimary ?? (isDarkMode ? Colors.white : Colors.black);
  onSurface = onSurface ?? (isDarkMode ? Colors.white : Colors.black);

  final TextTheme baseTextTheme =
      isDarkMode ? Typography().white : Typography().black;

  final TextTheme defaultTextTheme = baseTextTheme
      .copyWith(
        // TITLE LARGE
        titleLarge: const TextStyle().copyWith(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.15,
        ),
        // TITLE MEDIUM
        titleMedium: const TextStyle().copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.15,
        ),
        // TITLE SMALL
        titleSmall: const TextStyle().copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.15,
        ),
        // BODY LARGE
        bodyLarge: const TextStyle().copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.15,
        ),
        // BODY MEDIUM
        bodyMedium: const TextStyle().copyWith(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.15,
        ),
        // BODY SMALL
        bodySmall: const TextStyle().copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.15,
        ),
      )
      .apply(
        bodyColor: onPrimary,
        displayColor: onPrimary,
        decorationColor: onPrimary,
      );

  late final ColorScheme defaultColorScheme;
  if (primary != null && secondary != null && surface != null) {
    defaultColorScheme = isDarkMode
        ? ColorScheme.dark(
            surface: surface,
            onSurface: onSurface,
            primary: primary,
            onPrimary: onPrimary,
            secondary: secondary,
            onSecondary: onSecondary ?? onPrimary,
            tertiary: tertiary ?? secondary,
            onTertiary: onTertiary ?? onSecondary ?? onPrimary,
            shadow: shadowColor,
          )
        : ColorScheme.light(
            surface: surface,
            onSurface: onSurface,
            primary: primary,
            onPrimary: onPrimary,
            secondary: secondary,
            onSecondary: onSecondary ?? onPrimary,
            tertiary: tertiary ?? secondary,
            onTertiary: onTertiary ?? onSecondary ?? onPrimary,
            shadow: shadowColor,
          );
  } else {
    defaultColorScheme =
        isDarkMode ? const ColorScheme.dark() : const ColorScheme.light();
  }

  final ThemeData res = isDarkMode ? ThemeData.dark() : ThemeData.light();
  return res.copyWith(
    inputDecorationTheme: const InputDecorationTheme().copyWith(
      filled: true,
      fillColor: surface,
      border: OutlineInputBorder(
        borderRadius: XLayout.brcS,
        borderSide: BorderSide.none,
      ),
      contentPadding: EdgeInsets.all(XLayout.paddingS),
    ),
    colorScheme: defaultColorScheme,
    brightness: isDarkMode ? Brightness.dark : Brightness.light,
    shadowColor: shadowColor,
    canvasColor: surface,
    scaffoldBackgroundColor: surface,
    cardColor: primary,
    dividerColor: surfaceVariant,
    splashColor: splashColor,
    disabledColor: surfaceVariant,
    // TEXT THEME ------------------------------------------------------------
    textTheme: defaultTextTheme.merge(textTheme),
    // OTHER -----------------------------------------------------------------
    iconTheme: const IconThemeData().copyWith(color: onPrimary),
    appBarTheme: const AppBarTheme().copyWith(
      backgroundColor: secondary,
      titleTextStyle: const TextStyle().copyWith(
        color: onSecondary,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        fontFeatures: [const FontFeature("smcp")],
        letterSpacing: 0.25,
      ),
    ),
    buttonTheme: (secondary == null
        ? null
        : const ButtonThemeData().copyWith(buttonColor: secondary)),
    drawerTheme: (surfaceVariant == null
        ? null
        : const DrawerThemeData().copyWith(backgroundColor: surfaceVariant)),
    textSelectionTheme: (secondary == null
        ? null
        : const TextSelectionThemeData().copyWith(cursorColor: secondary)),
    dialogTheme: DialogThemeData(backgroundColor: surfaceVariant),
  );
}
