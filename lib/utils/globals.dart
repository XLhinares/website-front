import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../classes/controllers/blog_loader_controller.dart";
import "../classes/controllers/project_loader_controller.dart";
import "../classes/services/services.dart";
import "../classes/user/user.dart";
import "translations.dart";

/// The version of the app.
const String versionNumber = "v2.3.0";

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
final CookieService cookies = CookieService();

/// A service that handles the themes of the app.
final ThemeService themes = ThemeService();

/// A controller that handles loading projects from the API.
final ProjectLoaderController projectLoaderController =
    ProjectLoaderController();

/// A controller that handles loading blogs from the API.
final BlogLoaderController blogLoaderController = BlogLoaderController();

// CONSTANTS ===================================================================

/// The URL address of the app.
const String xeppelinURL = "https://xeppelin.org";

/// A markdown link to the xeppelin website.
const String xeppelinMD = "[https://xeppelin.org](https://xeppelin.org)";

/// The default ratio of horizontal extent over the vertical.
const double frameRatio = 4 / 3;

/// The maximum horizontal extent of snack-bars appearing on the screen.
const double maxSnackbarLength = 600;

/// The vertical extent of the [BottomNavigationBar] used on the mobile display.
double get navigationBarHeight => XLayout.paddingS * 6;

/// The size of the pages loaded on the API.
const int pageSize = 20;

// ANIMATIONS ------------------------------------------------------------------

/// The default duration of animations in the app.
const Duration animDurationShort = Duration(milliseconds: 200);

/// The default duration for long animations.
///
/// It is typically used by the sps mode switching animations.
const Duration animDurationLong = Duration(milliseconds: 750);

// UTILS -----------------------------------------------------------------------

/// The object containing all the translations used in the app.
final CustomTranslations translations = CustomTranslations();

/// The list of the different supported localizations.
List<String> supportedLocales = ["fr", "en"];

/// Runs some extra commands asynchronously.
void postInit() async {}
