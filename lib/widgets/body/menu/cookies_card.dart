// Flutter dependencies
import "package:flutter/material.dart";

// Package dependencies
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

// Project dependencies
import "package:website_front/utils/globals.dart";

/// A card explaining what how this site uses cookies.
class CookiesCard extends StatelessWidget {

  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [CookiesCard] matching the given parameters.
  const CookiesCard({super.key,});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Obx(() => AnimatedSwitcher(
      duration: animDurationShort,
      child: settings.cookies.value
        ? const SizedBox()
        : XCard(
          margin: EdgeInsets.only(top: XLayout.paddingM),
          padding: EdgeInsets.all(XLayout.paddingM),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Cookies title".tr),
              IconButton(
                  onPressed: () => settings.cookies.value = true,
                  icon: const Icon(Icons.close),
              )
            ],
          ),
          subtitle: Text("Cookies description".tr),
        ),
    ),
    );
  }

  // METHODS ===================================================================

}
