import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/medias/medias.dart";
import "../../widgets/images/covering_network_image.dart";
import "../../widgets/text/auto_color_text.dart";

/// A preview of a project.
class MediaWidePreview extends StatelessWidget {
  // VARIABLES =================================================================

  /// The project being previewed.
  final Media media;

  /// The behavior when the box is tapped.
  final void Function()? onTap;

  /// An optional margin object.
  final EdgeInsets? margin;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [MediaWidePreview] matching the given parameters.
  const MediaWidePreview({
    super.key,
    required this.media,
    this.onTap,
    this.margin,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => XCard(
        onTap: onTap,
        padding: EdgeInsets.only(right: XLayout.paddingM),
        margin: margin ?? EdgeInsets.only(bottom: XLayout.paddingM),
        internalHorizontalPadding: XLayout.paddingM,
        leading: SizedBox(
          width: constraints.maxWidth * 0.3,
          child: CoveringNetworkImage(
            media.preview,
            fit: BoxFit.fitWidth,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(XLayout.paddingXS),
              bottomLeft: Radius.circular(XLayout.paddingXS),
            ),
          ),
        ),
        title: Text(
          media.name,
          style: context.textTheme.titleMedium,
        ),
        content: AutoColorText(
          media.summary,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: context.textTheme.bodyMedium,
        ),
      ),
    );
    // );
  }

// METHODS ===================================================================
}
