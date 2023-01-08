import "package:flutter/material.dart";
import "package:get/get.dart";

import "legal_tab.dart";

/// A tab to display the data policy of the website
class PrivacyPolicy extends StatelessWidget {
  // CONSTRUCTOR ===============================================================

  /// Returns a [PrivacyPolicy] matching the given parameters.
  const PrivacyPolicy({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return TabLegal(
      title: "Privacy policy".tr,
      text: "privacy_policy.md".tr,
    );
  }
}
