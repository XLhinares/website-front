// Framework dependencies
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../widgets/widgets.dart";
import "../home/home.dart";

/// The home tab
class MobileHome extends StatelessWidget {

  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [MobileHome] matching the given parameters.
  const MobileHome({super.key,});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(XLayout.paddingM),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          XeppelinLogo(
            size: Get.width * 0.3,
          ),
          XLayout.verticalM,
          const HomeDescription(),

        ],
      ),
    );
  }

  // METHODS ===================================================================

}
