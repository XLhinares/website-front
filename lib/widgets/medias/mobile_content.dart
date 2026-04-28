import "package:flutter/material.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/medias/media_content.dart";
import "media_entry_widget.dart";

/// A widget displaying the parts of the given media on desktop.
class MediaMobileContent extends StatelessWidget {
  // VARIABLES =================================================================

  /// The parts of the media.
  final MediaContent content;

  // CONSTRUCTOR ===============================================================

  /// Returns a [MediaMobileContent] matching the given parameters.
  const MediaMobileContent({
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
      padding: EdgeInsets.all(XLayout.paddingM),
      itemBuilder: (context, index) => MediaEntryWidget(content.entries[index]),
      separatorBuilder: (context, index) => XLayout.verticalM,
    );
  }
}
