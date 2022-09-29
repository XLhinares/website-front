import "package:flutter/material.dart";
import "package:x_containers/x_containers.dart";

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
          Positioned.fill(
            child: FrameFit(
            // BACKGROUND ------------------------------------------------------------
            // background: Image.asset("background/skyrider.png",
            //   height: Get.height,
            //   fit: BoxFit.cover,
            // ),
            background: const AnimatedBackground(scale: 0.2,),
            padding: EdgeInsets.all(XLayout.paddingM),
            child: Flex(
              direction: Axis.horizontal,
              children: [

                // TITLE -----------------------------------------------------------
                const Flexible(
                  flex: 3,
                  child: BodyMenu(),
                ),

                XLayout.horizontalM,

                // CONTENTS --------------------------------------------------------
                const Flexible(
                  flex: 8,
                  child: BodyContents(),
                ),

              ],
            ),
          ),
          ),
          Positioned.fill(bottom: 0, left: 0, child: Buttons(),),
        ],
      ),
    );
  }
}
