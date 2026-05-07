import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:get/get.dart";

import "../../classes/medias/media.dart";
import "../../utils/extensions.dart";
import "button.dart";

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
    return MediaButton(
      icon: FaIcon(
        FontAwesomeIcons.github,
        color: iconOnly ? context.colors.secondary : context.colors.onSecondary,
      ),
      tooltipMessage: "${media.type.name}_github_button_tooltip".tr,
      hideCondition: () => hideIfNoGithub && !media.hasGithub,
      iconOnly: iconOnly,
      margin: margin,
      onTap: media.launchGithub,
    );
  }

  // METHODS ===================================================================
}
