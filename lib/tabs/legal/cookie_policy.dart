import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../widgets/widgets.dart";
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
      appendix: XContainer(
        padding: EdgeInsets.symmetric(
          horizontal: XLayout.paddingL,
          vertical: XLayout.paddingM,
        ),
        child: Row(
          children: [
            Text(
              "Delete and disable cookies".tr,
            ),
            const Expanded(child: SizedBox()),
            const DisableCookiesButton(),
          ],
        ),
      ),
    );
  }
}
