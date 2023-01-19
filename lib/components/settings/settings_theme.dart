import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../utils/utils.dart";
import "../../widgets/settings/theme_preview.dart";

/// The widget in which the user can select a theme for the app.
class SettingsThemes extends StatelessWidget {
  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns a [SettingsThemes] matching the given parameters.
  const SettingsThemes({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return XCard(
      padding: EdgeInsets.all(XLayout.paddingM),
      internalVerticalPadding: XLayout.paddingM,
      title: Text("Theme selection".tr),
      content: GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: XLayout.paddingL * 4,
            mainAxisSpacing: XLayout.paddingM,
            crossAxisSpacing: XLayout.paddingM),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: themes.handledThemes.length,
        itemBuilder: (_, index) {
          final String name = themes.handledThemes[index];
          final ThemeData data = themes.all[name]!;
          return ThemePreview(name: name.capitalizeFirst!.tr, data: data);
        },
      ),
    );
  }

// WIDGETS ===================================================================

}
