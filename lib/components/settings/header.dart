import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

/// A tab in which the user can customize his experience on the website.
class SettingsHeader extends StatelessWidget {
  // CONSTRUCTOR ===============================================================

  /// Returns a [SettingsHeader] matching the given parameters.
  const SettingsHeader({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return XCard(
      padding: EdgeInsets.all(XLayout.paddingM),
      title: Text("settings_title".tr),
      content: Text("settings_description".tr),
    );
  }
}
