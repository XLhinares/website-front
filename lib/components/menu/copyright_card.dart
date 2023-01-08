import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../widgets/text/auto_color_text.dart";

/// A main menu card with links redirecting to the legal tabs.
class CopyrightCard extends StatelessWidget {
  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns a [CopyrightCard] matching the given parameters.
  const CopyrightCard({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return XCard(
      padding: EdgeInsets.only(
        top: XLayout.paddingM,
        bottom: XLayout.paddingM,
        left: XLayout.paddingL,
        right: XLayout.paddingM,
      ),
      densityRatio: 0.5,
      title: Text(
        "2023, All rights reserved.",
        style: context.textTheme.bodyMedium,
      ),
      content: AutoColorText(
        "    - \\route{/legal/legal_mentions}{${"Legal mentions".tr}}\n"
        "    - \\route{/legal/privacy_policy}{${"Data policy".tr}}\n"
        "    - \\route{/legal/cookie_policy}{${"Cookie policy".tr}}",
        style: context.textTheme.labelMedium,
      ),
    );
  }

// WIDGETS ===================================================================

}
