import "package:flutter/material.dart";
import "package:x_containers/x_containers.dart";

import "../../widgets/settings/background_selection.dart";
import "../../widgets/settings/theme_selection.dart";

/// The widget in which the user can select a theme for the app.
class SettingsThemes extends StatelessWidget {
  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns a [SettingsThemes] matching the given parameters.
  const SettingsThemes({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return XContainer(
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          const SettingsThemeSelection(),
          XLayout.verticalS,
          const SettingsBackgroundSelection(),
        ],
      ),
    );
  }

// WIDGETS ===================================================================
}
