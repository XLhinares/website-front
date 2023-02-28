import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/medias/medias.dart";
import "../../utils/utils.dart";
import "../widgets.dart";
import "medias.dart";

/// A widget displaying the metadata of the given media on desktop.
class MediaDesktopHeader<T extends Media> extends StatelessWidget {
  // VARIABLES =================================================================

  /// The project in question.
  final T media;

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
                padding: EdgeInsets.all(XLayout.paddingM),
                child: Column(
                  children: [
                    _goBack(context),
                    // Spacing
                    XLayout.verticalL,
                    const Expanded(child: SizedBox()),

                    // Name & date
                    AutoColorText("\\title{${media.name}}",
                        style: context.textTheme.titleLarge),
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

                    AutoColorText(media.summary),

                    // Spacing
                    const Expanded(child: SizedBox()),
                    _seeMore(context),
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

  Widget _goBack(BuildContext context) => Align(
        alignment: Alignment.topLeft,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: XInkContainer(
            enableShadow: false,
            onTap: () {
              final type = MediaType.fromType(T);
              if (type == MediaType.project) router.selectProject(null);
              if (type == MediaType.blog) router.selectBlog(null);
            },
            child: Row(
              children: [
                Icon(
                  Icons.keyboard_arrow_left,
                  size: XLayout.paddingM,
                ),
                Text(
                  "Go back",
                  style: context.textTheme.labelSmall,
                ),
                XLayout.horizontalXS,
              ],
            ),
          ),
        ),
      );

  Widget _seeMore(BuildContext context) => GetBuilder(
        init: user,
        builder: (_) => SizedBox(
          height: XLayout.paddingL * 2,
          child: AnimatedSwitcher(
            duration: animDurationShort,
            child: user.hasContent(media.id) &&
                    user.getContent(media.id)!.isNotEmpty
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: XInkContainer(
                        enableShadow: false,
                        onTap: () => scrollController?.animateTo(
                          Get.height,
                          duration: animDurationShort,
                          curve: Curves.easeIn,
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Scroll to see more...",
                              style: context.textTheme.labelSmall,
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              size: XLayout.paddingM,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
        ),
      );
}
