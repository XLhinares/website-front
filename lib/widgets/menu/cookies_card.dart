import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../globals.dart";
import "../../utils/extensions.dart";

/// A card explaining what how this site uses cookies.
class CookiesCard extends StatelessWidget {
  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [CookiesCard] matching the given parameters.
  const CookiesCard({
    super.key,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedSwitcher(
        duration: animDurationShort,
        child: app.cookies.cookieBannerDismissed.value
            ? const SizedBox()
            : XCard(
                margin: EdgeInsets.only(top: XLayout.paddingM),
                padding: EdgeInsets.all(XLayout.paddingM),
                title: Text(
                  "cookies_title".tr,
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "cookies_description".tr,
                    ),
                    XLayout.verticalS,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: SizedBox(),
                        ),
                        XButton.text(
                          "cookies_decline".tr,
                          textStyle: context.bodyMediumOnSecondary,
                          color: context.colors.secondary,
                          onTap: () {
                            app.cookies.cookieBannerDismissed.value = true;
                            app.cookies.allowCookies.value = false;
                          },
                        ),
                        XLayout.horizontalS,
                        XButton.text(
                          "cookies_accept".tr,
                          textStyle: context.bodyMediumOnSecondary,
                          color: context.colors.secondary,
                          onTap: () {
                            app.cookies.cookieBannerDismissed.value = true;
                            app.cookies.allowCookies.value = true;
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
      ),
    );
  }

  // METHODS ===================================================================
}
