import "package:flutter/material.dart";
import "package:x_containers/x_containers.dart";

import "../../components/exports.dart";

/// The content of the body in the "Settings" mode.
class DesktopMainSettings extends StatelessWidget {
  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns a [DesktopMainSettings] matching the given parameters.
  const DesktopMainSettings({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: XLayout.paddingL),
      physics: const BouncingScrollPhysics(),
      children: [
        const SettingsHeader(),
        XLayout.verticalL,
        SettingsLocale(),
        XLayout.verticalM,
        const SettingsThemes(),
        XLayout.verticalM,
        const SettingsLegal(),
      ],
    );
  }

  // WIDGETS ===================================================================
}
