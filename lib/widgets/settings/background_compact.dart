import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/dataclass/background_data.dart";
import "background_preview.dart";

/// The widget in which the user can select a theme for the app.
class SettingsBackgroundsCompact extends StatelessWidget {
  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns a [SettingsBackgroundsCompact] matching the given parameters.
  const SettingsBackgroundsCompact({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return XCard(
      margin: EdgeInsets.zero,
      padding: XLayout.edgeInsetsAllM,
      internalVerticalPadding: XLayout.paddingM,
      title: Text("settings_background_selection".tr),
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
        itemCount: BackgroundData.values.length,
        itemBuilder: (_, index) {
          return BackgroundPreview(BackgroundData.values[index]);
        },
      ),
    );
  }

// WIDGETS ===================================================================
}
