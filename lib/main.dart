import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:get_storage/get_storage.dart";
import "package:responsive_framework/responsive_framework.dart";
import "package:x_containers/x_containers.dart";

import "classes/dataclass/app_mode.dart";
import "tabs/tabs.dart";
import "utils/globals.dart";
import "utils/theme.dart";
import "utils/translations.dart";

void main() async {
  // Utils ---------------------------------------------------------------------

  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();

  // Memory --------------------------------------------------------------------

  Get.put(sps);
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

    // Theme
    themeMode: ThemeMode.dark,
    theme: themeLight,
    darkTheme: themeDark,

    // Run
    getPages: [
      GetPage<Splash>(name: "/", page: () => Splash()),
      GetPage<Home>(name: "/home", page: () => const Home()),
      GetPage<Home>(
          name: "/projects",
          page: () {
            sps.goTo(AppMode.projects);
            return const Home();
          }),
      GetPage<Home>(
          name: "/contact",
          page: () {
            sps.goTo(AppMode.contact);
            return const Home();
          }),
    ],

    onGenerateRoute: (RouteSettings routeSettings) {
      // HOME
      if (routeSettings.name == AppMode.home.name) {
        sps.goTo(AppMode.home);
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (context) => const Home(),
        );
      }
      // PROJECT
      if (routeSettings.name == AppMode.projects.name) {
        sps.goTo(AppMode.projects);
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (context) => const Home(),
        );
      }
      // CONTACT
      if (routeSettings.name == AppMode.contact.name) {
        sps.goTo(AppMode.contact);
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (context) => const Home(),
        );
      }
      return null;
    },

    // Responsive
    builder: (context, child) => ResponsiveWrapper.builder(
      child,
      minWidth: 480,
      defaultScale: true,
      breakpoints: const [
        ResponsiveBreakpoint.resize(480, name: MOBILE),
        ResponsiveBreakpoint.autoScale(800, name: TABLET),
        ResponsiveBreakpoint.resize(1000, name: DESKTOP),
      ],
    ),
  ));
}
