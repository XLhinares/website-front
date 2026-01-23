import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../globals.dart";
import "../../widgets/settings/disable_cookies_button.dart";
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
      title: "cookie_policy_title".tr,
      content: app.network.getLegal("cookie_policy"),
      appendix: XContainer(
        padding: EdgeInsets.symmetric(
          horizontal: XLayout.paddingL,
          vertical: XLayout.paddingM,
        ),
        child: Row(
          children: [
            Text(
              "settings_disable_cookies".tr,
            ),
            const Expanded(child: SizedBox()),
            const DisableCookiesButton(),
          ],
        ),
      ),
    );
  }
}
