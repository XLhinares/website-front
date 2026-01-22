import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../globals.dart";
import "../interactables/lr_selector.dart";

/// A setting widget allowing to manage the theme of the app.
class SettingsThemeSelectionCompact extends StatelessWidget {
  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [SettingsThemeSelectionCompact] matching the given parameters.
  const SettingsThemeSelectionCompact({
    super.key,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        XLayout.horizontalS,
        Text(
          "settings_theme_selection".tr,
          style: context.textTheme.titleMedium,
        ),
        Expanded(child: XLayout.horizontalL),
        LRSelector(
            leftBehavior: () => app.cookies.rotateTheme(reverse: true),
            rightBehavior: () => app.cookies.rotateTheme(reverse: false),
            width: Get.width * .3,
            controller: app.cookies.theme.rx),
      ],
    );
  }

  // METHODS ===================================================================
}
