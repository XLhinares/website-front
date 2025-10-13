import "dart:async";

import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:get_storage/get_storage.dart";

import "../../utils/globals.dart";

// Project dependencies

/// A singleton handling the shared preferences and the memory of the app.
class CookieService extends GetxController {
  // VARIABLES =================================================================

  // META ----------------------------------------------------------------------

  /// Whether the database was loaded.
  late final RxBool loaded;

  /// The [GetStorage] object that keeps track of everything.
  late final GetStorage _storage;

  // ACTUAL --------------------------------------------------------------------

  /// The locale used for the language of the app.
  late final RxString locale;

  /// Whether the app should display in dark mode.
  late final RxString theme;

  /// The identifier of the current app background.
  late final RxString background;

  /// Whether the user is allowing the cookies.
  late final RxBool cookies;

  /// Whether the user is allowing the cookies.
  late final RxString email;

  /// Whether the user is allowing the cookies.
  late final RxString token;

  /// Whether the user has dismissed the cookie banner.
  late final RxBool cookieBannerDismissed;

  // CONSTRUCTOR ===============================================================

  /// The private instance of [CookieService].
  ///
  /// It insures that the class is instantiated only once at the beginning.
  static final CookieService _instance = CookieService._internal();

  /// Returns the unique [CookieService] instance.
  factory CookieService() => _instance;

  /// The real constructor of the class.
  ///
  /// It is called exactly once and contains the instantiation logic.
  CookieService._internal() {
    _init();
  }

  Future<void> _init() async {
    // Instantiating variables. ------------------------------------------------
    loaded = false.obs;
    _storage = GetStorage();

    // COOKIES
    cookies = RxBool(_storage.read<bool>("cookies") ?? false);
    _saveCookies(cookies.value);
    cookieBannerDismissed = RxBool(cookies.value);

    // EMAIL
    email = RxString(_storage.read<String>("email") ?? "");
    _saveEmail(email.value);

    // TOKEN
    token = RxString(_storage.read<String>("token") ?? "");
    _saveToken(token.value);

    // LOCALE
    locale = RxString(_storage.read<String>("locale") ?? "en");
    _saveLocale(locale.value);

    // THEME
    theme = RxString(_storage.read<String>("theme") ?? "dark");
    _saveTheme(theme.value);

    // BACKGROUND
    background = RxString(_storage.read<String>("background") ?? "wave");
    _saveBackground(background.value);

    // Setting up workers.
    ever<String>(email, _saveEmail);
    ever<String>(token, _saveToken);
    ever<String>(locale, _saveLocale);
    ever<String>(theme, _saveTheme);
    ever<bool>(cookies, _saveCookies);

    // All done.
    loaded.value = true;
    printInfo(info: "CookieService loaded");
    update();
  }

  // METHODS ===================================================================

  /// Performs a check on the value of the [token] then save it to memory.
  Future<void> _saveToken(String value) async {
    if (cookies.isTrue) await _storage.write("token", value);
  }

  /// Performs a check on the value of the [email] then save it to memory.
  Future<void> _saveEmail(String value) async {
    printInfo(info: "Changing email to: $value");
    if (cookies.isTrue) await _storage.write("email", value);
  }

  /// Performs a check on the value of the [locale] then save it to memory.
  Future<void> _saveLocale(String value) async {
    printInfo(info: "Changing locale to: $value");
    if (cookies.isTrue) await _storage.write("locale", value);
    Get.updateLocale(Locale(value));
  }

  /// Rotates between the different supported locales.
  Future<void> rotateLocale() async {
    final int index = supportedLocales.indexOf(locale.value);
    final String newLocale =
        supportedLocales[(index + 1) % supportedLocales.length];
    locale.value = newLocale;
  }

  /// Performs a check on the value of [darkTheme] then save it to memory.
  Future<void> _saveTheme(String value) async {
    printInfo(info: "Changing theme to: $theme");
    if (cookies.isTrue) await _storage.write("theme", value);
    themes.changeTheme(theme.value);
  }

  /// Performs a check on the value of [darkTheme] then save it to memory.
  Future<void> _saveBackground(String value) async {
    printInfo(info: "Changing background to: $value");
    if (cookies.isFalse) return;
    await _storage.write("background", value);
  }

  /// Toggles the app between light and dark theme.
  Future<void> rotateTheme() async {
    final int index = themes.handledThemes.indexOf(theme.value);
    final int length = themes.handledThemes.length;
    theme.value = themes.handledThemes[(index + 1) % length];
  }

  /// Performs a check on the value of [cookies] then save it to memory.
  Future<void> _saveCookies(bool value) async {
    printInfo(info: "Changing cookies to: $value");

    if (value) {
      await _storage.write("cookies", value);
      // Try to save all the data that was not save due to cookies.
      await _saveLocale(locale.value);
      await _saveTheme(theme.value);
    } else {
      _clearCookies();
    }
  }

  /// Deletes the cookies.
  Future<void> _clearCookies() async {
    await _storage.remove("cookies");
    await _storage.remove("email");
    await _storage.remove("locale");
    await _storage.remove("theme");
    await _storage.remove("background");
  }
}
