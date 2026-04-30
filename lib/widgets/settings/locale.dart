import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../globals.dart";
import "../interactables/lr_selector.dart";

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
      padding: XLayout.edgeInsetsAllM,
      // We add "locale" in english so that it is always easy to find for a user
      // who might not be familiar with the currently selected language.
      title:
          "${"settings_locale".tr}${app.cookies.locale.value == "en" ? "" : " (Locale)"}",
      content: "settings_locale_desc".tr,
      internalVerticalPadding: XLayout.paddingS,
      trailing: LRSelector(
        leftBehavior: app.cookies.rotateLocaleL,
        rightBehavior: app.cookies.rotateLocaleR,
        width: width ?? XLayout.paddingL * 4,
        controller: app.cookies.locale.rx,
        textBuilder: (value) => "language_$value".tr,
      ),
    );
  }
}
