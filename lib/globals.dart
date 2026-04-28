import "package:flutter/material.dart";
import "package:get/get.dart";

import "app/app_manager.dart";
import "app/routing_service.dart";
import "classes/controllers/media_loader_controller.dart";
import "classes/medias/media_type.dart";
import "utils/translations.dart";

/// The version of the app.
const String versionNumber = "v3.3.0";

// SERVICES ====================================================================

/// Whether the app is ready to be used.
final RxBool appIsReady = false.obs;

/// In-app representation of the [User].
final AppManager app = AppManager();

/// A service that manages the different elements of the app.
final XRouter router = XRouter();

/// A controller that handles loading projects from the API.
final MediaLoaderController projectLoaderController =
    MediaLoaderController(type: MediaType.project);

// CONSTANTS ===================================================================

/// The URL address of the app.
const String xeppelinURL = "https://xeppelin.org";

/// A markdown link to the xeppelin website.
const String xeppelinMD = "[https://xeppelin.org](https://xeppelin.org)";

/// The default ratio of horizontal extent over the vertical.
const double frameRatioDesktop = 4 / 3;

/// The default ratio of horizontal extent over the vertical.
const double frameRatioMobile = 1 / 2;

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

// UTILS -----------------------------------------------------------------------

/// The object containing all the translations used in the app.
final CustomTranslations translations = CustomTranslations();

/// The list of the different supported localizations.
List<String> supportedLocales = ["fr", "en"];
