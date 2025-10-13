import "package:flutter/material.dart";
import "package:x_containers/x_containers.dart";

import "../../components/exports.dart";

/// A tab where the user can configure the website on mobile.
class MobileSettings extends StatelessWidget {
  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns a [MobileSettings] matching the given parameters.
  const MobileSettings({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(XLayout.paddingM),
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
