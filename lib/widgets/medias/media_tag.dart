import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

/// A widget displaying a single tag (usually from a [Media]).
class MediaTag extends StatelessWidget {
  // VARIABLES =================================================================

  /// The name of the tag.
  final String tag;

  // CONSTRUCTOR ===============================================================

  /// Returns a [MediaTag] matching the given parameters.
  const MediaTag({
    super.key,
    required this.tag,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: XContainer(
        color: context.theme.colorScheme.surface,
        padding: EdgeInsets.all(XLayout.paddingXS),
        child: Text(
          tag,
          style: context.textTheme.labelSmall,
        ),
      ),
    );
  }

  // WIDGETS ===================================================================
}
