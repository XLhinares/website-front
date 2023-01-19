import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/dataclass/media.dart";
import "../../utils/utils.dart";
import "../widgets.dart";

/// A widget displaying all the top-level info on the given project.
class MediaMobileHeader extends StatelessWidget {
  // VARIABLES =================================================================

  /// The metadata of the project.
  final Media media;

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
    return SizedBox(
      width: Get.width,
      height: Get.height - navigationBarHeight,
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
                _goBack(context),
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

                      // Title bloc
                      Text(
                        media.name,
                        style: context.textTheme.titleLarge,
                      ),
                      XLayout.verticalS, // Tags bloc.
                      Wrap(
                        spacing: XLayout.paddingXS,
                        runSpacing: XLayout.paddingXS,
                        children: media.tags
                            .map((tag) => FittedBox(
                          fit: BoxFit.scaleDown,
                          child: XContainer(
                            padding: EdgeInsets.all(XLayout.paddingXS),
                            child: Text(
                              tag,
                              style: context.textTheme.labelSmall,
                            ),
                          ),
                        ))
                            .toList(),
                      ),

                      XLayout.verticalM,

                      AutoColorText(media.summary),

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
    );
  }

// WIDGETS ===================================================================
  BoxDecoration _decoration(BuildContext context) => BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.transparent,
          context.theme.colorScheme.background.withOpacity(0.6),
          context.theme.colorScheme.background.withOpacity(0.9),
          context.theme.colorScheme.background.withOpacity(0.95),
          context.theme.colorScheme.background,
        ],
        stops: const [
          0,
          0.25,
          0.6,
          0.8,
          0.95,
        ]),
  );

  Widget _goBack(BuildContext context) => FittedBox(
    child: XInkContainer(
      onTap: () => router.selectProject(null),
      margin: EdgeInsets.all(XLayout.paddingM),
      padding: EdgeInsets.only(
        top: XLayout.paddingS,
        bottom: XLayout.paddingS,
        left: XLayout.paddingS,
        right: XLayout.paddingM,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.keyboard_arrow_left,
            size: XLayout.paddingM,
          ),
          Text(
            "Go back",
            style: context.textTheme.labelSmall,
          ),
        ],
      ),
    ),
  );

  Widget _seeMore(BuildContext context) => GetBuilder(
    init: user,
    builder: (_) => AnimatedSwitcher(
      duration: animDurationShort,
      child: user.hasParts(media.id) && user.getParts(media.id)!.isNotEmpty
          ? XInkContainer(
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
              "Scroll to see more...",
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
}
