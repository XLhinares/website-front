import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/medias/media.dart";
import "../../utils/extensions.dart";

/// A button that launches a media's github.
///
/// It is useless if the media doesn't have a github.
class MediaButtonVisitGithub extends StatelessWidget {
  // VARIABLES =================================================================

  /// The matching media.
  final Media media;

  /// Whether the button should be replaced by an empty `SizedBox` when the github is null.
  final bool hideIfNoGithub;

  /// Whether to show only the button icon (and NOT the button box)
  final bool iconOnly;

  /// An optional margin to put around the button.
  final EdgeInsets? margin;

  // CONSTRUCTOR ===============================================================

  /// Returns a [MediaButtonVisitGithub] instance.
  const MediaButtonVisitGithub({
    super.key,
    required this.media,
    this.margin,
    this.hideIfNoGithub = true,
    this.iconOnly = false,
  });

  // BUILD =====================================================================
  @override
  Widget build(BuildContext context) {
    if (hideIfNoGithub && !media.hasGithub) return SizedBox();

    return Tooltip(
      message: "project_github_button_tooltip".tr,
      child: iconOnly
          ? GestureDetector(
              onTap: media.launchGithub,
              child: FaIcon(
                FontAwesomeIcons.github,
                color: context.colors.secondary,
              ),
            )
          : XButton(
              margin: margin ?? EdgeInsets.only(left: XLayout.paddingS),
              padding: XLayout.edgeInsetsAllXS,
              width: XLayout.paddingL,
              height: XLayout.paddingL,
              color: context.colors.secondary,
              onTap: media.launchGithub,
              child: FaIcon(
                FontAwesomeIcons.github,
                color: context.colors.onSecondary,
              ),
            ),
    );
  }

  // METHODS ===================================================================
}
