import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../utils/exports.dart";

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
        child: cookies.cookieBannerDismissed.value
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
                        TextButton(
                          style: PresetStyles.secondaryButtonStyle(context),
                          onPressed: () {
                            cookies.cookieBannerDismissed.value = true;
                            cookies.cookies.value = false;
                          },
                          child: Text(
                            "cookies_decline".tr,
                          ),
                        ),
                        XLayout.horizontalS,
                        TextButton(
                          style: PresetStyles.secondaryButtonStyle(context),
                          onPressed: () {
                            cookies.cookieBannerDismissed.value = true;
                            cookies.cookies.value = true;
                          },
                          child: Text(
                            "cookies_accept".tr,
                          ),
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
