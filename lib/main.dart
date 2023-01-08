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
    initialRoute: "/",
    getPages: [
      GetPage<Splash>(name: "/", page: () => Splash()),
      GetPage<ResponsiveHome>(
        name: "/home",
        page: () => const ResponsiveHome(),
      ),
      GetPage<ResponsiveHome>(
        name: "/projects",
        page: () => ResponsiveHome(
          postInit: (_) => router.push(mode: AppMode.projects),
        ),
      ),
      GetPage<ResponsiveHome>(
        name: "/contact",
        page: () => ResponsiveHome(
          postInit: (_) => router.push(mode: AppMode.contact),
        ),
      ),
      GetPage(name: "/legal/cookie_policy", page: () => const CookiePolicy()),
      GetPage(name: "/legal/privacy_policy", page: () => const PrivacyPolicy()),
      GetPage(name: "/legal/legal_mentions", page: () => const LegalMentions()),
    ],

    onGenerateRoute: (RouteSettings routeSettings) {
      if (kDebugMode) {
        print("Generating route from:");
        print("Name: ${routeSettings.name}");
        print("Settings: $routeSettings");
      }

      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => Splash(
          nextPage: () => ResponsiveHome(
            postInit: (_) {
              if (routeSettings.name == null) return;
              router.push(route: routeSettings.name);
            },
          ),
        ),
      );
    },

    // Responsive
    builder: (context, child) => ResponsiveWrapper.builder(
      child,
      minWidth: 480,
      defaultScale: true,
      breakpoints: const [
        ResponsiveBreakpoint.resize(480, name: MOBILE),
        ResponsiveBreakpoint.resize(800, name: TABLET),
        ResponsiveBreakpoint.resize(1000, name: DESKTOP),
      ],
    ),
  ));
}
