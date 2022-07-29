// Project dependencies
import "package:website_front/classes/services/settings.dart";
import "package:website_front/classes/services/single_page_service.dart";

// SERVICES ====================================================================

/// A service that manages the different elements of the app.
SinglePageService sps = SinglePageService();

/// A service that manages the preferences of the user.
Settings settings = Settings();

// VARIABLES ===================================================================

/// The default ratio of horizontal extent over the vertical.
const double frameRatio = 1.5;

// ANIMATIONS ==================================================================

/// The default duration of animations in the app.
const Duration animDurationShort = Duration(milliseconds: 200);

/// The default duration for long animations.
///
/// It is typically used by the sps mode switching animations.
const Duration animDurationLong = Duration(milliseconds: 1000);

// UTILS -----------------------------------------------------------------------

/// The list of the different supported localizations.
List<String> supportedLocales = ["fr", "en"];