import "package:flutter/material.dart";
import "package:get/get.dart";

import "../../classes/medias/media.dart";
import "../../utils/extensions.dart";
import "button.dart";

/// A button that shows a media's ownership status.
///
/// It is isn't actually tapable but share all the other characteristics of media buttons.
class MediaButtonStatus extends StatelessWidget {
  // VARIABLES =================================================================

  /// The matching media.
  final Media media;

  /// Whether the button should be replaced by an empty `SizedBox` when the website is null.
  final bool hideIfOwner;

  /// Whether to show only the button icon (and NOT the button box)
  final bool iconOnly;

  /// An optional margin to put around the button.
  final EdgeInsets? margin;

  // CONSTRUCTOR ===============================================================

  /// Returns a [MediaButtonStatus] instance.
  const MediaButtonStatus({
    super.key,
    required this.media,
    this.margin,
    this.hideIfOwner = true,
    this.iconOnly = false,
  });

  // BUILD =====================================================================
  @override
  Widget build(BuildContext context) {
    return MediaButton(
      icon: Icon(
        Icons.group,
        color: iconOnly ? context.colors.secondary : context.colors.onSecondary,
      ),
      tooltipMessage: "project_status_${media.status}_tooltip".tr,
      hideCondition: () => hideIfOwner && media.isOwner,
      iconOnly: iconOnly,
      margin: margin,
    );
  }

  // METHODS ===================================================================
}
