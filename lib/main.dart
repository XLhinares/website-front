import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:get_storage/get_storage.dart";
import "package:x_containers/x_containers.dart";

import "classes/routes/custom_route.dart";
import "tabs/tabs.dart";
import "utils/globals.dart";

void main() async {
  // Utils ---------------------------------------------------------------------

  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();

  // Memory --------------------------------------------------------------------

  Get.put(router);
  Get.put(settings);

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
    theme: themes.dark,
    themeMode: ThemeMode.light,

    // Run
    initialRoute: "/",
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
            router.push(path: routeSettings.name);
          },
        ),
      );
    },

    unknownRoute: CustomRoute.NOT_FOUND.page,
  ));
}
