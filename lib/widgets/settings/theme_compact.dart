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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        XLayout.verticalM,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: XLayout.paddingM),
          child: Text(
            "settings_theme_selection".tr,
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
            itemCount: app.themes.handledThemes.length,
            itemBuilder: (_, index) {
              final String name = app.themes.handledThemes[index];
              final ThemeData data = app.themes.all[name]!;
              return SizedBox(
                  width: XLayout.paddingL * 2.5,
                  child: ThemePreview(name: name, data: data));
            },
            separatorBuilder: (context, index) => XLayout.horizontalS,
          ),
        ),
        XLayout.verticalM,
      ],
    );
  }

// WIDGETS ===================================================================
}
