import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../classes/services/services.dart";
import "../classes/user/user.dart";

// SERVICES ====================================================================

/// Whether the app is ready to be used.
final RxBool appIsReady = false.obs;

/// A special service which handle the local data and let the user interact with it.
final User user = User();

/// A service that manages the different elements of the app.
final RoutingService router = RoutingService();

/// A service that manages all the backend stuff.
final APIService api = APIService();

/// A service that manages the preferences of the user.
final CookieService settings = CookieService();

/// A service that handles the themes of the app.
final ThemeService themes = ThemeService();

// CONSTANTS ===================================================================

/// The version of the app.
const String versionNumber = "v1.9.0";

/// The URL address of the app.
const String xeppelinURL = "https://xeppelin.org";

/// The default ratio of horizontal extent over the vertical.
const double frameRatio = 4 / 3;

/// The vertical extent of the [BottomNavigationBar] used on the mobile display.
double get navigationBarHeight => XLayout.paddingS * 6;

// ANIMATIONS ------------------------------------------------------------------

/// The default duration of animations in the app.
const Duration animDurationShort = Duration(milliseconds: 200);

/// The default duration for long animations.
///
/// It is typically used by the sps mode switching animations.
const Duration animDurationLong = Duration(milliseconds: 750);

// UTILS -----------------------------------------------------------------------

/// The list of the different supported localizations.
List<String> supportedLocales = ["fr", "en"];

/// Runs some extra commands asynchronously.
void postInit() async {
  // Add some extra themes
  themes.addTheme(
    name: "pastel",
    data: xTheme.getTheme(
      mode: ThemeMode.light,
      primary: const Color(0xFFE0AA3A),
      secondary: const Color(0xFFEF596C),
      background: const Color(0xFF689BA6),
      // backgroundAlt: Color(0xFF282627),
      cardColor: const Color(0xFFE0AA3A),
      containerColor: Colors.white.withOpacity(0.7),
      textTheme: ThemeService.defaultTextTheme,
    ),
  );
}
