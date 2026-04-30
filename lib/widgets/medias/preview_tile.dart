import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/medias/media.dart";
import "../../utils/extensions.dart";
import "../images/covering_network_image.dart";
import "../images/xeppelin_logo.dart";
import "../text/auto_color_text.dart";
import "button_status.dart";
import "button_visit_website.dart";

/// A tile showing the preview of a media.
///
/// Used on the desktop main page.
class MediaPreviewTile extends StatelessWidget {
  // VARIABLES =================================================================

  /// The media being previewed.
  final Media media;

  /// The behavior when the box is tapped.
  final void Function()? onTap;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [MediaPreviewTile] matching the given parameters.
  const MediaPreviewTile({
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
                color: context.theme.colorScheme.surface.withAlpha(190),
                padding: EdgeInsets.all(XLayout.paddingS),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // NAME
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              media.title,
                              style: context.titleMediumOnSurface
                                  .copyWith(height: 1.25),
                            ),
                            if (media.hasSubtitle)
                              Text(
                                media.subtitle!,
                                style: context.labelSmallOnSurface,
                              ),
                          ],
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
                    // The blank lines force all summaries to be exactly 3 lines so they can have the same size when displayed.
                    AutoColorText(
                      "${media.summary}\n\n",
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
