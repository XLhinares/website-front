// Flutter dependencies
import "package:flutter/material.dart";

// Package dependencies
import "package:x_containers/x_containers.dart";

// Project dependencies
import "package:website_front/widgets/background/animated_background.dart";
import "package:website_front/widgets/body/body_contents.dart";
import "package:website_front/widgets/body/menu/body_menu.dart";
import "package:website_front/widgets/layout/frame_fit.dart";

/// The
class Body extends StatelessWidget {

  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [Body] matching the given parameters.
  const Body({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return FrameFit(
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
          Flexible(
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
    );
  }
}
