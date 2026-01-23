import "package:flutter/material.dart";
import "package:get/get.dart";

import "../../globals.dart";
import "legal_tab.dart";

/// A tab to display the legal mentions of the website
class LegalMentions extends StatelessWidget {
  // CONSTRUCTOR ===============================================================

  /// Returns a [LegalMentions] matching the given parameters.
  const LegalMentions({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return TabLegal(
      title: "Legal mentions".tr,
      content: app.network.getLegal("legal_mentions"),
    );
  }
}
