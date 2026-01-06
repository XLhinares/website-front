import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../components/home/home_description.dart";
import "../../widgets/images/xeppelin_logo.dart";

/// The content of the body in the "Home" mode.
class DesktopMainHome extends StatelessWidget {
  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [DesktopMainHome] matching the given parameters.
  const DesktopMainHome({
    super.key,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: XLayout.paddingL),
      child: Row(
        children: [
          // FIRST BLOCK ---------------------------------------------------------
          Expanded(
            child: XContainer(
              padding: EdgeInsets.symmetric(
                vertical: 3 * XLayout.paddingL,
                horizontal: 2 * XLayout.paddingL,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  XeppelinLogo(
                    size: 8 * XLayout.paddingL,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),

          XLayout.horizontalL,

          // SECOND BLOCK --------------------------------------------------------
          // todo: occuper l'espace en haut à droite avec qqch.
          Expanded(
            child: Column(
              children: [
                const Expanded(child: SizedBox()),
                ConstrainedBox(
                  constraints: BoxConstraints(minHeight: Get.height * 0.7),
                  child: const HomeDescription(useMobileSize: false),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

// METHODS ===================================================================
}
