import "package:flutter/material.dart";
import "package:x_containers/x_containers.dart";

import "../components/components.dart";
import "../widgets/widgets.dart";

/// The
class HomeDesktop extends StatelessWidget {
  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [HomeDesktop] matching the given parameters.
  const HomeDesktop({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // BACKGROUND --------------------------------------------------------
          const Positioned.fill(
            child: AnimatedBackground(
              scale: 0.2,
            ),
          ),

          // MAIN --------------------------------------------------------------
          Positioned.fill(
            child: FrameFit(
              padding: EdgeInsets.all(XLayout.paddingM),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  // TITLE -----------------------------------------------------
                  const Flexible(
                    flex: 3,
                    child: BodyMenu(),
                  ),

                  XLayout.horizontalM,

                  // CONTENTS --------------------------------------------------
                  const Flexible(
                    flex: 8,
                    child: BodyContents(),
                  ),
                ],
              ),
            ),
          ),

          // FLOATING ----------------------------------------------------------
          Positioned.fill(
            bottom: XLayout.paddingM,
            left: XLayout.paddingM,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: SizedBox(),
                ),
                Buttons(),
                XLayout.verticalS,
                const VersionNumber(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
