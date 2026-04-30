import "dart:async";

import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:get_storage/get_storage.dart";

import "../classes/dataclass/background_data.dart";
import "../classes/dataclass/cookie.dart";
import "../globals.dart";
import "../utils/extensions.dart";
import "../utils/tools.dart";
import "app_manager_plugin.dart";

/// A singleton handling the shared preferences and the memory of the app.
/// It is based on `GetStorage`
class CookiePlugin extends AppManagerPlugin {
  // VARIABLES =================================================================

  @override
  bool get blocking => true;

  // META ----------------------------------------------------------------------

  /// The [GetStorage] object that keeps track of everything.
  late final GetStorage _storage;

  // ACTUAL --------------------------------------------------------------------

  /// The locale used for the language of the app.
  late final Cookie<String> locale = Cookie(
    "locale",
    defaultValue: "en",
    onSave: (value) async {
      await Get.updateLocale(Locale(value));
    },
  );

  /// Whether the app should display in dark mode.
  late final Cookie<String> theme = Cookie(
    "theme",
    defaultValue: "dark",
    onSave: (value) => app.themes.changeTheme(value),
  );

  /// The identifier of the current background of the app.
  late final Cookie<String> background = Cookie(
    "background",
    defaultValue: "wave",
  );

  /// The identifier of the current background of the app.
  late final Cookie<bool> cookieBannerDismissed = Cookie(
    "cookieBannerDismissed",
    defaultValue: false,
  );

  /// Whether the user is allowing the cookies.
  ///
  /// !WARNING! This cookie should not be removed as it controls whether other
  /// cookies are written to the [GetStorage].
  late final Cookie<bool> allowCookies = Cookie(
    "allowCookies",
    defaultValue: false,
    onSave: (value) async {
      if (value) {
        _saveAllCookies();
      } else {
        _deleteAllCookies();
      }
    },
  );

  /// The list of handled cookies.
  ///
  /// !WARNING! Be sure to properly instantiate it in the constructor [CookiePlugin._internal].
  late final List<Cookie> cookies;

  // CONSTRUCTOR ===============================================================

  /// The real constructor of the class.
  ///
  /// It is called exactly once and contains the instantiation logic.
  /// If true, [allowCookies] will cause all cookies values to be saved;
  /// therefore, it should be loaded last to avoid unwanted override.
  CookiePlugin._internal();

  /// The private instance of [CookiePlugin].
  ///
  /// It insures that the class is instantiated only once at the beginning.
  static final CookiePlugin _instance = CookiePlugin._internal();

  /// Returns the unique [CookiePlugin] instance.
  factory CookiePlugin() => _instance;

  @override
  Future<void> load({SuccessCallback? then}) async {
    if (isLoaded.isTrue) return;

    await GetStorage.init();
    _storage = GetStorage();
    cookies = [background, theme, locale, allowCookies, cookieBannerDismissed];

    // Instantiating variables. ------------------------------------------------
    // _deleteAllCookies();
    for (final cookie in cookies) {
      await cookie.load(_storage);
    }
    // All done.
    dlog("Loaded!");
    super.load();
  }

  /// Saves all the cookies.
  Future<void> _saveAllCookies() async {
    dlog("Saving all cookies...");
    for (final cookie in cookies) {
      dlog("Saving [${cookie.name}]...");
      cookie.value = cookie.value;
    }
    dlog("Done!");
  }

  /// Deletes the cookies.
  Future<void> _deleteAllCookies() async {
    dlog("Deleting all cookies...");
    for (final cookie in cookies) {
      await _storage.remove(cookie.name);
    }
    dlog("Done!");
  }

  // METHODS ===================================================================

  /// Rotates between the different supported locales.
  Future<void> _rotateLocale({bool reverse = false}) async {
    final int index = supportedLocales.indexOf(locale.value);
    final String newLocale = supportedLocales[
        (index + (reverse ? -1 : 1)) % supportedLocales.length];
    locale.value = newLocale;
  }

  /// Left-side rotation of the locale value.
  Future<void> rotateLocaleL() async => _rotateLocale(reverse: true);

  /// Right-side rotation of the locale value.
  Future<void> rotateLocaleR() async => _rotateLocale();

  /// Toggles the app between light and dark theme.
  Future<void> rotateTheme({bool reverse = false}) async {
    final int index = app.themes.handledThemes.indexOf(theme.value);
    final int length = app.themes.handledThemes.length;
    theme.value =
        app.themes.handledThemes[(index + (reverse ? -1 : 1)) % length];
  }

  /// Toggles the app between light and dark theme.
  void _rotateTheme({bool reverse = false}) {
    final int index = app.themes.handledThemes.indexOf(theme.value);
    final int length = app.themes.handledThemes.length;
    theme.value =
        app.themes.handledThemes[(index + (reverse ? -1 : 1)) % length];
  }

  /// Left-side rotation of the theme value.
  Future<void> rotateThemeL() async => _rotateTheme(reverse: true);

  /// Right-side rotation of the theme value.
  Future<void> rotateThemeR() async => _rotateTheme();

  /// Toggles the app between light and dark theme.
  void _rotateBackground({bool reverse = false}) {
    final currentBackground = BackgroundData.parse(background.value);
    final int index = BackgroundData.values.indexOf(currentBackground);
    final int length = BackgroundData.values.length;
    final String newBackgroundName =
        BackgroundData.values[(index + (reverse ? -1 : 1)) % length].name;
    background.value = newBackgroundName;
  }

  /// Left-side rotation of the theme value.
  Future<void> rotateBackgroundL() async => _rotateBackground(reverse: true);

  /// Right-side rotation of the theme value.
  Future<void> rotateBackgroundR() async => _rotateBackground();
}
