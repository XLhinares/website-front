import "package:flutter/material.dart";
import "package:x_containers/x_containers.dart";

import "../../widgets/settings/header.dart";
import "../../widgets/settings/legal.dart";
import "../../widgets/settings/locale.dart";
import "../../widgets/settings/theme.dart";

/// The content of the body in the "Settings" mode.
class DesktopMainSettings extends StatelessWidget {
  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns a [DesktopMainSettings] matching the given parameters.
  const DesktopMainSettings({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: XLayout.paddingL),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          const SettingsHeader(),
          XLayout.verticalL,
          SettingsLocale(),
          XLayout.verticalM,
          const SettingsThemes(),
          XLayout.verticalM,
          const SettingsLegal(),
        ],
      ),
    );
  }

  // WIDGETS ===================================================================
}
