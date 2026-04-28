import "package:flutter/widgets.dart";

import "../../classes/medias/media.dart";
import "../projects/status_tile.dart";
import "button_visit_github.dart";
import "button_visit_website.dart";

/// A row of buttons to display for a media
class MediaButtonRow extends StatelessWidget {
  // VARIABLES =================================================================

  final Media media;

  // CONSTRUCTOR ===============================================================

  /// Returns a [MediaButtonRow] instance.
  const MediaButtonRow({
    super.key,
    required this.media,
  });

  // BUILD =====================================================================
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MediaStatusWidget(media: media),
        MediaButtonVisitGithub(media: media),
        MediaButtonVisitWebsite(media: media),
      ],
    );
  }

  // METHODS ===================================================================
}
