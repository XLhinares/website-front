import "package:flutter/material.dart";
import "package:get/get.dart";

import "legal_tab.dart";

/// A tab to display the cookie policy of the website
class CookiePolicy extends StatelessWidget {
  // CONSTRUCTOR ===============================================================

  /// Returns a [CookiePolicy] matching the given parameters.
  const CookiePolicy({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return TabLegal(
      title: "Cookie policy".tr,
      text: "cookie_policy.md".tr,
    );
  }
}
