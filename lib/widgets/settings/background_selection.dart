import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/dataclass/background_data.dart";
import "background_preview.dart";

/// A setting widget allowing to manage the background of the app.
class SettingsBackgroundSelection extends StatelessWidget {
  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [SettingsBackgroundSelection] matching the given parameters.
  const SettingsBackgroundSelection({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return XListTile(
      internalVerticalPadding: XLayout.paddingM,
      title: Text("settings_background_selection".tr),
      content: GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: XLayout.paddingL * 4,
            mainAxisSpacing: XLayout.paddingM,
            crossAxisSpacing: XLayout.paddingM,
            childAspectRatio: 1),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: BackgroundData.values.length,
        itemBuilder: (_, index) {
          return BackgroundPreview(BackgroundData.values[index]);
        },
      ),
    );
  }

// METHODS ===================================================================
}
