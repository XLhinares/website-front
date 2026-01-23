// Framework dependencies
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../widgets/text/auto_color_text.dart";
import "social_media_links.dart";

/// A widget describing what the site is about.
class MobileHomeDescription extends StatelessWidget {
  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [MobileHomeDescription] matching the given parameters.
  const MobileHomeDescription({
    super.key,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return XContainer(
      padding: EdgeInsets.all(XLayout.paddingL),
      child: Column(
        children: [
          AutoColorText(
            "home_description_title".tr,
            style: context.textTheme.bodyMedium,
          ),
          XLayout.verticalM,
          AutoColorText(
            "home_description_content".tr,
            style: context.textTheme.bodyMedium,
            textAlign: TextAlign.justify,
          ),
          XLayout.verticalM,
          SocialMediaLinks(
            iconSize: XLayout.paddingL * 0.8,
          ),
          // XLayout.verticalM,
        ],
      ),
    );
  }

  // METHODS ===================================================================
}
