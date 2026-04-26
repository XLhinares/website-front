import "package:flutter/material.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/medias/media_content.dart";
import "media_desktop_entry.dart";

/// A widget displaying the parts of the given media on desktop.
class MediaDesktopContent extends StatelessWidget {
  // VARIABLES =================================================================

  /// The parts of the media.
  final MediaContent content;

  // CONSTRUCTOR ===============================================================

  /// Returns a [MediaDesktopContent] matching the given parameters.
  const MediaDesktopContent({
    super.key,
    required this.content,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: content.entries.length,
      itemBuilder: (context, index) =>
          MediaDesktopEntry(content.entries[index]),
      separatorBuilder: (context, index) => XLayout.verticalL,
    );
  }
}
