import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../globals.dart";
import "../../widgets/interactables/lr_selector.dart";

/// The row settings allowing the user to set the locale of the app.
class SettingsLocale extends StatelessWidget {
  // VARIABLES =================================================================

  /// The horizontal extent of the "selector" box
  final double? width;

  // CONSTRUCTOR ===============================================================

  /// The row settings allowing the user to set the locale of the app.
  const SettingsLocale({
    super.key,
    this.width,
  });

  /// A preset [SettingsLocale] with a compact "selector" widget.
  factory SettingsLocale.compact({Key? key}) => SettingsLocale(
        key: key,
        width: XLayout.paddingL * 4,
      );

  /// A preset [SettingsLocale] with a compact "selector" widget.
  factory SettingsLocale.wide({Key? key}) => SettingsLocale(
        key: key,
        width: Get.width * 0.4,
      );

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return XCard.text(
      padding: EdgeInsets.only(
        top: XLayout.paddingM,
        bottom: XLayout.paddingM,
        right: XLayout.paddingM,
        left: XLayout.paddingM,
      ),
      // We add "locale" in english so that it is always easy to find for a user
      // who might not be familiar with the currently selected language.
      title:
          "${"settings_locale".tr}${cookies.locale.value == "en" ? "" : " (Locale)"}",
      content: "settings_locale_description".tr,
      internalVerticalPadding: XLayout.paddingS,
      trailing: LRSelector(
        leftBehavior: () => cookies.rotateLocale(reverse: true),
        rightBehavior: () => cookies.rotateLocale(reverse: false),
        width: width ?? XLayout.paddingL * 4,
        child: Obx(
          () => Text(
            cookies.locale.value.capitalize!,
            style: context.textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}
