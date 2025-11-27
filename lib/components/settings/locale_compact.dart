import "package:flutter/material.dart";
import "package:x_containers/x_containers.dart";

import "../../widgets/settings/locale_selection_compact.dart";

/// The widget in which the user can select a locale for the app.
class SettingsLocaleCompact extends StatelessWidget {
  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns a [SettingsLocaleCompact] matching the given parameters.
  const SettingsLocaleCompact({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return XContainer(
      margin: EdgeInsets.zero,
      child: const SettingsLocaleSelectionCompact(),
    );
  }

// WIDGETS ===================================================================
}
