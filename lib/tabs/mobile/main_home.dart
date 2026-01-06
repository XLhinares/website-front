import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/dataclass/route.dart";
import "../../components/home/home_description.dart";
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
    return Padding(
      padding: EdgeInsets.all(XLayout.paddingM),
      child: Flex(
        direction: Axis.vertical,
        children: [
          Flexible(
            flex: 3,
            child: XeppelinLogo(
              size: Get.height * 0.25,
            ),
          ),
          Flexible(flex: 1, child: XLayout.verticalL),
          Flexible(
            flex: 6,
            child: Center(
              child: const HomeDescription(
                useMobileSize: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

// METHODS ===================================================================
}
