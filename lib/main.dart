// Flutter dependencies
import "package:flutter/material.dart";

// Package dependencies
import "package:get/get.dart";
import 'package:get_storage/get_storage.dart';
import "package:x_containers/x_containers.dart";

// Project dependencies
import "package:website_front/tabs/splash.dart";
import "package:website_front/tabs/home.dart";
import "package:website_front/utils/globals.dart";
import "package:website_front/utils/theme.dart";
import "package:website_front/utils/translations.dart";

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
    padding: EdgeInsets.all(XLayout.paddingS)
  );

  // Run -----------------------------------------------------------------------
  runApp(GetMaterialApp(

    // Meta
    title: "Xequiche",

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
    ],

  ));
}