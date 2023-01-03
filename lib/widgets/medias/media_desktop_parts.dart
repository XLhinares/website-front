import "package:flutter/material.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/dataclass/dataclass.dart";
import "../widgets.dart";

/// A widget displaying the parts of the given media on desktop.
class MediaDesktopParts extends StatelessWidget {
  // VARIABLES =================================================================

  /// The parts of the media.
  final MediaParts parts;

  // CONSTRUCTOR ===============================================================

  /// Returns a [MediaDesktopParts] matching the given parameters.
  const MediaDesktopParts({
    super.key,
    required this.parts,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: parts.entries.length,
      itemBuilder: (context, index) => _entryWidget(parts.entries[index]),
      separatorBuilder: (context, index) => XLayout.verticalL,
    );
  }

  // WIDGETS ===================================================================

  Widget _entryWidget(MediaPartEntry entry) {
    switch (entry.type) {
      case MediaPartType.text:
        return XContainer(
          padding: EdgeInsets.all(XLayout.paddingM),
          child: AutoColorText(entry.content),
        );
      case MediaPartType.image:
        return CoveringNetworkImage(entry.content);
      default:
        return const SizedBox();
    }
  }
}
