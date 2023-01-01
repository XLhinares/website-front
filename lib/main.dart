import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:get_storage/get_storage.dart";
import "package:responsive_framework/responsive_framework.dart";
import "package:x_containers/x_containers.dart";

import "classes/dataclass/app_mode.dart";
import "tabs/tabs.dart";
import "utils/globals.dart";
import "utils/translations.dart";

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
      padding: EdgeInsets.all(XLayout.paddingS));

  // Run -----------------------------------------------------------------------
  runApp(GetMaterialApp(
    // Meta
    title: "Xeppelin",

    // Localization
    translations: CustomTranslations(),
    locale: Get.deviceLocale,
    fallbackLocale: const Locale("en"),

    // Theme
    // THEME =================================================================
    theme: themes.dark,
    themeMode: ThemeMode.light,

    // Run
    getPages: [
      GetPage<Splash>(name: "/", page: () => Splash()),
      GetPage<ResponsiveHome>(
          name: "/home", page: () => const ResponsiveHome()),
      GetPage<ResponsiveHome>(
          name: "/projects",
          page: () {
            router.goTo(mode: AppMode.projects);
            return const ResponsiveHome();
          }),
      GetPage<ResponsiveHome>(
          name: "/contact",
          page: () {
            router.goTo(mode: AppMode.contact);
            return const ResponsiveHome();
          }),
    ],

    onGenerateRoute: (RouteSettings routeSettings) {
      if (kDebugMode) {
        print("Generating route from:");
        print("Name: ${routeSettings.name}");
        print("Settings: $routeSettings");
      }

      // HOME
      if (routeSettings.name?.contains(AppMode.home.name) ?? false) {
        router.goTo(mode: AppMode.home);
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (context) => Splash(
            nextPage: () => const ResponsiveHome(),
          ),
        );
      }
      // PROJECT
      if (routeSettings.name?.contains(AppMode.projects.name) ?? false) {
        router.goTo(mode: AppMode.projects);
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (context) => Splash(
            nextPage: () => const ResponsiveHome(),
          ),
        );
      }
      // CONTACT
      if (routeSettings.name?.contains(AppMode.contact.name) ?? false) {
        router.goTo(mode: AppMode.contact);
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (context) => Splash(
            nextPage: () => const ResponsiveHome(),
          ),
        );
      }
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => Splash(
          nextPage: () => const TabNotFound(),
        ),
      );
    },

    // Responsive
    builder: (context, child) => ResponsiveWrapper.builder(
      child,
      minWidth: 480,
      defaultScale: true,
      breakpoints: const [
        ResponsiveBreakpoint.autoScale(480, name: MOBILE),
        ResponsiveBreakpoint.autoScale(800, name: TABLET),
        ResponsiveBreakpoint.resize(1000, name: DESKTOP),
      ],
    ),
  ));
}
