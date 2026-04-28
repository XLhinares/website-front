import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../globals.dart";
import "../../utils/extensions.dart";
import "../images/xeppelin_logo.dart";

/// An animated title for the body.
class BodyTitle extends StatelessWidget {
  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [BodyTitle] matching the given parameters.
  const BodyTitle({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    dlog(
        "current route: ${router.currentRoute} (pom: ${router.currentRoute.isPartOfMain})");

    return GestureDetector(
      onTap: () => router.goBack(),
      child: LayoutBuilder(
        builder: (context, constraints) => Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // ANIMATED ICON -------------------------------------------------------
            GetBuilder(
              init: router,
              builder: (_) => AnimatedSize(
                duration: animDurationShort,
                child: AnimatedSwitcher(
                  duration: animDurationShort,
                  child: router.atHome
                      ? const SizedBox()
                      : Padding(
                          padding: EdgeInsets.only(
                            right: XLayout.paddingXS,
                          ),
                          child: router.currentRoute.isPartOfMain
                              ? XeppelinLogo(
                                  size: constraints.maxWidth * .25,
                                  color: context.colors.secondary,
                                )
                              : Icon(
                                  Icons.arrow_back,
                                  size: constraints.maxWidth * .25,
                                  color: context.colors.secondary,
                                ),
                        ),
                ),
              ),
            ),

            // TEXT ----------------------------------------------------------------
            Expanded(
              child: FittedBox(
                alignment: AlignmentGeometry.bottomCenter,
                fit: BoxFit.fitWidth,
                child: Text(
                  "Xeppelin",
                  style: context.textTheme.displayLarge!
                      .copyWith(color: context.colors.onSurface),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
