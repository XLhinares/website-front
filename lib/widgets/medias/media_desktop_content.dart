import "package:flutter/material.dart";
import "package:flutter_markdown/flutter_markdown.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/medias/medias.dart";
import "../widgets.dart";

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
      itemBuilder: (context, index) => _entryWidget(content.entries[index]),
      separatorBuilder: (context, index) => XLayout.verticalL,
    );
  }

  // WIDGETS ===================================================================

  Widget _entryWidget(MediaEntry entry) {
    switch (entry.type) {
      case MediaContentType.text:
        return XContainer(
          padding: EdgeInsets.all(XLayout.paddingM),
          child: MarkdownBody(data: entry.content),
        );
      case MediaContentType.image:
        return CoveringNetworkImage(entry.content);
      default:
        return const SizedBox();
    }
  }
}
