import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/medias/media.dart";
import "../../utils/extensions.dart";
import "../images/covering_network_image.dart";
import "../images/xeppelin_logo.dart";
import "button_status.dart";
import "../text/auto_color_text.dart";
import "button_visit_website.dart";

/// A preview of a media.
class ProjectPreviewer extends StatelessWidget {
  // VARIABLES =================================================================

  /// The media being previewed.
  final Media media;

  /// The behavior when the box is tapped.
  final void Function()? onTap;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [ProjectPreviewer] matching the given parameters.
  const ProjectPreviewer({
    super.key,
    required this.media,
    this.onTap,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return XButton(
      height: Get.height * 0.25,
      padding: EdgeInsets.zero,
      onTap: onTap,
      child: ClipRRect(
        clipBehavior: Clip.hardEdge,
        borderRadius: XLayout.brcXS,
        child: Stack(
          children: [
            // IMAGE ----------------------------------------------------------
            Positioned.fill(
              child: CoveringNetworkImage(
                media.preview,
                errorBuilder: (context, object, trace) => const XeppelinLogo(),
              ),
            ),

            // DESCRIPTION ----------------------------------------------------
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: context.theme.colorScheme.surface.withAlpha(175),
                padding: EdgeInsets.all(XLayout.paddingS),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // NAME
                    Row(
                      children: [
                        Text(
                          media.name,
                          style: context.titleMediumOnSurface,
                        ),
                        Expanded(
                          child: SizedBox(),
                        ),
                        MediaButtonStatus(media: media),
                        MediaButtonVisitWebsite(media: media),
                      ],
                    ),

                    XLayout.verticalXS,
                    const Divider(),
                    XLayout.verticalXS,

                    // SUMMARY
                    AutoColorText(
                      media.summary,
                      style: context.bodyMediumOnSurface,
                      color: context.colors.onSurface,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),

            // WEBSITE --------------------------------------------------------
          ],
        ),
      ),
    );
  }
}
