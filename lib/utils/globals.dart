import "package:x_containers/x_containers.dart";

import "../classes/services/services.dart";
import "../classes/user/user.dart";

// SERVICES ====================================================================

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
const String versionNumber = "v1.6.0";

/// The default ratio of horizontal extent over the vertical.
const double frameRatio = 1.5;

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
