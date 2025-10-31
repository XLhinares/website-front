import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../utils/exports.dart";

/// A setting widget allowing to manage the locale of the app.
class SettingsLocaleSelectionCompact extends StatelessWidget {
  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [SettingsLocaleSelectionCompact] matching the given parameters.
  const SettingsLocaleSelectionCompact({
    super.key,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        XLayout.horizontalS,
        Text(
          "settings_locale".tr,
          style: context.textTheme.titleMedium,
        ),
        Expanded(child: SizedBox()),
        SizedBox(
          width: Get.width * .4,
          child: GestureDetector(
            onHorizontalDragEnd: (details) {
              if ((details.primaryVelocity ?? 0) > 10) {
                cookies.rotateLocale(reverse: true);
              } else if ((details.primaryVelocity ?? 0) < -10) {
                cookies.rotateLocale(reverse: false);
              }
            },
            child: XCard(
              color: context.theme.colorScheme.surface,
              internalHorizontalPadding: XLayout.paddingS,
              internalVerticalPadding: XLayout.paddingS,
              leading: GestureDetector(
                child: const Icon(Icons.chevron_left),
                onTap: () => cookies.rotateLocale(reverse: true),
              ),
              title: Center(
                child: Obx(() => Text(
                      cookies.locale.value.capitalize!,
                      style: context.textTheme.bodyMedium,
                    )),
              ),
              trailing: GestureDetector(
                child: const Icon(Icons.chevron_right),
                onTap: () => cookies.rotateLocale(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // METHODS ===================================================================
}
