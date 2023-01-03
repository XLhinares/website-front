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

  // CONSTRUCTOR ===============================================================

  /// Returns a [MediaMobileHeader] matching the given parameters.
  const MediaMobileHeader({
    super.key,
    required this.media,
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
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: _decoration(context),
              padding: EdgeInsets.all(XLayout.paddingL),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Adds extra room for the background gradient to be displayed.
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

                  XLayout.verticalL,

                  // todo: description

                  // Adds extra room for the background gradient to be displayed.
                  XLayout.verticalM,
                ],
              ),
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
              0.3,
              0.6,
              0.8,
              0.95,
            ]),
      );
}
