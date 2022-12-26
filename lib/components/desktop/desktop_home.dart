import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../widgets/widgets.dart";
import "../home/home.dart";

/// The content of the body in the "Home" mode.
class DesktopHome extends StatelessWidget {
  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [DesktopHome] matching the given parameters.
  const DesktopHome({
    super.key,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // FIRST BLOCK ---------------------------------------------------------
        Expanded(
          child: XContainer(
            padding: EdgeInsets.all(3 * XLayout.paddingL),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                XeppelinLogo(
                  size: 8 * XLayout.paddingL,
                ),
              ],
            ),
          ),
        ),

        XLayout.horizontalM,

        // SECOND BLOCK --------------------------------------------------------
        // todo: occuper l'espace en haut à droite avec qqch.
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: Get.height * 0.3),
            child: const HomeDescription(),
          ),
        ),
      ],
    );
  }

// METHODS ===================================================================

}
