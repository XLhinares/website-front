import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../utils/exports.dart";

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
        SizedBox(
          width: Get.width * .4,
          child: GestureDetector(
            onHorizontalDragEnd: (details) {
              if ((details.primaryVelocity ?? 0) > 10) {
                cookies.rotateTheme(reverse: true);
              } else if ((details.primaryVelocity ?? 0) < -10) {
                cookies.rotateTheme(reverse: false);
              }
            },
            child: XCard(
              color: context.theme.colorScheme.surface,
              internalHorizontalPadding: XLayout.paddingS,
              internalVerticalPadding: XLayout.paddingS,
              leading: GestureDetector(
                child: const Icon(Icons.chevron_left),
                onTap: () => cookies.rotateTheme(reverse: true),
              ),
              title: Center(
                child: Obx(() => Text(
                      cookies.theme.value.capitalizeFirst!,
                      style: context.textTheme.bodyMedium,
                    )),
              ),
              trailing: GestureDetector(
                child: const Icon(Icons.chevron_right),
                onTap: () => cookies.rotateTheme(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // METHODS ===================================================================
}
