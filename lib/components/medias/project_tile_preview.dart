import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/medias/media.dart";
import "../../widgets/images/covering_network_image.dart";
import "../../widgets/medias/button_visit_website.dart";
import "../../widgets/text/auto_color_text.dart";

/// A preview of a project.
class MediaTilePreview extends StatelessWidget {
  // VARIABLES =================================================================

  /// The project being previewed.
  final Media media;

  /// The behavior when the box is tapped.
  final void Function()? onTap;

  /// An optional margin object.
  final EdgeInsets? margin;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [MediaTilePreview] matching the given parameters.
  const MediaTilePreview({
    super.key,
    required this.media,
    this.onTap,
    this.margin,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => XListTile(
        onTap: onTap,
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              media.name,
              style: context.textTheme.titleMedium,
              overflow: TextOverflow.ellipsis,
            ),
            MediaButtonVisitWebsite(
              media: media,
              iconOnly: true,
              margin: EdgeInsets.only(left: XLayout.paddingM),
            )
          ],
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
