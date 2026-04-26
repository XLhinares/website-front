import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/medias/media.dart";
import "../../globals.dart";
import "../../utils/tools.dart";
import "../images/covering_network_image.dart";
import "../text/auto_color_text.dart";
import "button_go_back.dart";
import "button_visit_website.dart";
import "media_tag.dart";

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
                    Row(
                      children: [
                        MediaButtonGoBack(),
                        Expanded(child: SizedBox()),
                        // Website
                        MediaButtonVisitWebsite(media: media),
                      ],
                    ),

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
                    XLayout.verticalL,

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

  Widget _seeMore(BuildContext context) => GetBuilder(
        init: app.medias,
        builder: (_) => SizedBox(
          height: XLayout.paddingL * 2,
          child: AnimatedSwitcher(
            duration: animDurationShort,
            child: app.medias.hasContent(media.id) &&
                    app.medias.getContent(media.id)!.isNotEmpty
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: XButton(
                        enableShadow: false,
                        onTap: () => scrollController?.animateTo(
                          Get.height,
                          duration: animDurationShort,
                          curve: Curves.easeIn,
                        ),
                        child: Column(
                          children: [
                            Text(
                              "button_scroll_to_see_more".tr,
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
