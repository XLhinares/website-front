import "package:flutter/material.dart";
import "package:get/get.dart";

import "../../classes/medias/media.dart";
import "../../utils/extensions.dart";
import "button.dart";

/// A button that launches a website's media.
///
/// It is useless if the media doesn't have a website.
class MediaButtonVisitWebsite extends StatelessWidget {
  // VARIABLES =================================================================

  /// The matching media.
  final Media media;

  /// Whether the button should be replaced by an empty `SizedBox` when the website is null.
  final bool hideIfNoWebsite;

  /// Whether to show only the button icon (and NOT the button box)
  final bool iconOnly;

  /// An optional margin to put around the button.
  final EdgeInsets? margin;

  // CONSTRUCTOR ===============================================================

  /// Returns a [MediaButtonVisitWebsite] instance.
  const MediaButtonVisitWebsite({
    super.key,
    required this.media,
    this.margin,
    this.hideIfNoWebsite = true,
    this.iconOnly = false,
  });

  // BUILD =====================================================================
  @override
  Widget build(BuildContext context) {
    return MediaButton(
      icon: Icon(
        Icons.open_in_new,
        color: iconOnly ? context.colors.secondary : context.colors.onSecondary,
      ),
      tooltipMessage: "project_website_button_tooltip".tr,
      hideCondition: () => hideIfNoWebsite && !media.hasWebsite,
      iconOnly: iconOnly,
      margin: margin,
      onTap: media.launchWebsite,
    );
  }

  // METHODS ===================================================================
}
