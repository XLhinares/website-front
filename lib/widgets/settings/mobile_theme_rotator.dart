import "package:flutter/material.dart";
import "package:get/get.dart";

import "../../globals.dart";
import "settings_tile.dart";

/// The settings allowing the user to set the locale of the app.
class MobileThemeRotator extends StatelessWidget {
  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [MobileThemeRotator] matching the given parameters.
  const MobileThemeRotator({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SettingsTile.rotator(
        title: "settings_theme_rotator".trParams({
          "value": "settings_theme_${app.cookies.theme.value}".tr,
        }),
        description: "settings_theme_desc".tr,
        onTapLeft: app.cookies.rotateThemeL,
        onTapRight: app.cookies.rotateThemeR,
      ),
    );
  }

  // METHODS ===================================================================
}
