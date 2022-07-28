// Flutter dependencies
import "dart:ui";

import "package:flutter/material.dart";

// Package dependencies
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

/// Changes the app theme in one function.
void changeThemeMode ({bool darkMode = true}) {

  ThemeMode mode = darkMode ? ThemeMode.dark : ThemeMode.light;
  Get.changeThemeMode(mode);
}



/// An extension on the [Colors] class to add the colors of this theme.
extension DefaultColors on Colors {


  /// The color used for black text.
  static Color textBlack = Colors.black.withOpacity(0.7);

  /// The color used for black text.
  static Color textWhite = Colors.white.withOpacity(0.7);

  /// The color used for black text.
  static Color get text => Get.context?.isDarkMode ?? true
      ? textWhite
      : textBlack;

  /// The color used for black text.
  static Color boxWhite = Colors.white.withOpacity(0.7);
}


/// A preset theme for light mode.
ThemeData themeLight = xTheme.getTheme(
  mode: ThemeMode.light,
  appBarTheme: const AppBarTheme().copyWith(
    color: const Color(0xFF284B63),
    titleTextStyle: const TextStyle().copyWith(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      fontFeatures: [const FontFeature.enable("smcp")],
      letterSpacing: 0.25,
    ),
  ),
  primary: const Color(0xFFB4B8AB),
  secondary: const Color(0xFF284B63),
  background: const Color(0xFFF4F9E9),
  backgroundAlt: const Color(0xFFEEF0EB),
  cardColor: const Color(0xFFB4B8AB),
  containerColor: const Color(0xFFB4B8AB),
);

/// A preset theme for dark mode.
ThemeData themeDark = xTheme.getTheme(
  mode: ThemeMode.dark,
  primary: const Color(0xFF464245),
  secondary: const Color(0xFFAF3131),
  background: const Color(0xFF282627),
  // backgroundAlt: Color(0xFF282627),
  cardColor: const Color(0xFF464245),
  containerColor: const Color(0xFF686866),
);