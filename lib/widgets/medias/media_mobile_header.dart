import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/medias/media.dart";
import "../../globals.dart";
import "../../utils/tools.dart";
import "../images/covering_network_image.dart";
import "../images/xeppelin_logo.dart";
import "../text/auto_color_text.dart";

/// A widget displaying all the top-level info on the given project.
class MediaMobileHeader<T extends Media> extends StatelessWidget {
  // VARIABLES =================================================================

  /// The metadata of the project.
  final T media;

  /// An optional [ScrollController] to handle special scroll animation.
  final ScrollController? scrollController;

  // CONSTRUCTOR ===============================================================

  /// Returns a [MediaMobileHeader] matching the given parameters.
  const MediaMobileHeader({
    super.key,
    required this.media,
    this.scrollController,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: Get.width,
          height: Get.height,
          child: Stack(
            children: [
              // BACKGROUND --------------------------------------------------------
              Positioned.fill(
                child: CoveringNetworkImage(
                  media.preview,
                  errorBuilder: (_, __, ___) => const XeppelinLogo(),
                  fit: BoxFit.cover,
                ),
              ),

              // TEXT
              Positioned.fill(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(child: SizedBox()),
                    Container(
                      decoration: _decoration(context),
                      padding: EdgeInsets.all(XLayout.paddingL),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Adds extra room for the background gradient to be displayed.
                          XLayout.verticalL,
                          XLayout.verticalL,

                          // Title block
                          Text(
                            media.name,
                            style: context.textTheme.titleLarge!
                                .copyWith(color: context.colors.secondary),
                          ),
                          XLayout.verticalS, // Tags block.
                          Wrap(
                            spacing: XLayout.paddingXS,
                            runSpacing: XLayout.paddingXS,
                            children: media.tags
                                .map((tag) => FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: XContainer.text(
                                        tag,
                                        textStyle: context.textTheme.labelSmall,
                                        padding:
                                            EdgeInsets.all(XLayout.paddingXS),
                                      ),
                                    ))
                                .toList(),
                          ),

                          XLayout.verticalM,

                          AutoColorText(
                            media.summary,
                            color: context.colors.onSurface,
                          ),

                          XLayout.verticalL,

                          _seeMore(context),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          height: XLayout.paddingL,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: _gradientColors,
              stops: _gradientStops,
            ),
          ),
        ),
      ],
    );
  }

// WIDGETS ===================================================================
  BoxDecoration _decoration(BuildContext context) => BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: _gradientColors,
            stops: _gradientStops),
      );

  Widget _seeMore(BuildContext context) => GetBuilder(
        init: app.medias,
        builder: (_) => AnimatedSwitcher(
          duration: animDurationShort,
          child: app.medias.hasContent(media.id) &&
                  app.medias.getContent(media.id)!.isNotEmpty
              ? XButton(
                  color: Colors.transparent,
                  enableShadow: false,
                  onTap: () => scrollController?.animateTo(
                    Get.height,
                    duration: animDurationShort,
                    curve: Curves.easeIn,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
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
                )
              : const SizedBox(),
        ),
      );

  List<Color> get _gradientColors => [
        Get.theme.colorScheme.surface.withValues(alpha: 0),
        Get.theme.colorScheme.surface.withValues(alpha: 0.6),
        Get.theme.colorScheme.surface.withValues(alpha: 0.9),
        Get.theme.colorScheme.surface.withValues(alpha: 0.95),
        Get.theme.colorScheme.surface,
      ];
  List<double> get _gradientStops => const [
        0,
        0.25,
        0.6,
        0.8,
        0.95,
      ];
}
