import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../globals.dart";
import "theme_preview.dart";

/// A setting widget allowing to manage the theme of the app.
class SettingsThemeSelection extends StatelessWidget {
  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [SettingsThemeSelection] matching the given parameters.
  const SettingsThemeSelection({
    super.key,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return XListTile(
      internalVerticalPadding: XLayout.paddingM,
      title: Text("settings_theme_selection".tr),
      content: GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: XLayout.paddingL * 4,
            mainAxisSpacing: XLayout.paddingM,
            crossAxisSpacing: XLayout.paddingM),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: app.themes.handledThemes.length,
        itemBuilder: (_, index) {
          final String name = app.themes.handledThemes[index];
          final ThemeData data = app.themes.all[name]!;
          return ThemePreview(name: name, data: data);
        },
      ),
    );
  }

  // METHODS ===================================================================
}
