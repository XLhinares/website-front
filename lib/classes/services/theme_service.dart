import "dart:ui";

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

// MODE MANAGEMENT =============================================================

/// A class defining a few preset themes.
class ThemeService {
  // CONSTANTS =================================================================

  /// A map of all handled themes.
  final Map<String, ThemeData> all = {};

  /// The default font family used in the app.
  static const defaultFontFamily = "JosefinSans";

  /// A custom text theme to merge with the [xTheme] one.
  static TextTheme defaultTextTheme = const TextTheme(
    displayLarge: TextStyle(
        fontFamily: defaultFontFamily,
        fontFeatures: [FontFeature.enable("smcp")]),
    displayMedium: TextStyle(
        fontFamily: defaultFontFamily,
        fontFeatures: [FontFeature.enable("smcp")],
        fontSize: 26,
        fontWeight: FontWeight.bold),
    // TITLE
    titleLarge: TextStyle(fontFamily: defaultFontFamily, fontSize: 30),
    titleMedium: TextStyle(fontFamily: defaultFontFamily, fontSize: 26),
    titleSmall: TextStyle(fontFamily: defaultFontFamily),
    // BODY
    bodyLarge: TextStyle(fontFamily: defaultFontFamily, fontSize: 24),
    bodyMedium:
        TextStyle(fontFamily: defaultFontFamily, fontSize: 18, height: 1.2),
    bodySmall: TextStyle(fontFamily: defaultFontFamily),
    // LABEL
    labelMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w200,
    ),
    labelSmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w200,
    ),
  );

  // GETTERS ===================================================================

  /// The list of the names of handled themes.
  List<String> get handledThemes => all.keys.toList();

  /// The preset light theme.
  ThemeData get light => all["light"]!;

  /// The preset dark theme.
  ThemeData get dark => all["dark"]!;

  // CONSTRUCTOR ===============================================================

  /// Adds the default, light and dark themes to the [ThemeService].
  ThemeService._internal() {
    addTheme(
      name: "light",
      data: xTheme.getTheme(
        mode: ThemeMode.light,
        appBarTheme: const AppBarTheme().copyWith(
          color: const Color(0xFF284B63),
          titleTextStyle: const TextStyle().copyWith(
            color: Colors.white,
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
        textTheme: defaultTextTheme,
      ),
    );

    addTheme(
      name: "dark",
      data: xTheme.getTheme(
        mode: ThemeMode.dark,
        primary: const Color(0xFF464245),
        secondary: const Color(0xFFAF3131),
        background: const Color(0xFF282627),
        // backgroundAlt: Color(0xFF282627),
        cardColor: const Color(0xFF464245),
        containerColor: const Color(0xFF686866),
        textTheme: defaultTextTheme,
      ),
    );
  }

  /// The unique instance of [ThemeService], implements the singleton pattern.
  static final ThemeService _service = ThemeService._internal();

  /// Returns an access to the unique instance of [ThemeService].
  factory ThemeService() => _service;

  /// Tries to parse the type from the source.
  ///
  /// If the type isn't recognized, throws and [UnsupportedError].
  ThemeData parse(String source) {
    for (final theme in all.keys) {
      if (theme.toLowerCase() == source.toLowerCase()) return all[theme]!;
    }

    throw UnsupportedError("This theme is not supported: $source");
  }

  // METHODS ===================================================================

  /// Changes the theme to [target] with the help of the [get] package.
  void changeTheme(String target) {
    final ThemeData newTheme = parse(target);
    Get.changeTheme(newTheme);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: newTheme.colorScheme.primary,
      ),
    );
  }

  /// Adds a new theme to the [ThemeService].
  void addTheme({required String name, required ThemeData data}) =>
      all[name] = data;
}
