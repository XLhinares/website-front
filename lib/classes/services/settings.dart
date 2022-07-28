// Package dependencies
import "dart:async";
import "package:flutter/material.dart";

// Package dependencies
import "package:get/get.dart";
import "package:shared_preferences/shared_preferences.dart";

// Project dependencies
import "package:website_front/utils/globals.dart";

// Project dependencies

/// A singleton handling the shared preferences and the memory of the app.
class Settings extends GetxController {

  // VARIABLES =================================================================

  // META ----------------------------------------------------------------------

  /// Whether the database was loaded.
  late final RxBool loaded;

  /// The [SharedPreferences] object that keeps track of everything.
  late final SharedPreferences _prefs;

  // ACTUAL --------------------------------------------------------------------

  /// The number of turns in a game.
  late final RxString locale;

  /// Whether the app should display in dark mode.
  late final RxBool darkTheme;

  /// The maximal value displayed on graphs.
  late final RxBool cookies;

  // CONSTRUCTOR ===============================================================

  /// The private instance of [Settings].
  ///
  /// It insures that the class is instantiated only once at the beginning.
  static final Settings _instance = Settings._internal();

  /// Returns the unique [Settings] instance.
  factory Settings() => _instance;

  /// The real constructor of the class.
  ///
  /// It is called exactly once and contains the instantiation logic.
  Settings._internal() {
    _init();
  }

  Future<void> _init () async {
    // Instantiating variables. ------------------------------------------------
    loaded = false.obs;
    _prefs = await SharedPreferences.getInstance();

    // LOCALE
    locale = RxString(_prefs.getString("locale") ?? "en");
    _saveLocale(locale.value);

    // DARK THEME
    darkTheme = RxBool(_prefs.getBool("darkTheme") ?? true);
    _saveTheme(darkTheme.value);

    // COOKIES
    cookies = RxBool(_prefs.getBool("cookies") ?? false);
    _saveCookies(cookies.value);


    // Setting up workers.
    ever<String>(locale, _saveLocale);
    ever<bool>(darkTheme, _saveTheme);
    ever<bool>(cookies, _saveCookies);

    // All done.
    loaded.value = true;
    printInfo(info: "Settings loaded");
    update();
  }

  // METHODS ===================================================================

  /// Performs a check on the value of the [locale] then save it to memory.
  Future<void> _saveLocale (String value) async {
    printInfo(info: "Changing locale to: $value");
    await _prefs.setString("locale", value);
    Get.updateLocale(Locale(value));
  }

  /// Rotates between the different supported locales.
  Future<void> rotateLocale () async {
    final int index = supportedLocales.indexOf(locale.value);
    final String newLocale = supportedLocales[
      (index + 1) % supportedLocales.length
    ];
    locale.value = newLocale;
  }

  /// Performs a check on the value of [darkTheme] then save it to memory.
  Future<void> _saveTheme (bool value) async {
    printInfo(info: "Changing theme to: ${value ? "dark" : "light"} mode");
    await _prefs.setBool("darkTheme", value);
    Get.changeThemeMode(darkTheme.value ? ThemeMode.dark : ThemeMode.light);
  }

  /// Toggles the app between light and dark theme.
  Future<void> toggleTheme () async => darkTheme.value = !darkTheme.value;

  /// Performs a check on the value of [cookies] then save it to memory.
  Future<void> _saveCookies (bool value) async {
    printInfo(info: "Changing cookies to: $value");
    await _prefs.setBool("cookies", value);
  }
}