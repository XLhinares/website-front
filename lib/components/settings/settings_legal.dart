import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../utils/globals.dart";
import "../../widgets/exports.dart";

/// A setting where you can control your cookie consent and check out the legal stuff.
class SettingsLegal extends StatelessWidget {
  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns a [SettingsLegal] matching the given parameters.
  const SettingsLegal({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return XCard(
      padding: EdgeInsets.only(
        top: XLayout.paddingM,
        bottom: XLayout.paddingM,
        left: XLayout.paddingM,
        right: XLayout.paddingM,
      ),
      title: Text("Copyright".tr),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Xeppelin $versionNumber © 2023, All rights reserved.".tr,
          ),
          XLayout.verticalXS,
          AutoColorText("settings_legal".tr),
        ],
      ),
      trailing: const DisableCookiesButton(),
    );
  }

// WIDGETS ===================================================================
}
