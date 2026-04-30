import "package:flutter/material.dart";
import "package:x_containers/x_containers.dart";

import "background_compact.dart";
import "theme_selection_compact.dart";

/// The widget in which the user can select a theme and background for the app.
class SettingsPreferencesCompact extends StatelessWidget {
  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns a [SettingsPreferencesCompact] matching the given parameters.
  const SettingsPreferencesCompact({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return XContainer(
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          const SettingsThemeSelectionCompact(),
          XLayout.verticalS,
          const SettingsBackgroundCompact(),
        ],
      ),
    );
  }

// WIDGETS ===================================================================
}
