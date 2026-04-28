import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../globals.dart";
import "theme_preview.dart";

/// The widget in which the user can select a theme for the app.
class SettingsThemesCompact extends StatelessWidget {
  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns a [SettingsThemesCompact] matching the given parameters.
  const SettingsThemesCompact({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return XCard(
      margin: EdgeInsets.zero,
      padding: XLayout.edgeInsetsAllM,
      internalVerticalPadding: XLayout.paddingM,
      title: Text("settings_theme_selection".tr),
      content: GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: XLayout.paddingL * 2.5,
          mainAxisSpacing: XLayout.paddingS,
          crossAxisSpacing: XLayout.paddingS,
          childAspectRatio: 1,
        ),
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

// WIDGETS ===================================================================
}
