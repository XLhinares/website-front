import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "classes/dataclass/route.dart";
import "globals.dart";
import "pages/responsive_home.dart";
import "utils/themes.dart";

void main() async {
  // Utils ---------------------------------------------------------------------

  WidgetsFlutterBinding.ensureInitialized();

  /// Set up the debug prints in order to have access to log using `flutter run`
  Get.config(
    enableLog: true,
    logWriterCallback: (String text, {bool isError = false}) {
      // This forces GetX logs into the standard print stream
      if (kDebugMode) {
        if (isError) {
          print("[E] $text");
        } else {
          print("[D] $text");
        }
      }
    },
  );

  // Memory --------------------------------------------------------------------

  Get.put(router);
  Get.put(app);

  // Theme ---------------------------------------------------------------------

  xTheme.set(
    // paddingValue: XLayout.paddingM,
    padding: EdgeInsets.all(XLayout.paddingS),
    // borderDecoration: Border.all(width: 4, color: Colors.black45),
  );

  // Run -----------------------------------------------------------------------
  runApp(GetMaterialApp(
    // Meta
    title: "Xeppelin",

    // Localization
    translations: translations,
    locale: Get.deviceLocale,
    fallbackLocale: const Locale("en"),

    // Theme
    // THEME =================================================================
    theme: defaultTheme,
    themeMode: ThemeMode.light,

    // Run
    initialRoute: "/main",
    getPages: router.routes.map((e) => e.page).toList(),

    onGenerateRoute: (RouteSettings routeSettings) {
      if (kDebugMode) {
        print("Generating route from:");
        print("Name: ${routeSettings.name}");
        print("Settings: $routeSettings");
      }

      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => ResponsiveHome(
          postInit: (_) {
            if (routeSettings.name == null) return;
            router.goTo(AppRoute.parse(routeSettings.name));
          },
        ),
      );
    },

    unknownRoute: AppRoute.NOT_FOUND.page,
  ));
}
