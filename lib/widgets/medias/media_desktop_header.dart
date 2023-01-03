import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/dataclass/dataclass.dart";
import "../../utils/utils.dart";
import "../widgets.dart";
import "medias.dart";

/// A widget displaying the metadata of the given media on desktop.
class MediaDesktopHeader extends StatelessWidget {
  // VARIABLES =================================================================

  /// The project in question.
  final Media media;

  /// An optional [ScrollController] to handle special scroll animation.
  final ScrollController? scrollController;

  // CONSTRUCTOR ===============================================================

  /// Returns a [MediaDesktopHeader] matching the given parameters.
  const MediaDesktopHeader({
    super.key,
    required this.media,
    this.scrollController,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        height: Get.height - 2 * XLayout.paddingL,
        width: constraints.maxWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: XContainer(
                padding: EdgeInsets.all(XLayout.paddingL),
                child: Column(
                  children: [
                    // Spacing
                    XLayout.verticalL,
                    const Expanded(child: SizedBox()),

                    // Name & date
                    AutoColorText("%bc ${media.name}",
                        defaultStyle: context.textTheme.titleLarge),
                    XLayout.verticalXS,
                    Text(media.date.legibleMY),
                    XLayout.verticalS,
                    Wrap(
                      spacing: XLayout.paddingXS,
                      runSpacing: XLayout.paddingXS,
                      children:
                          media.tags.map((tag) => MediaTag(tag: tag)).toList(),
                    ),
                    XLayout.verticalL,
                    // Summary

                    Text(media.summary),

                    // Spacing
                    const Expanded(child: SizedBox()),
                    Text(
                      "Scroll to see more...",
                      style: context.textTheme.labelSmall,
                    ),
                    IconButton(
                      onPressed: () => scrollController?.animateTo(
                        Get.height,
                        duration: animDurationShort,
                        curve: Curves.easeIn,
                      ),
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: XLayout.paddingL,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            XLayout.horizontalL,
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: constraints.maxWidth * 0.5),
              child: CoveringNetworkImage(
                media.preview,
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
      );
    });
  }

// WIDGETS ===================================================================

}
