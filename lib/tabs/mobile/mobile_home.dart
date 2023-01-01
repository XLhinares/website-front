import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../components/components.dart";
import "../../widgets/widgets.dart";

/// The home tab
class MobileHome extends StatelessWidget {
  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [MobileHome] matching the given parameters.
  const MobileHome({
    super.key,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(XLayout.paddingM),
      children: [
        XeppelinLogo(
          size: Get.width * 0.3,
        ),
        XLayout.verticalM,
        const HomeDescription(),
      ],
    );
  }

// METHODS ===================================================================

}
