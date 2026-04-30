import "package:flutter/material.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/dataclass/route.dart";
import "../../widgets/body/mobile_tab.dart";
import "../../widgets/body/tab.dart";
import "../../widgets/settings/legal_compact.dart";
import "../../widgets/settings/mobile_background_rotator.dart";
import "../../widgets/settings/mobile_locale_rotator.dart";
import "../../widgets/settings/mobile_theme_rotator.dart";

/// A tab where the user can configure the website on mobile.
class MobileMainSettings extends RouteTab {
  // VARIABLES =================================================================

  @override
  final AppRoute route = AppRoute.MAIN_SETTINGS;

  // CONSTRUCTOR ===============================================================

  /// Returns a [MobileMainSettings] matching the given parameters.
  MobileMainSettings({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return MobileTab(
      route: route,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: XLayout.paddingM,
        children: [
          MobileLocaleRotator(),
          const MobileThemeRotator(),
          const MobileBackgroundRotator(),
          SettingsLegalCompact(),
        ],
      ),
    );
  }

  // WIDGETS ===================================================================
}
