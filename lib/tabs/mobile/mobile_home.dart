import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../components/exports.dart";
import "../../widgets/exports.dart";

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
          size: Get.height * 0.3,
        ),
        XLayout.verticalM,
        const HomeDescription(),
      ],
    );
  }

// METHODS ===================================================================
}
