import "package:flutter/material.dart";
import "package:get/get.dart";

import "../../globals.dart";
import "settings_tile.dart";

/// The settings allowing the user to set the locale of the app.
class MobileLocaleRotator extends StatelessWidget {
  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [MobileLocaleRotator] matching the given parameters.
  const MobileLocaleRotator({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return SettingsTile.rotator(
      title: "settings_locale_rotator".trParams({
        "value": "language_${app.cookies.locale.value}".tr,
      }),
      description: "settings_locale_desc".tr,
      onTapLeft: app.cookies.rotateLocaleL,
      onTapRight: app.cookies.rotateLocaleR,
    );
  }
}
