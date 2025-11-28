import "package:auto_size_text/auto_size_text.dart";
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
          leftBehavior: () => cookies.rotateTheme(reverse: true),
          rightBehavior: () => cookies.rotateTheme(reverse: false),
          width: Get.width * .3,
          child: Obx(
            () => AutoSizeText(
              cookies.theme.value.capitalizeFirst!,
              minFontSize: 8,
              maxLines: 1,
              style: context.textTheme.bodyMedium,
            ),
          ),
        ),
      ],
    );
  }

  // METHODS ===================================================================
}
