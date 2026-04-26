import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/medias/media.dart";
import "../../utils/extensions.dart";

/// A button that launches a website's media.
///
/// It is useless if the media doesn't have a website.
class MediaButtonVisitWebsite extends StatelessWidget {
  // VARIABLES =================================================================

  /// The matching media.
  final Media media;

  /// Whether the button should be replaced by an empty `SizedBox` when the website is null.
  final bool hideIfNoWebsite;

  // CONSTRUCTOR ===============================================================

  /// Returns a [MediaButtonVisitWebsite] instance.
  const MediaButtonVisitWebsite({
    super.key,
    required this.media,
    this.hideIfNoWebsite = true,
  });

  // BUILD =====================================================================
  @override
  Widget build(BuildContext context) {
    if (hideIfNoWebsite && media.hasNoWebsite) return SizedBox();

    return Tooltip(
      message: "project_website_button_tooltip".tr,
      child: XButton(
        margin: EdgeInsets.only(left: XLayout.paddingS),
        padding: XLayout.edgeInsetsAllXS,
        width: XLayout.paddingL,
        height: XLayout.paddingL,
        color: context.colors.secondary,
        onTap: media.launchWebsite,
        child: Icon(
          Icons.open_in_new,
          color: context.colors.onSecondary,
        ),
      ),
    );
  }

  // METHODS ===================================================================
}
