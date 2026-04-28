import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/medias/media.dart";
import "../images/covering_network_image.dart";
import "../text/auto_color_text.dart";
import "button_visit_website.dart";

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
      builder: (context, constraints) => XButton(
        onTap: onTap,
        margin: margin ?? EdgeInsets.only(bottom: XLayout.paddingM),
        padding: EdgeInsets.zero,
        child: Row(
          children: [
            // IMAGE
            SizedBox(
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
            XLayout.horizontalS,
            Expanded(
              child: Column(
                children: [
                  XLayout.verticalS,
                  // TITLE ROW
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        media.name,
                        style: context.textTheme.titleMedium,
                      ),
                      MediaButtonVisitWebsite(
                        media: media,
                      ),
                    ],
                  ),
                  XLayout.verticalS,

                  // DESCRIPTION
                  Expanded(
                    child: Align(
                      alignment: AlignmentGeometry.centerLeft,
                      child: AutoColorText(
                        media.summary,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.bodyMedium,
                      ),
                    ),
                  ),
                  XLayout.verticalS,
                ],
              ),
            ),
            XLayout.horizontalS,
          ],
        ),
      ),
    );
    // );
  }

// METHODS ===================================================================
}
