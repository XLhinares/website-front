import "package:flutter/widgets.dart";

import "../../classes/medias/media.dart";
import "button_status.dart";
import "button_visit_github.dart";
import "button_visit_website.dart";

/// A row of buttons to display for a media
class MediaButtonRow extends StatelessWidget {
  // VARIABLES =================================================================

  /// The media whose details are being displayed.
  final Media media;

  /// Whether to only show icons (ie. without boxes)
  final bool iconOnly;

  // CONSTRUCTOR ===============================================================

  /// Returns a [MediaButtonRow] instance.
  const MediaButtonRow({
    super.key,
    required this.media,
    this.iconOnly = false,
  });

  // BUILD =====================================================================
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MediaButtonStatus(
          media: media,
          iconOnly: iconOnly,
        ),
        MediaButtonVisitGithub(
          media: media,
          iconOnly: iconOnly,
        ),
        MediaButtonVisitWebsite(
          media: media,
          iconOnly: iconOnly,
        ),
      ],
    );
  }

  // METHODS ===================================================================
}
