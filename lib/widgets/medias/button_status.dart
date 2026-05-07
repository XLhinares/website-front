import "package:flutter/material.dart";
import "package:get/get.dart";

import "../../classes/medias/media.dart";
import "../../classes/medias/media_type.dart";
import "../../utils/extensions.dart";
import "button.dart";

/// A button that shows a media's ownership status.
///
/// It is isn't actually tapable but share all the other characteristics of media buttons.
class MediaButtonStatus extends StatelessWidget {
  // VARIABLES =================================================================

  /// The matching media.
  final Media media;

  /// Whether the button should be invisible when I'm the owner of the media.
  ///
  /// The goal is to avoid cluttering as I am owner of most projects.
  final bool hideIfOwner;

  /// Whether the button should be invisible if the media is not a project.
  ///
  /// The goal is to avoid cluttering as every person on the people page would end up having a button.
  final bool hideIfNotProject;

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
    this.hideIfNotProject = true,
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
      tooltipMessage: "${media.type.name}_status_${media.status}_tooltip".tr,
      hideCondition: () =>
          hideIfOwner && media.isOwner ||
          hideIfNotProject && media.type != MediaType.project,
      iconOnly: iconOnly,
      margin: margin,
    );
  }

  // METHODS ===================================================================
}
