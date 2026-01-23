import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../globals.dart";
import "../../widgets/interactables/lr_selector.dart";

/// The widget in which the user can select a locale for the app.
class SettingsLocaleCompact extends StatelessWidget {
  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns a [SettingsLocaleCompact] matching the given parameters.
  const SettingsLocaleCompact({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return XContainer(
      margin: EdgeInsets.zero,
      child: Row(
        children: [
          XLayout.horizontalS,
          Text(
            "settings_locale".tr,
            style: context.textTheme.titleMedium,
          ),
          Expanded(child: SizedBox()),
          LRSelector(
            leftBehavior: () => app.cookies.rotateLocale(reverse: true),
            rightBehavior: () => app.cookies.rotateLocale(reverse: false),
            width: Get.width * .3,
            controller: app.cookies.locale.rx,
            textBuilder: (value) => "language_$value".tr,
          ),
        ],
      ),
    );
  }

// WIDGETS ===================================================================
}
