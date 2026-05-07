import "package:flutter/material.dart";
import "package:get/get.dart";

import "app/app_manager.dart";
import "app/router.dart";
import "utils/translations.dart";

/// The version of the app.
const String versionNumber = "v3.4.0";

// SERVICES ====================================================================

/// Whether the app is ready to be used.
final RxBool appIsReady = false.obs;

/// In-app representation of the [User].
final AppManager app = AppManager();

/// A service that manages the different elements of the app.
final XRouter router = XRouter();

// CONSTANTS ===================================================================

/// The URL address of the app.
const String xeppelinURL = "https://xeppelin.org";

/// A markdown link to the xeppelin website.
const String xeppelinMD = "[https://xeppelin.org](https://xeppelin.org)";

/// The default ratio of horizontal extent over the vertical.
const double frameRatioDesktop = 4 / 3;

/// The default ratio of horizontal extent over the vertical.
const double frameRatioMobile = 1 / 2;

/// The minimum accepted viewport height.
///
/// Used in mobile tabs to avoid overflow while keeping a consistent tab height.
const double minViewportHeight = 960;

/// The maximum horizontal extent of snack-bars appearing on the screen.
const double maxSnackbarLength = 600;

/// The size of the pages loaded on the API.
const int pageSize = 20;

/// The gray color of the default Xeppelin logo.
const Color xeppelinColor = Color(0xFFB0BDD4);

// ANIMATIONS ------------------------------------------------------------------

/// The default duration of animations in the app.
const Duration animDurationShort = Duration(milliseconds: 200);

/// The default duration for long animations.
///
/// It is typically used by the sps mode switching animations.
const Duration animDurationLong = Duration(milliseconds: 750);

/// Default animation curve in the app.
///
/// Pretty much there so I don't have to guess each time and end up with 100000 different curves everywhere
const Curve animCurve = Curves.bounceInOut;

// UTILS -----------------------------------------------------------------------

/// The object containing all the translations used in the app.
final CustomTranslations translations = CustomTranslations();

/// The list of the different supported localizations.
List<String> supportedLocales = ["fr", "en"];
