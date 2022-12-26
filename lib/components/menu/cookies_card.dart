import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";
import "package:auto_size_text/auto_size_text.dart";

import "../../../utils/globals.dart";
import "../../widgets/widgets.dart";

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
        child: settings.cookies.value
            ? const SizedBox()
            : XCard(
                margin: EdgeInsets.only(top: XLayout.paddingM),
                padding: EdgeInsets.all(XLayout.paddingM),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PresetText.headline("Cookies title".tr),
                    IconButton(
                      onPressed: () => settings.cookies.value = true,
                      icon: const Icon(Icons.close),
                    )
                  ],
                ),
                content: AutoSizeText(
                  "Cookies description".tr,
                  style: PresetStyle.body.getStyle(context),
                ),
              ),
      ),
    );
  }

  // METHODS ===================================================================

}
