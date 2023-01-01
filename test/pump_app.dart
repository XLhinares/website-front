// Flutter dependencies
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";

// Package dependencies
import "package:get/get.dart";

// Project dependencies
import "package:website_front/tabs/responsive_home.dart";
import "package:website_front/tabs/splash.dart";
import "package:website_front/utils/utils.dart";

/// A utility to pump the full app without having to rewrite it every time.
Future<void> pumpApp(WidgetTester tester) async {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Memory --------------------------------------------------------------------

  Get.put(router);
  Get.put(settings);

  await tester.pumpWidget(
    GetMaterialApp(
      // Meta
      title: "Xequiche",

      // Localization
      translations: CustomTranslations(),
      locale: Get.deviceLocale,

      // Theme
      themeMode: ThemeMode.dark,
      theme: themes.dark,

      // Run
      getPages: [
        GetPage<Splash>(name: "/", page: () => Splash()),
        GetPage<ResponsiveHome>(
            name: "/home", page: () => const ResponsiveHome()),
      ],
    ),
  );
}
