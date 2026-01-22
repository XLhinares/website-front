import "../globals.dart";
import "../utils/themes.dart";
import "app_manager_plugin.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../utils/tools.dart";

/// A class defining a few preset themes.
class ThemePlugin extends AppManagerPlugin {
  // CONSTANTS =================================================================

  @override
  bool get blocking => true;

  /// A map of all handled themes.
  final Map<String, ThemeData> all = {};

  /// The default font family used in the app.
  final defaultFontFamily = "JosefinSans";

  /// The font family used for code blocks.
  final codeFontFamily = "Sono";

  /// A custom text theme to merge with the [xTheme] one.
  late final TextTheme defaultTextTheme = TextTheme(
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
      fontFamily: codeFontFamily,
      fontSize: 14,
    ),
    labelSmall: TextStyle(
      fontFamily: codeFontFamily,
      fontSize: 12,
    ),
  );

  /// A theme that is requested but not available.
  ///
  /// This can happen if a custom theme is requested by the cookies before it is
  /// added to memory.
  String? _requestedTheme;

  // GETTERS ===================================================================

  /// The list of the names of handled themes.
  List<String> get handledThemes => all.keys.toList();

  /// The preset light theme.
  ThemeData get light => all["light"]!;

  /// The preset dark theme.
  ThemeData get dark => all["dark"]!;

  // CONSTRUCTOR ===============================================================

  /// Adds the default, light and dark themes to the [ThemePlugin].
  ThemePlugin._internal() {
    // LIGHT THEMES ------------------------------------------------------------
    addTheme(
      name: "light",
      data: getTheme(
        mode: ThemeMode.light,
        surface: const Color(0xFFF4F9E9),
        surfaceVariant: const Color(0xFFEEF0EB),
        onSurface: Colors.black,
        primary: const Color(0xFFB4B8AB),
        onPrimary: Colors.black,
        secondary: const Color(0xFF284B63),
        onSecondary: Colors.white,
        textTheme: defaultTextTheme,
      ),
    );

    addTheme(
      name: "crimson",
      data: getTheme(
        mode: ThemeMode.light,
        surface: const Color(0xFFDEDDDB),
        onSurface: const Color(0xFF1F1F1F),
        primary: const Color(0xFF262424),
        onPrimary: const Color(0xFFDEDDDB),
        secondary: const Color(0xFFA82222),
        onSecondary: const Color(0xFFDEDDDB),
        textTheme: defaultTextTheme,
      ),
    );

    addTheme(
      name: "cottage",
      data: getTheme(
        mode: ThemeMode.light,
        surface: const Color(0xFFE0CFB5),
        surfaceVariant: const Color(0xFF49361E),
        onSurface: const Color(0xFF47311C),
        primary: const Color(0xFFACA872),
        onPrimary: Colors.black,
        secondary: const Color(0xFFDCAE61),
        onSecondary: Colors.black,
        tertiary: const Color(0xFF47311C),
        onTertiary: const Color(0xFFE0CFB5),
        shadowColor: const Color(0xFF47311C),
        textTheme: defaultTextTheme,
      ),
    );

    // Add some extra themes
    addTheme(
      name: "pastel",
      data: getTheme(
        mode: ThemeMode.light,
        primary: const Color(0xFFE0AA3A),
        onPrimary: Colors.black,
        secondary: const Color(0xFFEF596C),
        onSecondary: Colors.white,
        surface: const Color(0xFF689BA6),
        textTheme: defaultTextTheme,
      ),
    );

    // DARK THEMES -------------------------------------------------------------

    addTheme(
      name: "rust",
      data: getTheme(
        mode: ThemeMode.dark,
        surface: const Color(0xFFccc5b9),
        onSurface: Colors.black,
        primary: const Color(0xFF403d39),
        secondary: const Color(0xFFC45F37),
        textTheme: defaultTextTheme,
      ),
    );

    addTheme(
      name: "halloween",
      data: getTheme(
        mode: ThemeMode.dark,
        primary: const Color(0xFF3a3630),
        secondary: const Color(0xFFa85c06),
        surface: const Color(0xFF110f0f),
        textTheme: defaultTextTheme,
      ),
    );

    addTheme(
      name: "dark",
      data: getTheme(
        mode: ThemeMode.dark,
        primary: const Color(0xFF464245),
        secondary: const Color(0xFFAF3131),
        surface: const Color(0xFF282627),
        textTheme: defaultTextTheme,
      ),
    );

    addTheme(
      name: "terminal",
      data: getTheme(
        mode: ThemeMode.dark,
        primary: const Color(0xFF1F1F1F),
        secondary: const Color(0xFF49F377),
        onSecondary: Colors.black,
        surface: const Color(0xFF373737),
        textTheme: defaultTextTheme,
      ),
    );
  }

  /// The unique instance of [ThemePlugin], implements the singleton pattern.
  static final ThemePlugin _service = ThemePlugin._internal();

  /// Returns an access to the unique instance of [ThemePlugin].
  factory ThemePlugin() => _service;

  /// Tries to parse the type from the source.
  ///
  /// If the type isn't recognized, throws and [UnsupportedError].
  ThemeData parse(String source) {
    for (final theme in all.keys) {
      if (theme.toLowerCase() == source.toLowerCase()) return all[theme]!;
    }

    dlog("Theme $source not available: using default value instead.");
    return all[app.cookies.theme.defaultValue]!;
  }

  // METHODS ===================================================================

  /// Changes the theme to [target] with the help of the [get] package.
  ///
  /// !WARNING! This function only works if [GetMaterialApp.themeMode] is set
  /// to [ThemeMode.light].
  void changeTheme(String target) => tryWrapper(
        () async {
          dlog("Changing theme to: $target!");
          final ThemeData newTheme = parse(target);
          Get.changeTheme(newTheme);

          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              systemNavigationBarColor: newTheme.colorScheme.primary,
            ),
          );
        },
        then: (success) {
          if (!success) _requestedTheme = target;
        },
      );

  /// Adds a new theme to the [ThemePlugin].
  void addTheme({required String name, required ThemeData data}) {
    all[name] = data;

    if (_requestedTheme == name) {
      changeTheme(name);
      _requestedTheme = null;
    }
  }
}
