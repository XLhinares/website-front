import "package:flutter/material.dart";
import "package:x_containers/x_containers.dart";

import "../../widgets/settings/theme_selection_compact.dart";

/// The widget in which the user can select a theme for the app.
class SettingsThemesCompact extends StatelessWidget {
  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns a [SettingsThemesCompact] matching the given parameters.
  const SettingsThemesCompact({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return XContainer(
      margin: EdgeInsets.zero,
      child: const SettingsThemeSelectionCompact(),
    );
  }

// WIDGETS ===================================================================
}
