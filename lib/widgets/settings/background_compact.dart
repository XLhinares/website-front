import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/dataclass/background_data.dart";
import "background_preview.dart";

/// The widget in which the user can select a theme for the app.
class SettingsBackgroundCompact extends StatelessWidget {
  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns a [SettingsBackgroundCompact] matching the given parameters.
  const SettingsBackgroundCompact({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        XLayout.verticalM,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: XLayout.paddingM),
          child: Text(
            "settings_background_selection".tr,
            style: context.textTheme.titleMedium,
          ),
        ),
        XLayout.verticalS,
        SizedBox(
          height: XLayout.paddingL * 2.5,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: XLayout.paddingM),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: BackgroundData.values.length,
            itemBuilder: (_, index) {
              return SizedBox(
                width: XLayout.paddingL * 2.5,
                child: BackgroundPreview(BackgroundData.values[index]),
              );
            },
            separatorBuilder: (context, index) => XLayout.horizontalS,
          ),
        ),
        XLayout.verticalM,
      ],
    );
  }
}
