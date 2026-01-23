import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/dataclass/route.dart";
import "../../components/home/mobile_home_description.dart";
import "../../widgets/body/tab.dart";
import "../../widgets/images/xeppelin_logo.dart";

/// The home tab
class MobileMainHome extends RouteTab {
  // VARIABLES =================================================================

  @override
  final AppRoute route = AppRoute.MAIN_HOME;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [MobileMainHome] matching the given parameters.
  MobileMainHome({
    super.key,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      child: Padding(
        padding: EdgeInsets.all(XLayout.paddingM),
        child: Column(
          children: [
            XLayout.verticalL,
            Expanded(
              child: Center(
                child: XeppelinLogo(
                  size: Get.height * 0.25,
                ),
              ),
            ),
            XLayout.verticalL,
            ConstrainedBox(
                constraints: BoxConstraints(minHeight: Get.height * .5),
                child: const MobileHomeDescription()),
            XLayout.verticalL,
            XLayout.verticalL,
          ],
        ),
      ),
    );
  }

// METHODS ===================================================================
}
