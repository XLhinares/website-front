import "package:flutter/material.dart";
import "package:get/get.dart";

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
      text: "legal_mentions.md".tr,
    );
  }
}
