import "package:flutter/material.dart";
import "package:get/get.dart";

import "../../globals.dart";
import "settings_tile.dart";

/// The settings allowing the user to set the background of the app.
class MobileBackgroundRotator extends StatelessWidget {
  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [MobileBackgroundRotator] matching the given parameters.
  const MobileBackgroundRotator({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SettingsTile.rotator(
        title: "settings_background_rotator".trParams({
          "value": "settings_background_${app.cookies.background.value}".tr,
        }),
        description: "settings_background_desc".tr,
        onTapLeft: app.cookies.rotateBackgroundL,
        onTapRight: app.cookies.rotateBackgroundR,
      ),
    );
  }

  // METHODS ===================================================================
}
