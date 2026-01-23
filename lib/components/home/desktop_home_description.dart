// Framework dependencies
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../widgets/text/auto_color_text.dart";
import "social_media_links.dart";

/// A widget describing what the site is about.
class DesktopHomeDescription extends StatelessWidget {
  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [DesktopHomeDescription] matching the given parameters.
  const DesktopHomeDescription({
    super.key,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return XContainer(
      padding: EdgeInsets.all(XLayout.paddingL),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: ListView(
                shrinkWrap: true,
                padding: XLayout.edgeInsetsAllM,
                children: [
                  AutoColorText(
                    "home_description_title".tr,
                    style: context.textTheme.titleMedium,
                  ),
                  XLayout.verticalM,
                  AutoColorText(
                    "home_description_content".tr,
                    style: context.textTheme.titleMedium,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
          XLayout.verticalM,
          SocialMediaLinks(
            iconSize: XLayout.paddingL,
          ),
          // XLayout.verticalM,
        ],
      ),
    );
  }

  // METHODS ===================================================================
}
