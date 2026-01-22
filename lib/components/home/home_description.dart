// Framework dependencies
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../widgets/text/auto_color_text.dart";
import "social_media_links.dart";

/// A widget describing what the site is about.
class HomeDescription extends StatelessWidget {
  // VARIABLES =================================================================

  /// Whether to use the regular version or a smaller version to fit in smaller screen.
  ///
  /// This affects the text font size and the icon size.
  final bool useMobileSize;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [HomeDescription] matching the given parameters.
  const HomeDescription({super.key, this.useMobileSize = false});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    final TextStyle? textStyle = useMobileSize
        ? context.textTheme.bodyMedium
        : context.textTheme.titleMedium;
    final double iconSize =
        useMobileSize ? XLayout.paddingL * 0.8 : XLayout.paddingL;

    return XContainer(
      padding: EdgeInsets.all(XLayout.paddingL),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  AutoColorText(
                    "home_description_title".tr,
                    style: textStyle,
                  ),
                  XLayout.verticalM,
                  AutoColorText(
                    "home_description_content".tr,
                    style: textStyle,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
          XLayout.verticalM,
          SocialMediaLinks(
            iconSize: iconSize,
          ),
          // XLayout.verticalM,
        ],
      ),
    );
  }

  // METHODS ===================================================================
}
