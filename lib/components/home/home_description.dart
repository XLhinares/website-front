// Framework dependencies
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../widgets/text/auto_color_text.dart";
import "social_media_links.dart";

/// A widget describing what the site is about.
class HomeDescription extends StatelessWidget {
  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [HomeDescription] matching the given parameters.
  const HomeDescription({
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
            "home_description".tr,
            style: context.textTheme.titleMedium,
          ),
          XLayout.verticalM,
          SocialMediaLinks(),
        ],
      ),
    );
  }

  // METHODS ===================================================================
}
